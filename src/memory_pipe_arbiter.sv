
`default_nettype none

module memory_pipe_arbiter(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//Data(Core -> Memory)
		input wire iDATA_REQ,
		output wire oDATA_LOCK,
		input wire [1:0] iDATA_ORDER,
		input wire [3:0] iDATA_MASK,
		input wire iDATA_RW,
		input wire [31:0] iDATA_ADDR,
		input wire [31:0] iDATA_DATA,
		//Data(Memory -> Core)
		output wire oDATA_REQ,
		input wire iDATA_BUSY,
		output wire [63:0] oDATA_DATA,
		//Inst(Core -> Memory)
		input wire iINST_REQ,
		output wire oINST_LOCK,
		input wire [31:0] iINST_ADDR,
		//Inst(Memory -> Core)
		output wire oINST_REQ,
		input wire iINST_BUSY,
		output wire [63:0] oINST_DATA,
		//Memory(OutPort)
		output wire oMEMORY_REQ,
		input wire iMEMORY_LOCK,
		output wire [1:0] oMEMORY_ORDER,
		output wire [3:0] oMEMORY_MASK,
		output wire oMEMORY_RW,
		output wire [31:0] oMEMORY_ADDR,
		output wire [31:0] oMEMORY_DATA,
		//Memory(InPort)
		input wire iMEMORY_VALID,
		output wire oMEMORY_BUSY,
		input wire [63:0] iMEMORY_DATA
	);


	/*********************************************************
	Wire and Register
	*********************************************************/
	//Matching Bridge
	wire matching_bridfe_wr_full;
	wire matching_bridge_rd_valid;
	wire matching_bridge_rd_type;
	//Core -> Memory
	wire mem2core_inst_lock;
	wire mem2core_data_lock;
	wire core2mem_inst_condition;
	wire core2mem_data_condition;
	wire core2mem_data_lock = 1'b0;
	reg b_core2mem_req;
	reg [1:0] b_core2mem_order;
	reg [3:0] b_core2mem_mask;
	reg b_core2mem_rw;
	reg [31:0] b_core2mem_addr;
	reg [31:0] b_core2mem_data;
	//Memory -> Core
	reg b_mem2core_inst_valid;
	reg [63:0] b_mem2core_inst_data;
	reg b_mem2core_data_valid;
	reg [63:0] b_mem2core_data_data;

	//Condition
	wire mem2core_common_lock = matching_bridfe_wr_full || iMEMORY_LOCK;
	wire core2mem_data_write_ack_condition = iDATA_RW && core2mem_data_condition;
	wire core2mem_normal_memory_access_condition = (!iDATA_RW && core2mem_data_condition) || core2mem_inst_condition;

	/*********************************************************
	Memory Matching Controal
	*********************************************************/
	mist32e10fa_arbiter_matching_queue #(16, 4, 1) MEM_MATCHING_QUEUE(	//Queue deep : 16, Queue deep_n : 4, Flag_n : 1
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		//Flash
		.iFLASH(iRESET_SYNC),
		//Write
		.iWR_REQ(!mem2core_common_lock && core2mem_normal_memory_access_condition),
		.iWR_FLAG(core2mem_data_condition),		//0:Inst, 1:Data
		.oWR_FULL(matching_bridfe_wr_full),
		//Read
		.iRD_REQ(iMEMORY_VALID  && (matching_bridge_rd_type && !core2mem_data_lock || !matching_bridge_rd_type && !iINST_BUSY)),
		.oRD_VALID(matching_bridge_rd_valid),
		.oRD_FLAG(matching_bridge_rd_type),		//0:Inst, 1:Data
		.oRD_EMPTY()
	);



	/*********************************************************
	Buffer & Assign(Core -> Memory)
	*********************************************************/
	//assign
	assign mem2core_inst_lock = mem2core_common_lock || core2mem_data_condition;
	assign mem2core_data_lock = mem2core_common_lock || core2mem_inst_condition;
	assign core2mem_inst_condition = !iDATA_REQ && iINST_REQ;
	assign core2mem_data_condition = iDATA_REQ;

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_core2mem_req <= 1'b0;
			b_core2mem_order <= 2'h0;
			b_core2mem_mask <= 4'h0;
			b_core2mem_rw <= 1'b0;
			b_core2mem_addr <= {32{1'b0}};
			b_core2mem_data <= {32{1'b0}};
		end
		else if(iRESET_SYNC)begin
			b_core2mem_req <= 1'b0;
			b_core2mem_order <= 2'h0;
			b_core2mem_mask <= 4'h0;
			b_core2mem_rw <= 1'b0;
			b_core2mem_addr <= {32{1'b0}};
			b_core2mem_data <= {32{1'b0}};
		end
		else begin
			if(!mem2core_common_lock)begin
				//if(b_io_startaddr_valid )
				if(core2mem_data_condition)begin
					b_core2mem_req <= 1'b1;
					b_core2mem_order <= iDATA_ORDER;
					b_core2mem_mask <= iDATA_MASK;
					b_core2mem_rw <= iDATA_RW;
					b_core2mem_addr <= iDATA_ADDR;
					b_core2mem_data <= iDATA_DATA;
				end
				else if(core2mem_inst_condition)begin
					b_core2mem_req <= 1'b1;
					b_core2mem_order <= 2'h2;
					b_core2mem_mask <= 4'hf;
					b_core2mem_rw <= 1'b0;
					b_core2mem_addr <= iINST_ADDR;
					b_core2mem_data <= {32{1'b0}};
				end
				else begin
					b_core2mem_req <= 1'b0;
				end
			end
		end
	end



	/*********************************************************
	Inst Data Selector & Buffer & assign (Memory -> Core)
	*********************************************************/
	//Inst
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_mem2core_inst_valid <= 1'b0;
			b_mem2core_inst_data <= {63{1'b0}};
		end
		else if(iRESET_SYNC)begin
			b_mem2core_inst_valid <= 1'b0;
			b_mem2core_inst_data <= {63{1'b0}};
		end
		else begin
			if(!iINST_BUSY)begin
				b_mem2core_inst_valid <= !matching_bridge_rd_type && matching_bridge_rd_valid && iMEMORY_VALID;
				b_mem2core_inst_data <= iMEMORY_DATA;
			end
		end
	end

	//Data
	assign core2mem_data_lock = 1'b0;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_mem2core_data_valid <= 1'b0;
			b_mem2core_data_data <= {63{1'b0}};
		end
		else if(iRESET_SYNC)begin
			b_mem2core_data_valid <= 1'b0;
			b_mem2core_data_data <= {63{1'b0}};
		end
		else begin
			if(!core2mem_data_lock)begin
				b_mem2core_data_valid <= (matching_bridge_rd_type && matching_bridge_rd_valid && iMEMORY_VALID) || core2mem_data_write_ack_condition;
				b_mem2core_data_data <= iMEMORY_DATA;
			end
		end
	end


	/*********************************************************
	Assign
	*********************************************************/
	assign oDATA_LOCK = mem2core_data_lock;
	assign oINST_LOCK = mem2core_inst_lock;

	assign oMEMORY_REQ = b_core2mem_req;
	assign oMEMORY_ORDER = b_core2mem_order;
	assign oMEMORY_MASK = b_core2mem_mask;
	assign oMEMORY_RW = b_core2mem_rw;
	assign oMEMORY_ADDR = b_core2mem_addr;
	assign oMEMORY_DATA = b_core2mem_data;

	assign oMEMORY_BUSY = iDATA_BUSY || iINST_BUSY;

	assign oDATA_REQ = b_mem2core_data_valid && !core2mem_data_lock;
	assign oDATA_DATA = b_mem2core_data_data;

	assign oINST_REQ = b_mem2core_inst_valid && !iINST_BUSY;
	assign oINST_DATA = b_mem2core_inst_data;

endmodule


`default_nettype wire


