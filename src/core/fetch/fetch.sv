

`default_nettype none
`include "core.h"
`include "processor.h"
`include "common.h"

module fetch(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//System Register
		input wire [31:0] iSYSREG_PSR,
		//Exception
		input wire iEVENT_HOLD,
		input wire iEVENT_START,
		input wire iEVENT_END,
		//Pipeline Control - Register Set
		input wire iEVENT_SETREG_PCR_SET,
		input wire [31:0] iEVENT_SETREG_PCR,
		input wire iEXCEPTION_ADDR_SET,
		input wire [31:0] iEXCEPTION_ADDR,
		//Branch Predict
		output wire oBRANCH_PREDICT_FETCH_FLUSH,
		input wire iBRANCH_PREDICT_RESULT_JUMP_INST,
		input wire iBRANCH_PREDICT_RESULT_PREDICT,
		input wire iBRANCH_PREDICT_RESULT_HIT,
		input wire iBRANCH_PREDICT_RESULT_JUMP,
		input wire [31:0] iBRANCH_PREDICT_RESULT_JUMP_ADDR,
		input wire [31:0] iBRANCH_PREDICT_RESULT_INST_ADDR,
		//Previous
		input wire iPREV_INST_VALID,
		input wire [31:0] iPREV_INST,
		output wire oPREV_LOCK,
		//Fetch
		output wire oPREV_FETCH_REQ,
		input wire iPREV_FETCH_LOCK,
		output wire [31:0] oPREV_FETCH_ADDR,
		//Next
		output wire oNEXT_INST_VALID,
		output wire oNEXT_BRANCH_PREDICT,
		output wire [31:0] oNEXT_BRANCH_PREDICT_ADDR,
		output wire [31:0] oNEXT_INST,
		output wire [31:0] oNEXT_PC,
		input wire iNEXT_FETCH_STOP,
		input wire iNEXT_LOCK
	);


	/****************************************
	Register and Wire
	****************************************/
	//Fetch Address Queue
	wire fetch_queue_full;
	wire [31:0] fetch_queue_addr;
	//PC Request
	reg [31:0] b_fetch_addr;
	reg [1:0] b_fetch_state;
	//Next Output Buffer
	reg [31:0] b_next_inst;
	reg b_next_inst_valid;
	reg [31:0] b_pc_out;
	//Branch Predict
	wire branch_predictor_valid;
	wire branch_predictor_predict_branch;
	wire [31:0] branch_predictor_addr;
	wire branch_predictor_flush;
	//Req Control
	wire inst_matching_queue_full;
	wire inst_matching_queue_valid;

	reg [31:0] b_get_addr;

	/****************************************
	State
	****************************************/
	localparam PL_STT_IDLE = 2'h0;
	localparam PL_STT_READ = 2'h1;

	reg [1:0] state;
	reg [1:0] b_state;

	always@*begin
		if(iRESET_SYNC)begin
			state = PL_STT_IDLE;
		end
		else if(iEVENT_END && iEVENT_SETREG_PCR_SET)begin		//Jump
			state = PL_STT_READ;
		end
		else if(iEVENT_START)begin
			state = PL_STT_IDLE;
		end
		else if(iEVENT_HOLD)begin
			state = PL_STT_IDLE;
		end
		else if(branch_predictor_flush)begin					//Branch Predictor - Predict Branch 
			state = PL_STT_IDLE;
		end
		else begin
			case(b_state)
				PL_STT_IDLE:
					begin
						state = PL_STT_READ;
					end
				PL_STT_READ:
					begin
						state = b_state;
					end
				default:
					begin
						state = PL_STT_IDLE;
					end
			endcase
		end
	end


	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= 32'h0;
		end
		else if(iRESET_SYNC)begin
			b_state <= 32'h0;
		end
		else begin
			b_state <= state;
		end
	end //always


	wire fetch_valid = b_state == PL_STT_READ;

	wire fetch_request_condition = !iEVENT_START && !branch_predictor_flush && fetch_valid && !inst_matching_queue_full && !fetch_queue_full && !iPREV_FETCH_LOCK && !iNEXT_FETCH_STOP;

	/****************************************
	Program Counter for Fetch
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_fetch_addr <= 32'h0;
		end
		else if(iRESET_SYNC)begin
			b_fetch_addr <= 32'h0;
		end
		else if(iEVENT_END && iEVENT_SETREG_PCR_SET)begin		//Jump
			b_fetch_addr <= {iEVENT_SETREG_PCR[31:1], 1'b0};
		end
		else if(iEVENT_START)begin
			b_fetch_addr<= 32'h0;
		end
		else if(iEVENT_HOLD)begin
			b_fetch_addr <= b_fetch_addr;
		end
		else if(branch_predictor_flush)begin					//Branch Predict
			b_fetch_addr <= branch_predictor_addr;
		end
		else begin
			if(fetch_request_condition)begin
				b_fetch_addr <= b_fetch_addr + 32'h4;
			end
		end
	end //always


	/****************************************
	Branch Predictor
	****************************************/
	//Branch pick up
	function func_branch_inst_check;
		input [31:0] func_inst;
		begin
			case(func_inst[30:21])
				`OC_BUR,
				`OC_BR,
				`OC_B : func_branch_inst_check = 1'b1;
				default : func_branch_inst_check = 1'b0;
			endcase
		end
	endfunction

	assign branch_predictor_flush = !iNEXT_LOCK && branch_predictor_valid && branch_predictor_predict_branch && !iEVENT_HOLD;

	fetch_branch_predictor BRANCH_PREDICTOR(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		.iFLUSH(1'b0),
		//Search
		.iSEARCH_STB(func_branch_inst_check(iPREV_INST) && iPREV_INST_VALID),
		.iSEARCH_INST_ADDR(/*fetch_queue_addr*/b_get_addr),
		.oSEARCH_VALID(branch_predictor_valid),
		.iSEARCH_LOCK(iNEXT_LOCK),
		.oSRARCH_PREDICT_BRANCH(branch_predictor_predict_branch),
		.oSEARCH_ADDR(branch_predictor_addr),
		//Jump
		.iJUMP_STB(iBRANCH_PREDICT_RESULT_JUMP_INST),
		.iJUMP_PREDICT(iBRANCH_PREDICT_RESULT_PREDICT),
		.iJUMP_HIT(iBRANCH_PREDICT_RESULT_HIT),		//hit address (if not predict or not correct addr is 0)
		.iJUMP_JUMP(iBRANCH_PREDICT_RESULT_JUMP),	//enable predict, if predict miss or not predict is 1
		.iJUMP_ADDR(iBRANCH_PREDICT_RESULT_JUMP_ADDR),
		.iJUMP_INST_ADDR(iBRANCH_PREDICT_RESULT_INST_ADDR)	//Tag[31:5]| Cell Address[4:2] | Byte Order[1:0]
	);


	/****************************************
	Issue & Fetch control
	****************************************/
	//Matching Queue
	mist32e10fa_arbiter_matching_queue #(16, 4, 1) INST_MATCHING_QUEUE(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		//Flash
		.iFLASH(iRESET_SYNC || iEVENT_START || branch_predictor_flush),
		//Write
		.iWR_REQ(oPREV_FETCH_REQ),
		.iWR_FLAG(1'b0),
		.oWR_FULL(inst_matching_queue_full),
		//Read
		.iRD_REQ(iPREV_INST_VALID && !iNEXT_LOCK),
		.oRD_VALID(inst_matching_queue_valid),
		.oRD_FLAG(),
		.oRD_EMPTY()
	);

	/****************************************
	Fetch Address & Flag Queue
	****************************************/
	//FIFO Mode				: Show Ahead Synchronous FIFO Mode
	//Width					: 34bit
	//Depth					: 8Word
	//Asynchronous Reset	: Use
	//Synchronous Reset		: Use
	//Usedw					: Use
	//Full					: Use
	//Empty					: Use
	//Almost Full			: Use(Value=6)
	//Almost Empty			: Use(Value=2)
	//Overflow Checking		: Disable
	//Undesflow Checking	: Disable
	/*
	altera_primitive_sync_fifo_showahead_32in_32out_8depth FETCH_REQ_ADDR_QUEUE(
		.aclr(!inRESET),				//Asynchronous Reset
		.clock(iCLOCK),				//Clock
		.data(b_fetch_addr),				//Data-In
		.rdreq(iPREV_INST_VALID && !iNEXT_LOCK),				//Read Data Request
		.sclr(iRESET_SYNC || iEVENT_START || branch_predictor_flush),				//Synchthronous Reset
		.wrreq(fetch_request_condition),				//Write Req
		.almost_empty(),
		.almost_full(),
		.empty(),
		.full(fetch_queue_full),
		.q(fetch_queue_addr),					//Dataout
		.usedw()
	);
	*/

	assign fetch_queue_full = 1'b0;

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_get_addr <= 32'h0;
		end
		else if(iRESET_SYNC)begin
			b_get_addr <= 32'h0;
		end
		else if(iEVENT_END && iEVENT_SETREG_PCR_SET)begin		//Jump
			b_get_addr <= {iEVENT_SETREG_PCR[31:1], 1'b0};
		end
		else if(iEVENT_START)begin
			b_get_addr<= 32'h0;
		end
		else if(iEVENT_HOLD)begin
			b_get_addr <= b_get_addr;
		end
		else if(branch_predictor_flush)begin					//Branch Predict
			b_get_addr <= branch_predictor_addr;
		end
		else begin
			if(iPREV_INST_VALID && !iNEXT_LOCK && inst_matching_queue_valid)begin
				b_get_addr <= b_get_addr + 32'h4;
			end
		end
	end //always


	/****************************************
	Fetch
	****************************************/
	assign oBRANCH_PREDICT_FETCH_FLUSH = branch_predictor_flush;
	assign oPREV_LOCK = iNEXT_LOCK;

	assign oPREV_FETCH_REQ = fetch_request_condition;
	assign oPREV_FETCH_ADDR	= b_fetch_addr;

	/****************************************
	Previous -> Next
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_next_inst <= {32{1'b0}};
			b_next_inst_valid <= 1'b0;
			b_pc_out <= {32{1'b0}};
		end
		else if(iRESET_SYNC || iEVENT_START || branch_predictor_flush)begin
			b_next_inst <= {32{1'b0}};
			b_next_inst_valid <= 1'b0;
			b_pc_out <= {32{1'b0}};
		end
		else begin
			if(!iNEXT_LOCK)begin
				b_next_inst <= iPREV_INST;
				b_next_inst_valid <= iPREV_INST_VALID && inst_matching_queue_valid;
				b_pc_out <= b_get_addr + 32'h4;//fetch_queue_addr + 32'h4;
			end
		end
	end	//always

	assign oNEXT_INST_VALID = b_next_inst_valid;
	assign oNEXT_INST = b_next_inst;

	
	assign oNEXT_BRANCH_PREDICT = branch_predictor_valid && branch_predictor_predict_branch;
	assign oNEXT_BRANCH_PREDICT_ADDR = branch_predictor_addr;

	assign oNEXT_PC = b_pc_out;


endmodule

`default_nettype wire


