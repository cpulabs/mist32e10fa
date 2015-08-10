
	
`default_nettype none
`include "core.h"
`include "common.h"

module instruction_buffer(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		input wire iEVENT_START,
		//Prev
		input wire iPREV_INST_VALID,
		input wire iPREV_BRANCH_PREDICT,
		input wire [31:0] iPREV_BRANCH_PREDICT_ADDR,
		input wire [31:0] iPREV_INST,
		input wire [31:0] iPREV_PC,
		output wire oPREV_FETCH_STOP,
		output wire oPREV_LOCK,
		//Next
		output wire oNEXT_INST_VALID,
		output wire oNEXT_BRANCH_PREDICT,
		output wire [31:0] oNEXT_BRANCH_PREDICT_ADDR,
		output wire [31:0] oNEXT_INST,
		output wire [31:0] oNEXT_PC,
		input wire iNEXT_LOCK
	);
	
	//Fifo
	wire fifo_full;
	wire fifo_empty;
	wire [4:0] fifo_count;
	
	/*************************************************
	Instruction Buffer
	*************************************************/
	//FIFO Mode				: Show Ahead Synchronous FIFO Mode
	//Width					: 97bit
	//Depth					: 32Word
	//Asynchronous Reset	: Use
	//Synchronous Reset		: Use
	//Usedw					: Use
	//Full					: Use
	//Empty					: Use
	//Almost Full			: 
	//Almost Empty			: 
	//Overflow Checking		: Disable
	//Undesflow Checking	: Disable

	altera_primitive_sync_fifo_showahead_97in_97out_32depth INST_BUFFER(
		.aclr(!inRESET),				//Asynchronous Reset
		.clock(iCLOCK),				//Clock
		.data(
			{
				iPREV_BRANCH_PREDICT, 
				iPREV_BRANCH_PREDICT_ADDR, 
				iPREV_INST, 
				iPREV_PC
			}
		),				//Data-In
		.rdreq(!fifo_empty && !iNEXT_LOCK),				//Read Data Request
		.sclr(iEVENT_START || iRESET_SYNC),				//Synchthronous Reset
		.wrreq(!fifo_full && iPREV_INST_VALID),				//Write Req
		//.almost_empty(),		
		//.almost_full(),
		.empty(fifo_empty),
		.full(fifo_full),
		.q(
			{
				oNEXT_BRANCH_PREDICT, 
				oNEXT_BRANCH_PREDICT_ADDR, 
				oNEXT_INST, 
				oNEXT_PC
			}
		),					//Dataout
		.usedw(fifo_count)
	);

	assign oPREV_LOCK = fifo_full;	
	assign oNEXT_INST_VALID = !fifo_empty && !iNEXT_LOCK;			
	assign oPREV_FETCH_STOP = (fifo_count > 5'h1A)? 1'b1 : 1'b0;
	
	
endmodule
	
`default_nettype wire

