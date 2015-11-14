
`include "core.h"
`include "processor.h"
`include "common.h"
`default_nettype none


module allocate #(
		parameter CORE_ID = 0
	)(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//Event Control
		input wire iEVENT_HOLD,
		input wire iEVENT_START,
		input wire iEVENT_IRQ_FRONT2BACK,
		input wire iEVENT_IRQ_BACK2FRONT,
		input wire iEVENT_END,
		//FI0R Set
		input wire iEVENT_SETREG_FI0R_SET,
		input wire iEVENT_SETREG_FI1R_SET,
		input wire iEVENT_SETREG_PPCR_SET,
		input wire iEVENT_SETREG_PCR_SET,
		input wire [31:0] iEVENT_SETREG_FI0R,
		input wire [31:0] iEVENT_SETREG_FI1R,
		input wire [31:0] iEVENT_SETREG_PPCR,
		input wire [31:0] iEVENT_SETREG_PCR,
		//System Register Input
		input wire [31:0] iSYSREG_FLAGR,
		//System Register Output
		output wire [31:0] oSYSREG_PCR,
		output wire [31:0] oSYSREG_IDTR,
		output wire [31:0] oSYSREG_PSR,
		output wire [31:0] oSYSREG_PPSR,
		output wire [31:0] oSYSREG_PPCR,
		output wire [31:0] oSYSREG_SPR,
		output wire [31:0] oSYSREG_PFLAGR,
		//Pipeline
		input wire iPREV_VALID,
		input wire iPREV_BRANCH_PREDICT,
		input wire [31:0] iPREV_BRANCH_PREDICT_ADDR,
		input wire iPREV_SOURCE0_ACTIVE,
		input wire iPREV_SOURCE1_ACTIVE,
		input wire iPREV_SOURCE0_SYSREG,
		input wire iPREV_SOURCE1_SYSREG,
		input wire iPREV_ADV_ACTIVE,
		input wire iPREV_DESTINATION_SYSREG,
		input wire [4:0] iPREV_DESTINATION,
		input wire iPREV_WRITEBACK,
		input wire iPREV_FLAGS_WRITEBACK,
		input wire [4:0] iPREV_CMD,
		input wire [3:0] iPREV_CC_AFE,
		input wire [4:0] iPREV_SOURCE0,
		input wire [31:0] iPREV_SOURCE1,
		input wire [5:0] iPREV_ADV_DATA,
		input wire iPREV_SOURCE0_FLAGS,
		input wire iPREV_SOURCE1_IMM,
		input wire iPREV_EX_SYS_REG,
		input wire iPREV_EX_SYS_LDST,
		input wire iPREV_EX_LOGIC,
		input wire iPREV_EX_SHIFT,
		input wire iPREV_EX_ADDER,
		input wire iPREV_EX_MUL,
		input wire iPREV_EX_LDST,
		input wire iPREV_EX_BRANCH,
		input wire [31:0] iPREV_PC,
		output wire oPREV_LOCK,
		//Next
		output wire oNEXT_VALID,
		output wire oNEXT_BRANCH_PREDICT,
		output wire [31:0] oNEXT_BRANCH_PREDICT_ADDR,
		output wire [31:0] oNEXT_SYSREG_PSR,
		output wire [63:0] oNEXT_SYSREG_FRCR,
		output wire oNEXT_DESTINATION_SYSREG,
		output wire [4:0] oNEXT_DESTINATION,
		output wire oNEXT_WRITEBACK,
		output wire oNEXT_FLAGS_WRITEBACK,
		output wire [4:0] oNEXT_CMD,
		output wire [3:0] oNEXT_CC_AFE,
		output wire [31:0] oNEXT_SPR,
		output wire [31:0] oNEXT_SOURCE0,
		output wire [31:0] oNEXT_SOURCE1,
		output wire [5:0] oNEXT_ADV_DATA,
		output wire [4:0] oNEXT_SOURCE0_POINTER,
		output wire [4:0] oNEXT_SOURCE1_POINTER,
		output wire oNEXT_SOURCE0_SYSREG,
		output wire oNEXT_SOURCE1_SYSREG,
		output wire oNEXT_SOURCE1_IMM,
		output wire oNEXT_SOURCE0_FLAGS,
		output wire oNEXT_ADV_ACTIVE,
		output wire oNEXT_EX_SYS_REG,
		output wire oNEXT_EX_SYS_LDST,
		output wire oNEXT_EX_LOGIC,
		output wire oNEXT_EX_SHIFT,
		output wire oNEXT_EX_ADDER,
		output wire oNEXT_EX_MUL,
		output wire oNEXT_EX_LDST,
		output wire oNEXT_EX_BRANCH,
		output wire [31:0] oNEXT_PC,
		input wire iNEXT_LOCK,
		//Write Back
		input wire iWB_VALID,
		input wire [31:0] iWB_DATA,
		input wire [4:0] iWB_DESTINATION,
		input wire iWB_DESTINATION_SYSREG,
		input wire iWB_WRITEBACK,
		input wire iWB_SPR_WRITEBACK,
		input wire [31:0] iWB_SPR,
		input wire [63:0] iWB_FRCR,
		input wire [31:0] iWB_PC
	);

	//System Register
	wire w_sysreg_pcr_register_valid;
	wire [31:0] w_sysreg_pcr_register_data;
	wire [31:0] w_sysreg_pcr_info_data;
	wire w_sysreg_psr_register_valid;
	wire [31:0] w_sysreg_psr_register_data;
	wire [31:0] w_sysreg_psr_info_data;
	wire w_sysreg_spr_register_valid;
	wire [31:0] w_sysreg_spr_register_data;
	wire [31:0] w_sysreg_spr_info_data;
	wire w_sysreg_idtr_register_valid;
	wire [31:0] w_sysreg_idtr_register_data;
	wire [31:0] w_sysreg_idtr_info_data;
	wire [31:0] w_sysreg_fi0r_info_data;
	wire [31:0] w_sysreg_fi1r_info_data;
	wire w_sysreg_ppcr_register_valid;
	wire [31:0] w_sysreg_ppcr_register_data;
	wire [31:0] w_sysreg_ppcr_info_data;
	wire w_sysreg_pflagr_register_valid;
	wire [31:0] w_sysreg_pflagr_register_data;
	wire [31:0] w_sysreg_pflagr_info_data;
	wire w_sysreg_ppsr_register_valid;
	wire [31:0] w_sysreg_ppsr_register_data;
	wire [31:0] w_sysreg_ppsr_info_data;
	wire w_sysreg_frclr_register_valid;
	wire [31:0] w_sysreg_frclr_register_data;
	wire w_sysreg_frchr_register_valid;
	wire [31:0] w_sysreg_frchr_register_data;
	wire [31:0] w_sysreg_frclr_info_data;
	wire [31:0] w_sysreg_frchr_info_data;

	
	/*************************************************************************************
	Current Register Assignment
	*************************************************************************************/
	wire writeback_source0_valid, writeback_source1_valid;
	wire [31:0] writeback_source0, writeback_source1;

	assign {writeback_source0_valid, writeback_source0} = func_writeback_set(
		iPREV_SOURCE0[4:0],
		iPREV_SOURCE0_SYSREG,
		//Writeback
		iWB_VALID,
		iWB_DATA,
		iWB_DESTINATION,
		iWB_DESTINATION_SYSREG,
		iWB_WRITEBACK,
		iWB_SPR_WRITEBACK,
		iWB_SPR,
		iWB_PC
	);

	assign {writeback_source1_valid, writeback_source1} = func_writeback_set(
		iPREV_SOURCE1[4:0],
		iPREV_SOURCE1_SYSREG,
		//Writeback
		iWB_VALID,
		iWB_DATA,
		iWB_DESTINATION,
		iWB_DESTINATION_SYSREG,
		iWB_WRITEBACK,
		iWB_SPR_WRITEBACK,
		iWB_SPR,
		iWB_PC
	);


	function [32:0] func_writeback_set;
		//Select
		input [4:0] func_register;
		input func_sysreg;
		/*******Writeback*******/
		input func_wb_valid;
		input [31:0] func_wb_data;
		input [4:0] func_wb_destination;
		input func_wb_destination_sysreg;
		input func_wb_writeback;
		input func_wb_spr_writeback;
		input [31:0] func_wb_spr;
		input [31:0] func_wb_pc;
		begin
			if(func_wb_valid)begin
				if(func_sysreg)begin
					if(func_wb_destination_sysreg)begin
						if(func_register == `SYSREG_PCR)begin
							func_writeback_set = {1'b1, func_wb_pc};
						end
						else if(func_register == `SYSREG_SPR && func_wb_spr_writeback)begin
							func_writeback_set = {1'b1, func_wb_spr};
						end
						else if(func_register == func_wb_destination && func_wb_writeback)begin
							func_writeback_set = {1'b1, func_wb_data};
						end
						else begin
							func_writeback_set = {1'b0, 32'h0};
						end
					end
					else begin
						func_writeback_set = {1'b0, 32'h0};
					end
				end
				else begin
					if(func_register == func_wb_destination && !func_wb_destination_sysreg && func_wb_writeback)begin
						func_writeback_set = {1'b1, func_wb_data};
					end
					else begin
						func_writeback_set = {1'b0, 32'h0};
					end
				end
			end
			else begin
				func_writeback_set = {1'b0, 32'h0};
			end
		end
	endfunction


	wire sysreg_source0_valid, sysreg_source1_valid;
	wire [31:0] sysreg_source0, sysreg_source1;

	assign {sysreg_source0_valid, sysreg_source0} = func_sysreg_set(
		iPREV_SOURCE0_ACTIVE,
		iPREV_SOURCE0[4:0],
		iPREV_PC - 32'h4,
		w_sysreg_spr_info_data,
		w_sysreg_psr_info_data,
		w_sysreg_idtr_info_data,
		w_sysreg_ppsr_info_data,
		w_sysreg_ppcr_info_data,
		w_sysreg_frclr_info_data,
		w_sysreg_frchr_info_data,
		w_sysreg_fi0r_info_data,
		w_sysreg_fi1r_info_data
	);

	assign {sysreg_source1_valid, sysreg_source1} = func_sysreg_set(
		iPREV_SOURCE1_ACTIVE,
		iPREV_SOURCE1[4:0],
		iPREV_PC - 32'h4,
		w_sysreg_spr_info_data,
		w_sysreg_psr_info_data,
		w_sysreg_idtr_info_data,
		w_sysreg_ppsr_info_data,
		w_sysreg_ppcr_info_data,
		w_sysreg_frclr_info_data,
		w_sysreg_frchr_info_data,
		w_sysreg_fi0r_info_data,
		w_sysreg_fi1r_info_data
	);

	function [32:0] func_sysreg_set;
		//Active
		input func_active;
		//Select
		input [4:0] func_sysreg;
		//Sysreg
		input [31:0] func_pcr;
		input [31:0] func_spr;
		input [31:0] func_psr;
		input [31:0] func_idtr;
		input [31:0] func_ppsr;
		input [31:0] func_ppcr;
		input [31:0] func_frclr;
		input [31:0] func_frchr;
		input [31:0] func_fi0r;
		input [31:0] func_fi1r;
		begin
			if(func_active)begin
				case(func_sysreg)
					`SYSREG_PCR : func_sysreg_set = {1'b1, func_pcr};
					`SYSREG_SPR : func_sysreg_set = {1'b1, func_spr};
					`SYSREG_PSR : func_sysreg_set = {1'b1, func_psr};
					`SYSREG_IDTR : func_sysreg_set = {1'b1, func_idtr};
					`SYSREG_PPSR : func_sysreg_set = {1'b1, func_ppsr};
					`SYSREG_PPCR : func_sysreg_set = {1'b1, func_ppcr};
					`SYSREG_FRCLR : func_sysreg_set = {1'b1, func_frclr};
					`SYSREG_FRCHR : func_sysreg_set = {1'b1, func_frchr};
					`SYSREG_FI0R : func_sysreg_set = {1'b1, func_fi0r};
					`SYSREG_FI1R : func_sysreg_set = {1'b1, func_fi1r};
					default	:
						begin
							func_sysreg_set = {1'b0, 32'h0};
						end
				endcase
			end
			else begin
				func_sysreg_set = {1'b0, 27'h0, func_sysreg};
			end
		end
	endfunction
	
	/*************************************************************************************
	General Register File
	*************************************************************************************/
	wire [31:0] gr_r_data0;
	wire [31:0] gr_r_data1;

	allocate_general_register GRF(
		//System
		.iCLOCK(iCLOCK),
		//Write Port
		.iWR_VALID(iWB_VALID && !iWB_DESTINATION_SYSREG && iWB_WRITEBACK && !iEVENT_HOLD),
		.iWR_ADDR(iWB_DESTINATION),
		.iWR_DATA(iWB_DATA),
		//Read Port0
		.iRD0_ADDR(iPREV_SOURCE0[4:0]),
		.oRD0_DATA(gr_r_data0),
		//Read Port1
		.iRD1_ADDR(iPREV_SOURCE1[4:0]),
		.oRD1_DATA(gr_r_data1)
	);

	/*************************************************************************************
	System Registers
	*************************************************************************************/
	//FLAGR : Renaming System Register -> Execute Stage

	//PCR
	allocate_system_register PCR(
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_pcr_register_valid),
		.iREGIST_DATA(w_sysreg_pcr_register_data),
		.oINFO_DATA(w_sysreg_pcr_info_data)
	);
	assign w_sysreg_pcr_register_valid = (iWB_VALID && !iEVENT_HOLD) || (iEVENT_SETREG_PCR_SET || iEVENT_END);
	assign w_sysreg_pcr_register_data = (iEVENT_SETREG_PCR_SET || iEVENT_END)? iEVENT_SETREG_PCR : iWB_PC;

	//PSR : Program Status Register
	allocate_system_register PSR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_psr_register_valid), 
		.iREGIST_DATA(w_sysreg_psr_register_data),
		.oINFO_DATA(w_sysreg_psr_info_data)
	);
	assign w_sysreg_psr_register_valid = iEVENT_IRQ_FRONT2BACK || iEVENT_IRQ_BACK2FRONT || (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_PSR);
	assign w_sysreg_psr_register_data = (iEVENT_IRQ_FRONT2BACK)? {w_sysreg_psr_info_data[31:7], 2'h0, w_sysreg_psr_info_data[4:3], 1'b0, w_sysreg_psr_info_data[1:0]} : (
															(iEVENT_IRQ_BACK2FRONT)? w_sysreg_ppsr_info_data : iWB_DATA
														);

	//SPR
	allocate_system_register SPR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_spr_register_valid), 
		.iREGIST_DATA(w_sysreg_spr_register_data),
		.oINFO_DATA(w_sysreg_spr_info_data)
	);
	assign w_sysreg_spr_register_valid = ((!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_SPR) || !iEVENT_HOLD && iWB_SPR_WRITEBACK && iWB_VALID);
	assign w_sysreg_spr_register_data = (!iEVENT_HOLD && iWB_SPR_WRITEBACK && iWB_VALID)? iWB_SPR : iWB_DATA;


	//IDTR
	allocate_system_register IDTR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_idtr_register_valid), 
		.iREGIST_DATA(w_sysreg_idtr_register_data),
		.oINFO_DATA(w_sysreg_idtr_info_data)
	);
	assign w_sysreg_idtr_register_valid = !iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_IDTR;
	assign w_sysreg_idtr_register_data = iWB_DATA;

	//FI0R
	allocate_system_register FI0R (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(iEVENT_SETREG_FI0R_SET), 
		.iREGIST_DATA(iEVENT_SETREG_FI0R),
		.oINFO_DATA(w_sysreg_fi0r_info_data)
	);

	//FI1R
	allocate_system_register FI1R (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(iEVENT_SETREG_FI1R_SET), 
		.iREGIST_DATA(iEVENT_SETREG_FI1R),
		.oINFO_DATA(w_sysreg_fi1r_info_data)
	);

	//PPSR : Previous Program Status Register
	allocate_system_register PPSR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_ppsr_register_valid), 
		.iREGIST_DATA(w_sysreg_ppsr_register_data),
		.oINFO_DATA(w_sysreg_ppsr_info_data)
	);
	assign w_sysreg_ppsr_register_valid = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_PPSR) || iEVENT_IRQ_FRONT2BACK;
	assign w_sysreg_ppsr_register_data = (iEVENT_IRQ_FRONT2BACK)? w_sysreg_psr_info_data : iWB_DATA;


	//PPCR : Previous Program Counter
	allocate_system_register PPCR(
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_ppcr_register_valid), 
		.iREGIST_DATA(w_sysreg_ppcr_register_data),
		.oINFO_DATA(w_sysreg_ppcr_info_data)
	);
	assign w_sysreg_ppcr_register_valid = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_PPCR) || (iEVENT_SETREG_PPCR_SET && iEVENT_END);
	assign w_sysreg_ppcr_register_data = (iEVENT_SETREG_PPCR_SET && iEVENT_END)? iEVENT_SETREG_PPCR : iWB_DATA;

	//PFLAGR : Previous Flag Register
	allocate_system_register PFLAGR(
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_pflagr_register_valid),
		.iREGIST_DATA(w_sysreg_pflagr_register_data),
		.oINFO_DATA(w_sysreg_pflagr_info_data)
	);
	assign w_sysreg_pflagr_register_valid	 = iEVENT_IRQ_FRONT2BACK;		//iEVENT_IRQ_FRONT2BACK;
	assign w_sysreg_pflagr_register_data = iSYSREG_FLAGR;

	//FRCR
	wire frcr_64bit_write_condition;
	wire [63:0] frcr_64bit_timer;
	assign frcr_64bit_write_condition = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCR);


	allocate_frcr_timer FRCR(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		.iWR_ENA(frcr_64bit_write_condition),
		.iRW_COUNTER({w_sysreg_frchr_info_data, w_sysreg_frclr_info_data}),
		.oCOUNTER(frcr_64bit_timer)
	);

	//FRCLR
	allocate_system_register FRCLR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_frclr_register_valid),
		.iREGIST_DATA(w_sysreg_frclr_register_data),
		.oINFO_DATA(w_sysreg_frclr_info_data)
	);

	assign w_sysreg_frclr_register_valid = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCLR) ||
														(!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCR2FRCXR);
	assign w_sysreg_frclr_register_data = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCLR)? iWB_DATA : /*frcr_64bit_timer*/iWB_FRCR[31:0];

	//FRCHR
	allocate_system_register FRCHR (
		.iCLOCK(iCLOCK), 
		.inRESET(inRESET), 
		.iRESET_SYNC(iRESET_SYNC),
		.iREGIST_DATA_VALID(w_sysreg_frchr_register_valid),
		.iREGIST_DATA(w_sysreg_frchr_register_data),
		.oINFO_DATA(w_sysreg_frchr_info_data)
	);


	assign w_sysreg_frchr_register_valid = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCHR) ||
														(!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCR2FRCXR);
	assign w_sysreg_frchr_register_data = (!iEVENT_HOLD && iWB_VALID && iWB_DESTINATION_SYSREG && iWB_WRITEBACK && iWB_DESTINATION == `SYSREG_FRCHR)? iWB_DATA : /*frcr_64bit_timer*/iWB_FRCR[63:32];


	/*************************************************************************************
	Pipline Stage
	*************************************************************************************/
	reg b_valid;
	reg b_branch_predict;
	reg [31:0] b_branch_predict_addr;
	reg b_destination_sysreg;
	reg [4:0] b_destination;
	reg b_writeback;
	reg b_flag_writeback;
	reg [4:0] b_cmd;
	reg [3:0] b_cc_afe;
	reg [31:0] b_source0;
	reg [31:0] b_source1;
	reg [5:0] b_adv_data;
	reg [4:0] b_source0_pointer;
	reg [4:0] b_source1_pointer;
	reg b_source0_sysreg;
	reg b_source1_sysreg;
	reg b_source1_imm;
	reg b_source0_flags;
	reg b_adv_active;
	reg b_ex_sys_reg;
	reg b_ex_sys_ldst;
	reg b_ex_logic;
	reg b_ex_shift;
	reg b_ex_adder;
	reg b_ex_mul;
	reg b_ex_ldst;
	reg b_ex_branch;
	reg [31:0] b_pc;


	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_valid <= 1'b0;
			b_branch_predict <= 1'B0;
			b_branch_predict_addr <= 32'h0;
			b_destination_sysreg <= 1'b0;
			b_destination <= 5'h0;
			b_writeback <= 1'b0;
			b_flag_writeback <= 1'b0;
			b_cmd <= 5'h0;
			b_cc_afe <= 4'h0;
			b_adv_data <= 6'h0;
			b_source0_pointer <= 5'h0;
			b_source1_pointer <= 5'h0;
			b_source0_sysreg <= 1'b0;
			b_source1_sysreg <= 1'b0;
			b_source1_imm <= 1'b0;
			b_source0_flags <= 1'b0;
			b_adv_active <= 1'b0;
			b_ex_sys_reg <= 1'b0;
			b_ex_sys_ldst <= 1'b0;
			b_ex_logic <= 1'b0;
			b_ex_shift <= 1'b0;
			b_ex_adder <= 1'b0;
			b_ex_mul <= 1'b0;
			b_ex_ldst <= 1'b0;
			b_ex_branch <= 1'b0;
			b_pc <= 32'h0;
		end
		else if(iRESET_SYNC || iEVENT_START)begin
			b_valid <= 1'b0;
			b_branch_predict <= 1'b0;
			b_branch_predict_addr <= 32'h0;
			b_destination_sysreg <= 1'b0;
			b_destination <= 5'h0;
			b_writeback <= 1'b0;
			b_flag_writeback <= 1'b0;
			b_cmd <= 5'h0;
			b_cc_afe <= 4'h0;
			b_adv_data <= 6'h0;
			b_source0_pointer <= 5'h0;
			b_source1_pointer <= 5'h0;
			b_source0_sysreg <= 1'b0;
			b_source1_sysreg <= 1'b0;
			b_source1_imm <= 1'b0;
			b_source0_flags <= 1'b0;
			b_adv_active <= 1'h0;
			b_ex_sys_reg <= 1'b0;
			b_ex_sys_ldst <= 1'b0;
			b_ex_logic <= 1'b0;
			b_ex_shift <= 1'b0;
			b_ex_adder <= 1'b0;
			b_ex_mul <= 1'b0;
			b_ex_ldst <= 1'b0;
			b_ex_branch <= 1'b0;
			b_pc <= 32'h0;
		end
		else begin
			if(!iNEXT_LOCK)begin
				b_valid <= iPREV_VALID;//latch_condition;
				b_branch_predict <= iPREV_BRANCH_PREDICT;
				b_branch_predict_addr <= iPREV_BRANCH_PREDICT_ADDR;
				b_destination_sysreg <= iPREV_DESTINATION_SYSREG;
				b_destination <= iPREV_DESTINATION;
				b_writeback <= iPREV_WRITEBACK;
				b_flag_writeback <= iPREV_FLAGS_WRITEBACK;
				b_cmd <= iPREV_CMD;
				b_cc_afe <= iPREV_CC_AFE;
				b_adv_data <= iPREV_ADV_DATA;
				b_source0_pointer <= iPREV_SOURCE0;
				b_source1_pointer <= iPREV_SOURCE1[4:0];
				b_source0_sysreg <= iPREV_SOURCE0_SYSREG;
				b_source1_sysreg <= iPREV_SOURCE1_SYSREG;
				b_source1_imm <= iPREV_SOURCE1_IMM;
				b_source0_flags <= iPREV_SOURCE0_FLAGS;
				b_adv_active <= iPREV_ADV_ACTIVE;
				b_ex_sys_reg <= iPREV_EX_SYS_REG;
				b_ex_sys_ldst <= iPREV_EX_SYS_LDST;
				b_ex_logic <= iPREV_EX_LOGIC;
				b_ex_shift <= iPREV_EX_SHIFT;
				b_ex_adder <= iPREV_EX_ADDER;
				b_ex_mul <= iPREV_EX_MUL;
				b_ex_ldst <= iPREV_EX_LDST;
				b_ex_branch <= iPREV_EX_BRANCH;
				b_pc <= iPREV_PC;
			end
		end
	end


	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_source0 <= 32'h0;
		end
		else if(iRESET_SYNC || iEVENT_START)begin
			b_source0 <= 32'h0;
		end
		else begin
			if(!iNEXT_LOCK)begin
				if(writeback_source0_valid)begin
					b_source0 <= writeback_source0;
				end
				else begin
					b_source0 <= (sysreg_source0_valid && iPREV_SOURCE0_SYSREG)? sysreg_source0 : gr_r_data0;
				end
			end
		end
	end

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_source1 <= 32'h0;
		end
		else if(iRESET_SYNC || iEVENT_START)begin
			b_source1 <= 32'h0;
		end
		else begin
			if(!iNEXT_LOCK)begin
				if(writeback_source1_valid && !iPREV_SOURCE1_IMM)begin
					b_source1 <= writeback_source1;
				end
				else begin
					if(iPREV_SOURCE1_IMM)begin
						b_source1 <= iPREV_SOURCE1;
					end
					else begin
						if(sysreg_source1_valid && iPREV_SOURCE1_SYSREG)begin
							b_source1 <= sysreg_source1;
						end
						else begin
							b_source1 <= gr_r_data1;
						end
					end
				end
			end
		end
	end

	
	
	/*************************************************************************************
	Assign
	*************************************************************************************/
	assign oNEXT_VALID = b_valid && !iNEXT_LOCK;
	assign oNEXT_BRANCH_PREDICT = b_branch_predict;
	assign oNEXT_BRANCH_PREDICT_ADDR = b_branch_predict_addr;
	assign oNEXT_SYSREG_PSR = w_sysreg_psr_info_data;
	assign oNEXT_SYSREG_FRCR = frcr_64bit_timer;
	assign oNEXT_DESTINATION_SYSREG	= b_destination_sysreg;
	assign oNEXT_DESTINATION = b_destination;
	assign oNEXT_WRITEBACK = b_writeback;
	assign oNEXT_FLAGS_WRITEBACK = b_flag_writeback;
	assign oNEXT_CMD = b_cmd;
	assign oNEXT_CC_AFE = b_cc_afe;
	assign oNEXT_SPR = w_sysreg_spr_info_data;
	assign oNEXT_SOURCE0 = b_source0;
	assign oNEXT_SOURCE1 = b_source1;
	assign oNEXT_ADV_DATA = b_adv_data;
	assign oNEXT_SOURCE0_POINTER = b_source0_pointer;
	assign oNEXT_SOURCE1_POINTER = b_source1_pointer;
	assign oNEXT_SOURCE0_SYSREG = b_source0_sysreg;
	assign oNEXT_SOURCE1_SYSREG = b_source1_sysreg;
	assign oNEXT_SOURCE1_IMM = b_source1_imm;
	assign oNEXT_SOURCE0_FLAGS = b_source0_flags;
	assign oNEXT_ADV_ACTIVE = b_adv_active;
	assign oNEXT_EX_SYS_REG = b_ex_sys_reg;
	assign oNEXT_EX_SYS_LDST = b_ex_sys_ldst;
	assign oNEXT_EX_LOGIC = b_ex_logic;
	assign oNEXT_EX_SHIFT = b_ex_shift;
	assign oNEXT_EX_ADDER = b_ex_adder;
	assign oNEXT_EX_MUL = b_ex_mul;
	assign oNEXT_EX_LDST = b_ex_ldst;
	assign oNEXT_EX_BRANCH = b_ex_branch;
	assign oNEXT_PC = b_pc;
	//System Register
	assign oSYSREG_IDTR = w_sysreg_idtr_info_data;
	assign oSYSREG_PSR = w_sysreg_psr_info_data;
	assign oSYSREG_PPSR = w_sysreg_ppsr_info_data;
	assign oSYSREG_PPCR = w_sysreg_ppcr_info_data;
	assign oSYSREG_SPR = w_sysreg_spr_info_data;
	assign oSYSREG_PFLAGR = w_sysreg_pflagr_info_data;
	assign oSYSREG_PCR = w_sysreg_pcr_info_data;

	assign oPREV_LOCK = iNEXT_LOCK;//this_lock;


endmodule


`default_nettype wire
