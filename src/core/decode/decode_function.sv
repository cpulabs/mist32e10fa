/****************************************
MIST32 Type - E Common Decoder
Version 1.0.0
****************************************/

`default_nettype none
`include "core.h"

module decode_function(
		//Input
		input wire [31:0] iINSTLUCTION,
		//Info
		output wire oINF_ERROR,
		//
		output wire oDECODE_SOURCE0_ACTIVE,
		output wire oDECODE_SOURCE1_ACTIVE,
		output wire oDECODE_SOURCE0_SYSREG,
		output wire oDECODE_SOURCE1_SYSREG,
		output wire oDECODE_ADV_ACTIVE,
		output wire oDECODE_DESTINATION_SYSREG,
		output wire oDECODE_WRITEBACK,
		output wire oDECODE_FLAGS_WRITEBACK,
		output wire [4:0] oDECODE_CMD,
		output wire [3:0] oDECODE_CC_AFE,
		output wire [4:0] oDECODE_SOURCE0,
		output wire [31:0] oDECODE_SOURCE1,
		output wire [5:0] oDECODE_ADV_DATA,
		output wire oDECODE_SOURCE0_FLAGS,
		output wire oDECODE_SOURCE1_IMM,
		output wire [4:0] oDECODE_DESTINATION,
		output wire oDECODE_EX_SYS_REG,
		output wire oDECODE_EX_SYS_LDST,
		output wire oDECODE_EX_LOGIC,
		output wire oDECODE_EX_SHIFT,
		output wire oDECODE_EX_ADDER,
		output wire oDECODE_EX_MUL,
		output wire oDECODE_EX_LDST,
		output wire oDECODE_EX_BRANCH
	);


	function [75:0]	f_decode;
		input [31:0] f_decode_inst;
		begin
			case(f_decode_inst[30 : 21])
				/*******************
				Integer
				*******************/
				`OC_ADD :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_ADD,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_ADD,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
					end
				`OC_SUB :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_SUB,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_SUB,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
					end
				`OC_MULL :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_MULL,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_MULL,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
					end
				`OC_MULH :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_MULH,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_MULH,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
					end
				`OC_CMP :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_SUB,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_SUB,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
					end
				`OC_UMULL :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_UMULL,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_UMULL,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
					end

				`OC_UMULH :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_UMULH,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_UMULH,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
					end
				`OC_ADDC :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_COUT,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_COUT,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
					end
				`OC_INC	:
					begin
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[4:0],
							/* Source1 */							32'h1,
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_ADDER_ADD,
							/* Execute Module */					`EXE_SELECT_ADDER
						};
					end
				`OC_DEC	:
					begin
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[4:0],
							/* Source1 */							32'h1,
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_ADDER_SUB,
							/* Execute Module */					`EXE_SELECT_ADDER
						};
					end
				`OC_SEXT8 :
					begin		//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_ADDER_SEXT8,
							/* Execute Module */					`EXE_SELECT_ADDER
						};
					end
				`OC_SEXT16 :
					begin		//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_ADDER_SEXT16,
							/* Execute Module */					`EXE_SELECT_ADDER
						};
					end


				`OC_RAND :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_RAND,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_MUL_RAND,
								/* Execute Module */					`EXE_SELECT_MUL
							};
						end
					end

				/*******************
				Shift
				*******************/
				`OC_SHL :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_LOGICL,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_LOGICL,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
					end
				`OC_SHR :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_LOGICR,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_LOGICR,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
					end
				`OC_SAR :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_ALITHMETICR,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b1,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_SHIFT_ALITHMETICR,
								/* Execute Module */					`EXE_SELECT_SHIFT
							};
						end
					end
				/*******************
				Logic
				*******************/
				`OC_AND :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_AND,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_OR :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_OR,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_XOR :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_XOR,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_NOT :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[4:0],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_NOT,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_NAND :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_NAND,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_NOR :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_NOR,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_XNOR :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_XNOR,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_TEST :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b1,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_TEST,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_WL16 :
					begin									//I16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{16{1'b0}}, f_decode_inst[20:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_WBL,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_WH16 :
					begin									//I16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{16{1'b0}}, f_decode_inst[20:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_WBH,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_CLRB :
					begin									//I11
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_CLB,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_SETB :
					begin									//I11
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_STB,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_CLR :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_CLW,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_SET :		
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b1}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_STW,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end

				`OC_REV8 :
					begin									//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[4:0],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_BYTEREV,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end


				`OC_GET8 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LOGIC_GETBYTE,
								/* Execute Module */					`EXE_SELECT_LOGIC
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LOGIC_GETBYTE,
								/* Execute Module */					`EXE_SELECT_LOGIC
							};
						end
					end
				`OC_LIL	:
					begin									//I16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				4'h0,
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{16{1'b0}}, f_decode_inst[20:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_LIL,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_LIH	:
					begin									//I16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				4'h0,
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{f_decode_inst[20:10], f_decode_inst[4:0], {16{1'b0}}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_LIH,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_ULIL	:
					begin									//I16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				4'h0,
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{16{1'b0}}, f_decode_inst[20:10], f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_ULIL,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				/*******************
				Load/Store
				*******************/
				`OC_LD8 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD8,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},				//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD8,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_LD16 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD16,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{20{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0], 1'b0},				//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD16,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_LD32 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD32,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},
								/* Source1 */							{{19{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0], 2'b00},				//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_LD32,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_ST8 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],						//Rd
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST8,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],											//Rd
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST8,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_ST16 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],						//Rd
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST16,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],											//Rd
								/* Source1 */							{{20{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0], 1'b0},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST16,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_ST32 :
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],						//Rd
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST32,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],											//Rd
								/* Source1 */							{{19{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0], 2'b00},		//Rs
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						5'h00,		//Memory
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_LDSW_ST32,
								/* Execute Module */					`EXE_SELECT_LDST
							};
						end
					end
				`OC_PUSH :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],						//Rs
							/* Source1 */							{{27{1'b0}}, `SYSREG_SPR},				//SPR
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b1,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						5'h00,		//Memory
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_LDSW_PUSH,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_POP :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							5'h00,
							/* Source1 */							{{27{1'b0}}, `SYSREG_SPR},				//SPR
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b1,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_POP,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_LDD8 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							{5{1'b0}},
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_LDD8,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_LDD16 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							{5{1'b0}},
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_LDD16,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_LDD32 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							{5{1'b0}},
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},									//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_LDD32,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_STD8 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],						//Rd
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						5'h00,		//Memory
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_STD8,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_STD16 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],						//Rd
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						5'h00,		//Memory
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_STD16,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				`OC_STD32 :
					begin			//O2
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],						//Rd
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},		//Rs
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			f_decode_inst[15:10],
							/* Displacement Data -> ADV Enable */	1'b1,
							/* Destination */						5'h00,		//Memory
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LDSW_STD32,
							/* Execute Module */					`EXE_SELECT_LDST
						};
					end
				/*******************
				Branch
				*******************/
				`OC_BUR :
					begin
						if(!f_decode_inst[20])begin			//JO1
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],//	/* Source0 */							`SYSREG_PC,							//PC
								/* Source1 */							{{27{1'b0}}, f_decode_inst[9:5]},	//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,		//Flag
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,//	/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_BUR,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
						else begin							//JI16
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],//	/* Source0 */							`SYSREG_PC,							//PC
								/* Source1 */							{{14{1'b0}}, f_decode_inst[15:0], 2'h0},	//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,		//Flag
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,//	/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_BUR,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
					end
				`OC_BR :
					begin
						if(!f_decode_inst[20])begin			//JO1
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],//	/* Source0 */							`SYSREG_PC,							//PC
								/* Source1 */							{{27{1'b0}}, f_decode_inst[9:5]},	//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,		//Flag
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,//	/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_BR,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
						else begin							//JI16
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							f_decode_inst[9:5],//	/* Source0 */							`SYSREG_PC,							//PC
								/* Source1 */							{{14{f_decode_inst[15]}}, f_decode_inst[15:0], 2'h0}, //{{16{1'b0}}, f_decode_inst[15:0]},	//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,		//Flag
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,//	/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_BR,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
					end
				`OC_B :
					begin
						if(!f_decode_inst[20])begin			//JO1
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},								//none
								/* Source1 */							{{27{1'b0}}, f_decode_inst[9:5]},		//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,//1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_B,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
						else begin							//JI16
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							{5{1'b0}},								//none
								/* Source1 */							{{14{1'b0}}, f_decode_inst[15:0], 2'b0},		//Rd
								/* Source0 is Flags*/					1'b1,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,//1'b0,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,//1'b0,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PCR,
								/* Writeback Enable */					1'b0,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_BRANCH_B,
								/* Execute Module */					`EXE_SELECT_BRANCH
							};
						end
					end
				`OC_IB :
					begin
					
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							5'h0,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_PCR,
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_BRANCH_INTB,
							/* Execute Module */					`EXE_SELECT_BRANCH
						};
						
//						if(!f_decode_inst[20])begin			//JO1
//							f_decode	=	{
//								/* Decode Error */						1'b0,
//								/* Condition Code & AFE */				f_decode_inst[19:16],
//								/* Source0 */							{5{1'b0}},								//none
//								/* Source1 */							{{27{1'b0}}, f_decode_inst[9:5]},		//Rd
//								/* Source0 is Flags*/					1'b0,
//								/* Source1 is Immediate */				1'b0,
//								/* Source0 Active */					1'b0,
//								/* Source1 Active */					1'b1,
//								/* Source0 is System Register */		1'b0,
//								/* Source1 is System Register */		1'b0,
//								/* Displacement Data -> ADV */			6'h0,
//								/* Displacement Data -> ADV Enable */	1'b0,
//								/* Destination */						`SYSREG_PCR,
//								/* Writeback Enable */					1'b0,
//								/* Writeback Flag Enable */				1'b0,
//								/* Destination is System Register */	1'b1,
//								/* Execute Module Command */			`EXE_BRANCH_INTB,
//								/* Execute Module */					`EXE_SELECT_BRANCH
//							};
//						end
//						else begin							//JI16
//							f_decode	=	{
//								/* Decode Error */						1'b0,
//								/* Condition Code & AFE */				f_decode_inst[19:16],
//								/* Source0 */							{5{1'b0}},								//none
//								/* Source1 */							{{14{1'b0}}, f_decode_inst[15:0], 2'h0},		//Rd
//								/* Source0 is Flags*/					1'b0,
//								/* Source1 is Immediate */				1'b1,
//								/* Source0 Active */					1'b0,
//								/* Source1 Active */					1'b1,
//								/* Source0 is System Register */		1'b0,
//								/* Source1 is System Register */		1'b0,
//								/* Displacement Data -> ADV */			6'h0,
//								/* Displacement Data -> ADV Enable */	1'b0,
//								/* Destination */						`SYSREG_PCR,
//								/* Writeback Enable */					1'b0,
//								/* Writeback Flag Enable */				1'b0,
//								/* Destination is System Register */	1'b1,
//								/* Execute Module Command */			`EXE_BRANCH_INTB,
//								/* Execute Module */					`EXE_SELECT_BRANCH
//							};
//						end
					end
				/*******************
				System Read
				*******************/
				`OC_SRSPR :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_SPR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_LDST_READ_SPR,
							/* Execute Module */					`EXE_SELECT_SYS_LDST
						};
					end
				`OC_SRIEIR :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_PSR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_SR1_IM_R,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPPSR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_PPSR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPPCR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_PPCR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPSR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_PSR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCR:
					begin									//C
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							5'h0,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_FRCR2FRCXR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCLR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_FRCLR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCHR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_FRCHR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPFLAGR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_PFLAGR,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				//FI0R Read
				//FI1R Read

				/*******************
				System Write
				*******************/
				`OC_SRSPW :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_SPR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_LDST_WRITE_SPR,
							/* Execute Module */					`EXE_SELECT_SYS_LDST
						};
					end
				`OC_SRIEIW :
					begin
						if(!f_decode_inst[20])begin			//O1
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							`SYSREG_PSR,
								/* Source1 */							{{27{1'b0}}, f_decode_inst[9:5]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PSR,
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_SYS_REG_SR1_IM_W,
								/* Execute Module */					`EXE_SELECT_SYS_REG
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							`SYSREG_PSR,
								/* Source1 */							{{21{1'b0}}, f_decode_inst[15:10], f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						`SYSREG_PSR,
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b1,
								/* Execute Module Command */			`EXE_SYS_REG_SR1_IM_W,
								/* Execute Module */					`EXE_SELECT_SYS_REG
							};
						end
					end
				`OC_SRPPSW :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_PPSR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPPCW :
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_PPCR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRIDTW:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_IDTR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRPSW:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_PSR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_PS,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCW:
					begin									//C
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							5'h0,
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_FRCR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCLR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_FRCLR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRFRCHR:
					begin									//O1
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_FRCHR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_REG_BUFFER0,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				`OC_SRSPADD :
					begin						//CI16
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							`SYSREG_SPR,
							/* Source1 */							{{14{f_decode_inst[15]}}, f_decode_inst[15:0], 2'h0},//{{16{1'b0}}, f_decode_inst[15:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b1,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b1,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						`SYSREG_SPR,
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b1,
							/* Execute Module Command */			`EXE_SYS_LDST_ADD_SPR,
							/* Execute Module */					`EXE_SELECT_SYS_LDST
						};
					end

				/*******************
				Other
				*******************/
				`OC_NOP :
					begin									//C
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b1,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						{5{1'b0}},
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_ADDER_ADD,
							/* Execute Module */					`EXE_SELECT_ADDER
						};
					end
				`OC_MOVE :
					begin
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b1,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						f_decode_inst[9:5],
							/* Writeback Enable */					1'b1,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_LOGIC_BUFFER1,
							/* Execute Module */					`EXE_SELECT_LOGIC
						};
					end
				`OC_MOVEPC	:
					begin
						if(!f_decode_inst[20])begin			//O2
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							`SYSREG_PCR,
								/* Source1 */							{{27{1'b0}}, f_decode_inst[4:0]},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b0,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_ADD,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
						else begin							//I11
							f_decode	=	{
								/* Decode Error */						1'b0,
								/* Condition Code & AFE */				f_decode_inst[19:16],
								/* Source0 */							`SYSREG_PCR,
								/* Source1 */							{{19{f_decode_inst[15]}}, f_decode_inst[15:10], f_decode_inst[4:0], 2'b0},
								/* Source0 is Flags*/					1'b0,
								/* Source1 is Immediate */				1'b1,
								/* Source0 Active */					1'b1,
								/* Source1 Active */					1'b1,
								/* Source0 is System Register */		1'b1,
								/* Source1 is System Register */		1'b0,
								/* Displacement Data -> ADV */			6'h0,
								/* Displacement Data -> ADV Enable */	1'b0,
								/* Destination */						f_decode_inst[9:5],
								/* Writeback Enable */					1'b1,
								/* Writeback Flag Enable */				1'b0,
								/* Destination is System Register */	1'b0,
								/* Execute Module Command */			`EXE_ADDER_ADD,
								/* Execute Module */					`EXE_SELECT_ADDER
							};
						end
					end
				/*******************
				System Support
				*******************/
				`OC_IDTS :
					begin									//C
						f_decode	=	{
							/* Decode Error */						1'b0,
							/* Condition Code & AFE */				f_decode_inst[19:16],
							/* Source0 */							f_decode_inst[9:5],
							/* Source1 */							{32{1'b0}},
							/* Source0 is Flags*/					1'b0,
							/* Source1 is Immediate */				1'b0,
							/* Source0 Active */					1'b0,
							/* Source1 Active */					1'b0,
							/* Source0 is System Register */		1'b0,
							/* Source1 is System Register */		1'b0,
							/* Displacement Data -> ADV */			6'h0,
							/* Displacement Data -> ADV Enable */	1'b0,
							/* Destination */						{5{1'b0}},
							/* Writeback Enable */					1'b0,
							/* Writeback Flag Enable */				1'b0,
							/* Destination is System Register */	1'b0,
							/* Execute Module Command */			`EXE_SYS_REG_IDTS,
							/* Execute Module */					`EXE_SELECT_SYS_REG
						};
					end
				//Error
				default :
					begin
						f_decode				=		{1'b1, {77{1'b0}}};
						/*
						$display("Instruction Error : Decoder > Not Match Instruction(TIME:%t, Line0 Valid0:%d, Line1 Valid:%d)", $stime, iPREVIOUS_0_INST_VALID, iPREVIOUS_1_INST_VALID);
						*/
					end
			endcase
		end
	endfunction



	assign {
		oINF_ERROR,
		oDECODE_CC_AFE,
		oDECODE_SOURCE0,
		oDECODE_SOURCE1,
		oDECODE_SOURCE0_FLAGS,
		oDECODE_SOURCE1_IMM,
		oDECODE_SOURCE0_ACTIVE,
		oDECODE_SOURCE1_ACTIVE,
		oDECODE_SOURCE0_SYSREG,
		oDECODE_SOURCE1_SYSREG,
		oDECODE_ADV_DATA,
		oDECODE_ADV_ACTIVE,
		oDECODE_DESTINATION,
		oDECODE_WRITEBACK,
		oDECODE_FLAGS_WRITEBACK,
		oDECODE_DESTINATION_SYSREG,
		oDECODE_CMD,
		oDECODE_EX_SYS_REG,
		oDECODE_EX_SYS_LDST,
		oDECODE_EX_LOGIC,
		oDECODE_EX_SHIFT,
		oDECODE_EX_ADDER,
		oDECODE_EX_MUL,
		oDECODE_EX_LDST,
		oDECODE_EX_BRANCH
	} = f_decode(iINSTLUCTION);


endmodule

`default_nettype wire
