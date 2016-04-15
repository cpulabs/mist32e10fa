

`default_nettype none
`include "core.h"

module pipeline_control_irq_call(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//System Register
		input wire [31:0] iSYSREG_IDTR,
		//Request
		input wire iIRQ_START,
		input wire [6:0] iIRQ_NUM,
		//Finish
		output wire oFINISH,
		output wire [31:0] oFINISH_HUNDLER,
		//Load Store
		output wire oLDST_USE,
		output wire oLDST_REQ,
		input wire iLDST_BUSY,
		output wire [1:0] oLDST_ORDER,	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		output wire oLDST_RW,		//0=Read 1=Write
		output wire [31:0] oLDST_ADDR,
		output wire [31:0] oLDST_DATA,
		input wire iLDST_REQ,
		input wire [31:0] iLDST_DATA
	);

	
	//Hundler Load
	wire hundler_load_finish;
	wire [31:0] hundler_load_hundler;

	//SPR Exchange
	wire spr_exchange_finish;
	wire [31:0] spr_exchange_spr;

	/*****************************************************
	State
	*****************************************************/
	localparam PL_STT_IDLE = 2'h0;
	localparam PL_STT_HUNDLER_GET = 2'h1;
	localparam PL_STT_DONE = 2'h2;

	reg [1:0] state;
	reg [1:0] b_state;
	always@*begin
		case(b_state)
			PL_STT_IDLE:
				begin
					if(iIRQ_START)begin
						state = PL_STT_HUNDLER_GET;
					end
					else begin
						state = b_state;
					end
				end
			PL_STT_HUNDLER_GET:
				begin
					if(hundler_load_finish)begin
						state = PL_STT_DONE;
					end
					else begin
						state = b_state;
					end
				end
			PL_STT_DONE:
				begin
					state = PL_STT_IDLE;
				end
			default:
				begin
					state = PL_STT_IDLE;
				end
		endcase // b_state
	end

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= PL_STT_IDLE;
		end
		else if(iRESET_SYNC)begin
			b_state <= PL_STT_IDLE;
		end
		else begin
			b_state <= state;
		end
	end

	/*
	reg b_finish;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_finish <= PL_STT_IDLE;
		end
		else if(iRESET_SYNC)begin
			b_finish <= PL_STT_IDLE;
		end
		else begin
			b_finish <= state == PL_STT_DONE;
		end
	end
	*/


	/*****************************************************
	Hundler Load
	*****************************************************/
	wire hundler_read_ldst_use;
	wire hundler_read_ldst_req;
	wire [1:0] hundler_read_ldst_order;
	wire hundler_read_ldst_rw;
	wire [31:0] hundler_read_ldst_addr;
	wire [31:0] hundler_read_ldst_data;

	pipeline_control_hundler_read HUNDLER_READ(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//System Register
		.iSYSREG_IDTR(iSYSREG_IDTR),
		//Request
		.iRD_START(b_state == PL_STT_IDLE && iIRQ_START),
		.iRD_IRQ_NUM(iIRQ_NUM),
		.oRD_FINISH(hundler_load_finish),
		.oRD_HUNDLER(hundler_load_hundler),
		//Load Store
		.oLDST_USE(hundler_read_ldst_use),
		.oLDST_REQ(hundler_read_ldst_req),
		.iLDST_BUSY(iLDST_BUSY),
		.oLDST_ORDER(hundler_read_ldst_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oLDST_RW(hundler_read_ldst_rw),		//0=Read 1=Write
		.oLDST_ADDR(hundler_read_ldst_addr),
		.oLDST_DATA(hundler_read_ldst_data),
		.iLDST_REQ(iLDST_REQ),
		.iLDST_DATA(iLDST_DATA)
	);

	/*
	reg [31:0] b_hundler;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_hundler <= 32'h0;
		end
		else if(iRESET_SYNC)begin
			b_hundler <= 32'h0;
		end
		else begin
			if(b_state == PL_STT_HUNDLER_GET && hundler_load_finish)begin
				b_hundler <= hundler_load_hundler;
			end
		end
	end
	*/

	/*****************************************************
	Load Store Pipe
	*****************************************************/
	assign oLDST_USE = hundler_read_ldst_use;
	assign oLDST_REQ = hundler_read_ldst_req;
	assign oLDST_ORDER = hundler_read_ldst_order;
	assign oLDST_RW = hundler_read_ldst_rw;
	assign oLDST_ADDR = hundler_read_ldst_addr;
	assign oLDST_DATA = hundler_read_ldst_data;



	/*****************************************************
	Assign
	*****************************************************/	
	//Out for none-Latency
	assign oFINISH = state == PL_STT_DONE;
	assign oFINISH_HUNDLER = hundler_load_hundler;


endmodule // pipeline_control_irq_call

`default_nettype wire 

