
`default_nettype none	

module peripheral_interface_controller(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		/****************************************
		IO - CPU Connection
		****************************************/
		//Req
		input wire iIO_REQ,
		output wire oIO_BUSY,
		input wire [1:0] iIO_ORDER,				//if (!iIO_RW && iIO_ORDER!=2'h2) then Alignment Fault
		input wire iIO_RW,					//0=Write 1=Read
		input wire [31:0] iIO_ADDR,
		input wire [31:0] iIO_DATA,
		//Output
		output wire oIO_VALID,
		input wire iIO_BUSY,
		output wire [31:0] oIO_DATA,
		//Interrupt
		output wire oIO_INTERRUPT_VALID,
		output wire [5:0] oIO_INTERRUPT_NUM,
		input wire iIO_INTERRUPT_ACK,
		/****************************************
		To GCI Connection
		****************************************/						
		//Request
		output wire oEXTIO_REQ,				//Input
		input wire iEXTIO_BUSY,
		output wire oEXTIO_RW,				//0=Read : 1=Write
		output wire [31:0] oEXTIO_ADDR,
		output wire [31:0] oEXTIO_DATA,
		//Return
		input wire iEXTIO_REQ,				//Output
		output wire oEXTIO_BUSY,
		input wire [31:0] iEXTIO_DATA,
		//Interrupt
		input wire iEXTIO_IRQ_REQ,
		input wire [5:0] iEXTIO_IRQ_NUM,
		output wire oEXTIO_IRQ_ACK						
	);
	
	
	/******************************************************************************************
	Assign
	******************************************************************************************/
	//IRQ Controll
	reg b_irq_state;
	reg b_irq_extio_ack_mask;
	//CPU2IO State
	reg b_cpu_error;		//<- Interrupt Triger
	reg b_cpu_req;
	reg b_cpu_rw;
	reg [31:0] b_cpu_addr;
	reg [31:0] b_cpu_data;
	
	
	/******************************************************************************************
	IRQ Control
	******************************************************************************************/
	localparam L_PARAM_IRQ_STT_IDLE = 1'b0;
	localparam L_PARAM_IRQ_STT_ACK_WAIT = 1'b1;
	
	//Interrupt Controllor
	assign oEXTIO_IRQ_ACK = b_irq_extio_ack_mask && iIO_INTERRUPT_ACK;

	assign oIO_INTERRUPT_VALID = (b_irq_state == L_PARAM_IRQ_STT_IDLE)? iEXTIO_IRQ_REQ : 1'b0;
	assign oIO_INTERRUPT_NUM = iEXTIO_IRQ_NUM;
	
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_irq_state <= L_PARAM_IRQ_STT_IDLE;
			b_irq_extio_ack_mask <= 1'b0;	
		end
		else if(iRESET_SYNC)begin
			b_irq_state <= L_PARAM_IRQ_STT_IDLE;
			b_irq_extio_ack_mask <= 1'b0;	
		end
		else begin
			case(b_irq_state)
				L_PARAM_IRQ_STT_IDLE:
					begin
						b_irq_extio_ack_mask <= 1'b0;
						if(iEXTIO_IRQ_REQ)begin
							b_irq_state <= L_PARAM_IRQ_STT_ACK_WAIT;
							b_irq_extio_ack_mask <= iEXTIO_IRQ_REQ;	
						end
					end
				L_PARAM_IRQ_STT_ACK_WAIT:
					begin
						if(iIO_INTERRUPT_ACK)begin
							b_irq_state <= L_PARAM_IRQ_STT_IDLE;
						end
					end
			endcase
		end
	end
	
	
	
	/******************************************************************************************
	CPU
	******************************************************************************************/
	//CPU -> IO Buffer & Error Check
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_cpu_error <= 1'b0;
			b_cpu_req <= 1'b0;
			b_cpu_rw <= 1'b0;
			b_cpu_addr <= {32{1'b0}};
			b_cpu_data <= {32{1'b0}};
		end
		else if(iRESET_SYNC)begin
			b_cpu_error <= 1'b0;
			b_cpu_req <= 1'b0;
			b_cpu_rw <= 1'b0;
			b_cpu_addr <= {32{1'b0}};
			b_cpu_data <= {32{1'b0}};
		end
		else begin
			if(!iEXTIO_BUSY)begin
				//Error Check
				if(iIO_REQ && iIO_ORDER != 2'h2 && !iIO_RW)begin				
					b_cpu_error <= 1'b1;
					b_cpu_req <= 1'b0;
					b_cpu_rw <= 1'b0;
					b_cpu_addr <= {32{1'b0}};
					b_cpu_data <= {32{1'b0}};
				end
				else begin
					b_cpu_error <= 1'b0;
					b_cpu_req <= iIO_REQ;
					b_cpu_rw <= iIO_RW;
					b_cpu_addr <= iIO_ADDR;
					b_cpu_data <= iIO_DATA;
				end
			end
		end
	end

	/*********************************************************
	Write Ack(Data Pipe)
	*********************************************************/
	//IO
	reg b_io_write_ack;

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_io_write_ack <= 1'b0;
		end
		else begin
			case(b_io_write_ack)
				1'b0:
					begin
						if(!iEXTIO_BUSY && iIO_REQ && iIO_RW)begin
							b_io_write_ack <= 1'b1;
						end
					end
				1'b1:
					begin
						b_io_write_ack <= 1'b0;
					end
			endcase
		end
	end
	
	
	/******************************************************************************************
	Assign
	******************************************************************************************/
	//Connect (This -> CPU)
	assign oIO_BUSY = iEXTIO_BUSY;
	assign oIO_VALID = iEXTIO_REQ || b_io_write_ack;
	assign oIO_DATA = iEXTIO_DATA;
	
	//Connection (This -> GCI)
	assign oEXTIO_REQ = b_cpu_req;
	assign oEXTIO_RW = b_cpu_rw;
	assign oEXTIO_ADDR = b_cpu_addr;
	assign oEXTIO_DATA = b_cpu_data;
	assign oEXTIO_BUSY = iIO_BUSY;
	
endmodule

							
	
`default_nettype wire						

		