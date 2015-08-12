

`default_nettype none
`include "core.h"

module execute_mul(
		input wire [4:0] iCMD,
		//iDATA
		input wire [31:0] iDATA_0,
		input wire [31:0] iDATA_1,
		//oDATA
		output wire [31:0] oDATA,
		output wire [4:0] oFLAGS
	);

	wire [63:0]	mul_tmp;
	wire mul_sf_l;
	wire mul_cf_l;
	wire mul_of_l;
	wire mul_pf_l;
	wire mul_zf_l;
	wire mul_sf_h;
	wire mul_cf_h;
	wire mul_of_h;
	wire mul_pf_h;
	wire mul_zf_h;


	assign mul_tmp = iDATA_0 * iDATA_1;
	assign mul_sf_l = mul_tmp[31];
	assign mul_cf_l = mul_tmp[32];
	assign mul_of_l = mul_tmp[31] ^ mul_tmp[32];
	assign mul_pf_l = mul_tmp[0];
	assign mul_zf_l = (mul_tmp == {64{1'b0}})? 1'b1 : 1'b0;
	assign mul_sf_h = mul_tmp[63];
	assign mul_cf_h = 1'b0;
	assign mul_of_h = 1'b0;
	assign mul_pf_h = mul_tmp[32];
	assign mul_zf_h = (mul_tmp == {64{1'b0}})? 1'b1 : 1'b0;



	/******************************************
	Rand
	******************************************/
	//function 
	wire [31:0] xor_shift = func_xorshift32(iDATA_1);//{iDATA_1[30:0], (iDATA_1[31]^iDATA_1[21]^iDATA_1[1]^iDATA_1[0])};

	function [31:0] func_xorshift32;
		input [31:0] func_seed;
		reg [31:0] func_tmp0;
		reg [31:0] func_tmp1;
		begin
			func_tmp0 = func_seed ^ (func_seed << 13);
			func_tmp1 = func_tmp0 ^ (func_tmp0 >> 17);
			func_xorshift32 = func_tmp1 ^ (func_tmp1 << 5);
		end
	endfunction



	/*
	assign oFLAGS = (iCMD == `EXE_MUL_MULH || iCMD == `EXE_MUL_UMULH)? {mul_sf_h, mul_of_h, mul_cf_h, mul_pf_h, mul_zf_h} : {mul_sf_l, mul_of_l, mul_cf_l, mul_pf_l, mul_zf_l};
	assign oDATA = (iCMD == `EXE_MUL_MULH || iCMD == `EXE_MUL_UMULH)? mul_tmp[63:32] : mul_tmp[31:0];
	*/

	logic [4:0] flags_wire;
	logic [31:0] data_wire;

	always_comb begin
		if(iCMD == `EXE_MUL_MULH || iCMD == `EXE_MUL_UMULH)begin
			flags_wire = {mul_sf_h, mul_of_h, mul_cf_h, mul_pf_h, mul_zf_h};
			data_wire = mul_tmp[63:32];
		end
		else if(iCMD == `EXE_MUL_RAND)begin
			flags_wire = 5'h00; 
			data_wire = xor_shift;
		end
		else begin
			flags_wire = {mul_sf_l, mul_of_l, mul_cf_l, mul_pf_l, mul_zf_l};
			data_wire = mul_tmp[31:0];
		end
	end

	assign oFLAGS = flags_wire;
	assign oDATA = data_wire;

endmodule

`default_nettype wire 


