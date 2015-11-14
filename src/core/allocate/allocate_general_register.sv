
`default_nettype none
`include "processor.h"

module allocate_general_register(
		//System
		input wire iCLOCK,
		//Write Port
		input wire iWR_VALID,
		input wire [4:0] iWR_ADDR,
		input wire [31:0] iWR_DATA,
		//Read Port0
		input wire [4:0] iRD0_ADDR,
		output wire [31:0] oRD0_DATA,
		//Read Port1
		input wire [4:0] iRD1_ADDR,
		output wire [31:0] oRD1_DATA
	);

	reg [31:0] b_ram0[0:31];
	reg [31:0] b_ram1[0:31];


	always@(posedge iCLOCK)begin
		if(iWR_VALID)begin
			b_ram0[iWR_ADDR] <= iWR_DATA;
		end
	end//General Register Write Back

	//RAM1
	always@(posedge iCLOCK)begin
		if(iWR_VALID)begin
			b_ram1[iWR_ADDR] <= iWR_DATA;
		end
	end//General Register Write Back
	
	assign oRD0_DATA = b_ram0[iRD0_ADDR];
	assign oRD1_DATA = b_ram1[iRD1_ADDR];


endmodule // dispatch_general_register

`default_nettype wire
