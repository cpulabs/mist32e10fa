`default_nettype none

module load_store_pipe_arbiter(
		output wire oLDST_REQ,
		input wire iLDST_BUSY,
		output wire [1:0] oLDST_ORDER,	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		output wire [3:0] oLDST_MASK,
		output wire oLDST_RW,		//0=Read 1=Write
		output wire [31:0] oLDST_ADDR,
		output wire [31:0] oLDST_DATA,
		input wire iLDST_VALID,
		input wire iLDST_CACHE_HIT,
		input wire [31:0] iLDST_DATA,
		//Selector
		input wire iUSE_SEL,		//0:Execution | 1:Exception
		//Execution Module
		input wire iEXE_REQ,
		output wire oEXE_BUSY,
		input wire [1:0] iEXE_ORDER,	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		input wire [3:0] iEXE_MASK,
		input wire iEXE_RW,		//0=Read 1=Write
		input wire [31:0] iEXE_ADDR,
		input wire [31:0] iEXE_DATA,
		output wire oEXE_REQ,
		output wire oEXE_CACHE_HIT,
		output wire [31:0] oEXE_DATA,
		//Exception Module
		input wire iEXCEPT_REQ,
		output wire oEXCEPT_BUSY,
		input wire [1:0] iEXCEPT_ORDER,	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		input wire iEXCEPT_RW,		//0=Read 1=Write
		input wire [31:0] iEXCEPT_ADDR,
		input wire [31:0] iEXCEPT_DATA,
		output wire oEXCEPT_REQ,
		output wire [31:0] oEXCEPT_DATA
	);



	//Output Port
	assign oLDST_REQ = (iUSE_SEL)? iEXCEPT_REQ : iEXE_REQ;
	assign oLDST_ORDER = (iUSE_SEL)? iEXCEPT_ORDER : iEXE_ORDER;
	assign oLDST_MASK = (iUSE_SEL)? 4'hf : iEXE_MASK;
	assign oLDST_RW = (iUSE_SEL)? iEXCEPT_RW : iEXE_RW;
	assign oLDST_ADDR = (iUSE_SEL)? iEXCEPT_ADDR : iEXE_ADDR;
	assign oLDST_DATA = (iUSE_SEL)? iEXCEPT_DATA : iEXE_DATA;

	//Exception Unit
	assign oEXCEPT_BUSY	= (iUSE_SEL)? iLDST_BUSY  : 1'b1;
	assign oEXCEPT_REQ = (iUSE_SEL)? iLDST_VALID : 1'b0;
	assign oEXCEPT_DATA	= iLDST_DATA;

	//ALU-LoadStore Unit
	assign oEXE_BUSY = (iUSE_SEL)? 1'b1 : iLDST_BUSY;
	assign oEXE_REQ = (iUSE_SEL)? 1'b0 : iLDST_VALID;
	assign oEXE_CACHE_HIT = iLDST_CACHE_HIT;
	assign oEXE_DATA = iLDST_DATA;


endmodule


`default_nettype wire
