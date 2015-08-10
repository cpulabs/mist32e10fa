
`default_nettype none
`include "processor.h"

module allocate_general_register(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
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

	integer i;

	reg [31:0] b_ram0[0:31];
	reg [31:0] b_ram1[0:31];

	//RAM0
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			for(i = 0; i < 32; i = i + 1)begin
				b_ram0[i] <= 32'h0;
			end
		end
		else if(iRESET_SYNC)begin
			for(i = 0; i < 32; i = i + 1)begin
				b_ram0[i] <= 32'h0;
			end
		end
		else begin
			if(iWR_VALID)begin
				b_ram0[iWR_ADDR] <= iWR_DATA;
			end
		end
	end//General Register Write Back

	//RAM1
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			for(i = 0; i < 32; i = i + 1)begin
				b_ram1[i] <= 32'h0;
			end
		end
		else if(iRESET_SYNC)begin
			for(i = 0; i < 32; i = i + 1)begin
				b_ram1[i] <= 32'h0;
			end
		end
		else begin
			if(iWR_VALID)begin
				b_ram1[iWR_ADDR] <= iWR_DATA;
			end
		end
	end//General Register Write Back


	assign oRD0_DATA = b_ram0[iRD0_ADDR];
	assign oRD1_DATA = b_ram1[iRD1_ADDR];


endmodule // dispatch_general_register

`default_nettype wire
