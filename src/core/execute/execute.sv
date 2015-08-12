
`default_nettype none
`include "core.h"
`include "common.h"

`define MIST32_AFE_ENA


module execute(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//Event CTRL
		input wire iEVENT_HOLD,
		input wire iEVENT_START,
		input wire iEVENT_IRQ_FRONT2BACK,
		input wire iEVENT_IRQ_BACK2FRONT,
		input wire iEVENT_END,
		//Lock
		output wire oEXCEPTION_LOCK,
		//System Register
		input wire [31:0] iSYSREG_PFLAGR,
		output wire [31:0] oSYSREG_FLAGR,
		//Pipeline
		input wire iPREV_VALID,
		input wire iPREV_BRANCH_PREDICT,
		input wire [31:0] iPREV_BRANCH_PREDICT_ADDR,
		input wire [31:0] iPREV_SYSREG_PSR,
		input wire [63:0] iPREV_SYSREG_FRCR,
		input wire iPREV_DESTINATION_SYSREG,
		input wire [4:0] iPREV_DESTINATION,
		input wire iPREV_WRITEBACK,
		input wire iPREV_FLAGS_WRITEBACK,
		input wire [4:0] iPREV_CMD,
		input wire [3:0] iPREV_CC_AFE,
		input wire [31:0] iPREV_SPR,
		input wire [31:0] iPREV_SOURCE0,
		input wire [31:0] iPREV_SOURCE1,
		input wire [5:0] iPREV_ADV_DATA,
		input wire [4:0] iPREV_SOURCE0_POINTER,
		input wire [4:0] iPREV_SOURCE1_POINTER,
		input wire iPREV_SOURCE0_SYSREG,
		input wire iPREV_SOURCE1_SYSREG,
		input wire iPREV_SOURCE1_IMM,
		input wire iPREV_SOURCE0_FLAGS,
		input wire iPREV_ADV_ACTIVE,
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
		//Load Store Pipe
		output wire oDATAIO_REQ,
		input wire iDATAIO_BUSY,
		output wire [1:0] oDATAIO_ORDER,	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		output wire [3:0] oDATAIO_MASK,		//[0]=Byte0, [1]=Byte1...
		output wire oDATAIO_RW,				//0=Read 1=Write
		output wire [31:0] oDATAIO_ADDR,
		output wire [31:0] oDATAIO_DATA,
		input wire iDATAIO_REQ,
		input wire iDATAIO_CACHE_HIT,
		input wire [31:0] iDATAIO_DATA,
		//Writeback
		output wire oNEXT_VALID,
		output wire [31:0] oNEXT_DATA,
		output wire [4:0] oNEXT_DESTINATION,
		output wire oNEXT_DESTINATION_SYSREG,
		output wire oNEXT_WRITEBACK,
		output wire oNEXT_SPR_WRITEBACK,
		output wire [31:0] oNEXT_SPR,
		output wire [63:0] oNEXT_FRCR,
		output wire [31:0] oNEXT_PC,
		//Branch
		output wire [31:0] oBRANCH_ADDR,
		output wire oJUMP_VALID,
		output wire oINTR_VALID,
		output wire oIDTSET_VALID,
		output wire oPSRSET_VALID,
		//Branch Predictor
		output wire oBPREDICT_JUMP_INST,
		output wire oBPREDICT_PREDICT,				//Branch Guess
		output wire oBPREDICT_HIT,					//Guess Hit!
		output wire oBPREDICT_JUMP,					//Branch Active
		output wire [31:0] oBPREDICT_JUMP_ADDR,		//Branch Address
		output wire [31:0] oBPREDICT_INST_ADDR,		//Branch Instruction Memory Address
		output wire [31:0] oDEBUG_PC
	);


	/*********************************************************************************************************
	Wire
	*********************************************************************************************************/
	localparam L_PARAM_STT_NORMAL =  3'h0;
	localparam L_PARAM_STT_LOAD = 3'h2;
	localparam L_PARAM_STT_STORE = 3'h3;
	localparam L_PARAM_STT_BRANCH = 3'h4;
	localparam L_PARAM_STT_RELOAD = 3'h5;


	reg [2:0] b_state;

	reg b_valid;
	reg [31:0] b_sysreg_psr;
	reg b_load_store;
	reg b_writeback;
	reg b_destination_sysreg;
	reg [4:0] b_destination;
	reg [3:0] b_afe;
	reg [31:0] b_r_data;
	reg b_spr_writeback;
	reg [31:0] b_r_spr;
	reg b_ldst_pipe_valid;
	reg [1:0] b_ldst_pipe_order;
	reg [31:0] b_ldst_pipe_addr;
	reg [31:0] b_ldst_pipe_data;
	reg [3:0] b_ldst_pipe_mask;
	reg [1:0] b_load_pipe_shift;
	reg [1:0] b_load_pipe_mask;
	reg b_exception_valid;
	reg [6:0] b_exception_num;
	reg [31:0] b_exception_fi0r;
	reg [31:0] b_exception_fi1r;
	reg b_jump;
	reg b_psr;
	reg b_ib;
	reg [31:0] b_branch_addr;
	reg b_branch_predict;
	reg b_branch_predict_hit;
	reg [31:0] b_branch_predict_addr;
	reg [31:0] b_pc;
	reg [63:0] b_frcr;

	wire lock_condition = (b_state != L_PARAM_STT_NORMAL);
	wire io_lock_condition = iDATAIO_BUSY;
	assign oPREV_LOCK = lock_condition || iEVENT_HOLD || iEVENT_HOLD;


	wire [31:0] ex_module_source0;
	wire [31:0] ex_module_source1;


	wire forwarding_reg_gr_valid;
	wire [31:0] forwarding_reg_gr_data;
	wire [4:0] forwarding_reg_gr_dest;
	wire forwarding_reg_gr_dest_sysreg;
	wire forwarding_reg_spr_valid;
	wire [31:0] forwarding_reg_spr_data;
	wire forwarding_reg_frcr_valid;
	wire [63:0] forwarding_reg_frcr_data;
	wire [31:0] ex_module_spr;
	wire [31:0] ex_module_psr;

	//System Register
	wire [31:0] sys_reg_data;
	//Logic
	wire logic_sf;
	wire logic_of;
	wire logic_cf;
	wire logic_pf;
	wire logic_zf;
	wire [31:0] logic_data;
	wire [4:0] logic_flags = {logic_sf, logic_of, logic_cf, logic_pf, logic_zf};
	//Shift
	wire shift_sf, shift_of, shift_cf, shift_pf, shift_zf;
	wire [31:0] shift_data;
	wire [4:0] shift_flags = {shift_sf, shift_of, shift_cf, shift_pf, shift_zf};
	//Adder
	wire [31:0] adder_data;
	wire adder_sf, adder_of, adder_cf, adder_pf, adder_zf;
	wire [4:0] adder_flags = {adder_sf, adder_of, adder_cf, adder_pf, adder_zf};
	//Mul
	wire [4:0] mul_flags;
	wire [31:0] mul_data;
	//Branch
	wire [31:0] branch_branch_addr;
	wire branch_jump_valid;
	wire branch_not_jump_valid;
	wire branch_ib_valid;

	//Flag
	wire [4:0] sysreg_flags_register;

	/*********************************************************************************************************
	Forwarding
	*********************************************************************************************************/
	execute_forwarding_register FORWARDING_REGISTER(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iEVENT_HOLD || iEVENT_START || iRESET_SYNC),
		//Writeback - General Register
		.iWB_GR_VALID(b_valid && b_writeback),
		.iWB_GR_DATA(b_r_data),
		.iWB_GR_DEST(b_destination),
		.iWB_GR_DEST_SYSREG(b_destination_sysreg),
		//Writeback - Stack Point Register
		.iWB_SPR_VALID(b_valid && b_spr_writeback),
		.iWB_SPR_DATA(b_r_spr),
		//Writeback Auto - Stack Point Register
		.iWB_AUTO_SPR_VALID(b_valid && b_destination_sysreg && b_writeback && b_destination == `SYSREG_SPR),
		.iWB_AUTO_SPR_DATA(b_r_data),
		//Current -Stak Point Register
		.iCUUR_SPR_DATA(iPREV_SPR),
		//Writeback - FRCR
		.iWB_FRCR_VALID(b_valid),	
		.iWB_FRCR_DATA(b_frcr),		
		//Current - FRCR
		.iCUUR_FRCR_DATA(iPREV_SYSREG_FRCR),	
		//Fowerding Register Output
		.oFDR_GR_VALID(forwarding_reg_gr_valid),
		.oFDR_GR_DATA(forwarding_reg_gr_data),
		.oFDR_GR_DEST(forwarding_reg_gr_dest),
		.oFDR_GR_DEST_SYSREG(forwarding_reg_gr_dest_sysreg),
		//Fowerding Register Output
		.oFDR_SPR_VALID(forwarding_reg_spr_valid),
		.oFDR_SPR_DATA(forwarding_reg_spr_data),
		//Forwerding Register Output
		.oFDR_FRCR_VALID(forwarding_reg_frcr_valid),	
		.oFDR_FRCR_DATA(forwarding_reg_frcr_data)	
	);



	execute_forwarding FORWARDING_RS0(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iEVENT_HOLD || iEVENT_START || iRESET_SYNC),
		//Writeback - General Register
		.iWB_GR_VALID(b_valid && b_writeback),
		.iWB_GR_DATA(b_r_data),
		.iWB_GR_DEST(b_destination),
		.iWB_GR_DEST_SYSREG(b_destination_sysreg),
		//Writeback - Stack Point Register
		.iWB_SPR_VALID(b_valid && b_spr_writeback),
		.iWB_SPR_DATA(b_r_spr),
		//Writeback - FRCR
		.iWR_FRCR_VALID(b_valid),				//
		.iWR_FRCR_DATA(b_frcr),		//
		//Previous Writeback - General Register
		.iPREV_WB_GR_VALID(forwarding_reg_gr_valid),
		.iPREV_WB_GR_DATA(forwarding_reg_gr_data),
		.iPREV_WB_GR_DEST(forwarding_reg_gr_dest),
		.iPREV_WB_GR_DEST_SYSREG(forwarding_reg_gr_dest_sysreg),
		//Previous Writeback - Stack Point Register
		.iPREV_WB_SPR_VALID(forwarding_reg_spr_valid),
		.iPREV_WB_SPR_DATA(forwarding_reg_spr_data),
		//Previous Writeback - FRCR
		.iPREV_WB_FRCR_VALID(forwarding_reg_frcr_valid),				//
		.iPREV_WB_FRCR_DATA(forwarding_reg_frcr_data),		//
		//Source
		.iPREVIOUS_SOURCE_SYSREG(iPREV_SOURCE0_SYSREG),
		.iPREVIOUS_SOURCE_POINTER(iPREV_SOURCE0_POINTER),
		.iPREVIOUS_SOURCE_IMM(1'b0/*iPREV_SOURCE0_IMM*/),
		.iPREVIOUS_SOURCE_DATA(iPREV_SOURCE0),
		.iPREVIOUS_SOURCE_PSR(iPREV_SYSREG_PSR),
		//Output
		.oNEXT_SOURCE_DATA(ex_module_source0),
		.oNEXT_SOURCE_SPR(ex_module_spr),
		.oNEXT_SOURCE_PSR(ex_module_psr)
	);

	execute_forwarding FORWARDING_RS1(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iEVENT_HOLD || iEVENT_START || iRESET_SYNC),
		//Writeback - General Register
		.iWB_GR_VALID(b_valid && b_writeback),
		.iWB_GR_DATA(b_r_data),
		.iWB_GR_DEST(b_destination),
		.iWB_GR_DEST_SYSREG(b_destination_sysreg),
		//Writeback - Stack Point Register
		.iWB_SPR_VALID(b_valid && b_spr_writeback),
		.iWB_SPR_DATA(b_r_spr),
		//Writeback - FRCR
		.iWR_FRCR_VALID(b_valid),				//
		.iWR_FRCR_DATA(b_frcr),		//
		//Previous Writeback - General Register
		.iPREV_WB_GR_VALID(forwarding_reg_gr_valid),
		.iPREV_WB_GR_DATA(forwarding_reg_gr_data),
		.iPREV_WB_GR_DEST(forwarding_reg_gr_dest),
		.iPREV_WB_GR_DEST_SYSREG(forwarding_reg_gr_dest_sysreg),
		//Previous Writeback - Stack Point Register
		.iPREV_WB_SPR_VALID(forwarding_reg_spr_valid),
		.iPREV_WB_SPR_DATA(forwarding_reg_spr_data),
		//Previous Writeback - FRCR
		.iPREV_WB_FRCR_VALID(forwarding_reg_frcr_valid),				//
		.iPREV_WB_FRCR_DATA(forwarding_reg_frcr_data),		//
		//Source
		.iPREVIOUS_SOURCE_SYSREG(iPREV_SOURCE1_SYSREG),
		.iPREVIOUS_SOURCE_POINTER(iPREV_SOURCE1_POINTER),
		.iPREVIOUS_SOURCE_IMM(iPREV_SOURCE1_IMM),
		.iPREVIOUS_SOURCE_DATA(iPREV_SOURCE1),
		.iPREVIOUS_SOURCE_PSR(iPREV_SYSREG_PSR),
		//Output
		.oNEXT_SOURCE_DATA(ex_module_source1),
		.oNEXT_SOURCE_SPR(),
		.oNEXT_SOURCE_PSR()
	);


	/****************************************
	Flag Register
	****************************************/
	execute_flag_register REG_FLAG(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Control
		.iCTRL_HOLD(iEVENT_HOLD || iEVENT_HOLD || iEVENT_START),
		//PFLAGR
		.iPFLAGR_VALID(iEVENT_IRQ_BACK2FRONT),
		.iPFLAGR(iSYSREG_PFLAGR[4:0]),
		//Prev
		.iPREV_INST_VALID(iPREV_VALID),
		.iPREV_BUSY(lock_condition),
		.iPREV_FLAG_WRITE(iPREV_FLAGS_WRITEBACK),
		//Shift
		.iSHIFT_VALID(iPREV_EX_SHIFT),
		.iSHIFT_FLAG(shift_flags),
		//Adder
		.iADDER_VALID(iPREV_EX_ADDER),
		.iADDER_FLAG(adder_flags),
		//Mul
		.iMUL_VALID(iPREV_EX_MUL),
		.iMUL_FLAG(mul_flags),
		//Logic
		.iLOGIC_VALID(iPREV_EX_LOGIC),
		.iLOGIC_FLAG(logic_flags),
		//oUTPUT
		.oFLAG(sysreg_flags_register)
	);



	/*********************************************************************************************************
	Execute
	*********************************************************************************************************/
	/****************************************
	Logic
	****************************************/
	wire [4:0] logic_cmd;

	execute_logic_decode EXE_LOGIC_DECODER(
		.iPREV_INST(iPREV_CMD),
		.oNEXT_INST(logic_cmd)
	);

	execute_logic #(32) EXE_LOGIC(
		.iCONTROL_CMD(logic_cmd),
		.iDATA_0(ex_module_source0),
		.iDATA_1(ex_module_source1),
		.oDATA(logic_data),
		.oSF(logic_sf),
		.oOF(logic_of),
		.oCF(logic_cf),
		.oPF(logic_pf),
		.oZF(logic_zf)
	);

	/****************************************
	Shift
	****************************************/
	wire [2:0] shift_cmd;

	execute_shift_decode EXE_SHIFT_DECODER(
		.iPREV_INST(iPREV_CMD),
		.oNEXT_INST(shift_cmd)
	);

	execute_shift #(32) EXE_SHIFT(
		.iCONTROL_MODE(shift_cmd),
		.iDATA_0(ex_module_source0),
		.iDATA_1(ex_module_source1),
		.oDATA(shift_data),
		.oSF(shift_sf),
		.oOF(shift_of),
		.oCF(shift_cf),
		.oPF(shift_pf),
		.oZF(shift_zf)
	);

	/****************************************
	Adder
	****************************************/
	execute_adder #(32) EXE_ADDER(
		.iDATA_0(ex_module_source0),
		.iDATA_1(ex_module_source1),
		.iADDER_CMD(iPREV_CMD),
		.oDATA(adder_data),
		.oSF(adder_sf),
		.oOF(adder_of),
		.oCF(adder_cf),
		.oPF(adder_pf),
		.oZF(adder_zf)
	);


	/****************************************
	Mul
	****************************************/
	execute_mul EXE_MUL(
		.iCMD(iPREV_CMD),
		.iDATA_0(ex_module_source0),
		.iDATA_1(ex_module_source1),
		.oDATA(mul_data),
		.oFLAGS(mul_flags)
	);


	/****************************************
	Address calculate(Load Store)
	****************************************/
	//Load Store
	wire ldst_spr_valid;
	wire [31:0] ldst_spr;
	wire ldst_pipe_rw;
	wire [31:0] ldst_pipe_addr;
	wire [31:0] ldst_pipe_data;
	wire [1:0] ldst_pipe_order;
	wire [1:0] load_pipe_shift;
	wire [3:0] ldst_pipe_mask;

	execute_adder_calc LDST_CALC_ADDR(
		//Prev
		.iCMD(iPREV_CMD),
		.iLOADSTORE_MODE(iPREV_EX_LDST),
		.iSOURCE0(ex_module_source0),
		.iSOURCE1(ex_module_source1),
		.iADV_ACTIVE(iPREV_ADV_ACTIVE),
		//.iADV_DATA({26'h0, iPREV_ADV_DATA}),
		.iADV_DATA({{26{iPREV_ADV_DATA[5]}}, iPREV_ADV_DATA}),
		.iSPR(ex_module_spr),
		.iPSR(ex_module_psr),
		.iPDTR(32'h0),
		.iKPDTR(32'h0),
		.iPC(iPREV_PC - 32'h4),
		//Output - Writeback
		.oOUT_SPR_VALID(ldst_spr_valid),
		.oOUT_SPR(ldst_spr),
		.oOUT_DATA(),
		//Output - LDST Pipe
		.oLDST_RW(ldst_pipe_rw),
		.oLDST_ADDR(ldst_pipe_addr),
		.oLDST_DATA(ldst_pipe_data),
		.oLDST_ORDER(ldst_pipe_order),
		.oLDST_MASK(ldst_pipe_mask),
		.oLOAD_SHIFT(load_pipe_shift)
	);

	//Load Store
	wire [1:0] load_shift;
	wire [3:0] load_mask;
	execute_load_store STAGE_LDST(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Event CTRL
		.iEVENT_HOLD(iEVENT_HOLD),
		.iEVENT_START(iEVENT_START),
		.iEVENT_IRQ_FRONT2BACK(iEVENT_IRQ_FRONT2BACK),
		.iEVENT_IRQ_BACK2FRONT(iEVENT_IRQ_BACK2FRONT),
		.iEVENT_END(iEVENT_END),
		//State
		.iSTATE_NORMAL(b_state == L_PARAM_STT_NORMAL),
		.iSTATE_LOAD(b_state == L_PARAM_STT_LOAD),
		.iSTATE_STORE(b_state == L_PARAM_STT_STORE),
		/*************************************
		Previous
		*************************************/
		//Previous - PREDICT
		.iPREV_VALID(iPREV_VALID),
		.iPREV_EX_LDST(iPREV_EX_LDST),
		//System Register
		.iPREV_PSR(ex_module_psr),
		.iPREV_TIDR(32'h0),
		//Writeback
		.iPREV_SPR_VALID(ldst_spr_valid),
		.iPREV_SPR(ldst_spr),
		//Output - LDST Pipe
		.iPREV_LDST_RW(ldst_pipe_rw),
		.iPREV_LDST_PDT(32'h0),
		.iPREV_LDST_ADDR(ldst_pipe_addr),
		.iPREV_LDST_DATA(ldst_pipe_data),
		.iPREV_LDST_ORDER(ldst_pipe_order),
		.iPREV_LDST_MASK(ldst_pipe_mask),
		.iPREV_LOAD_SHIFT(load_pipe_shift),
		/*************************************
		MA
		*************************************/
		//Output - LDST Pipe
		.oLDST_REQ(oDATAIO_REQ),
		.iLDST_BUSY(iEVENT_HOLD || io_lock_condition),
		.oLDST_RW(oDATAIO_RW),
		.oLDST_PDT(),
		.oLDST_ADDR(oDATAIO_ADDR),
		.oLDST_DATA(oDATAIO_DATA),
		.oLDST_ORDER(oDATAIO_ORDER),
		.oLDST_MASK(oDATAIO_MASK),
		.oLDST_ASID(),
		.oLDST_MMUMOD(),
		.oLDST_MMUPS(),
		.iLDST_VALID(iDATAIO_REQ),
		/*************************************
		Next
		*************************************/
		//Next
		.iNEXT_BUSY(lock_condition),
		.oNEXT_VALID(),
		.oNEXT_SPR_VALID(),
		.oNEXT_SPR(),
		.oNEXT_SHIFT(load_shift),							//It's for after load data sigals
		.oNEXT_MASK(load_mask)								//It's for after load data sigals
	);
	

	//Load Data Mask and Shft
	wire [31:0] load_data;
	execute_load_data LOAD_MASK(
		.iSHIFT_ENABLE(!iDATAIO_CACHE_HIT),
		.iMASK(load_mask),
		.iSHIFT(load_shift),
		.iDATA(iDATAIO_DATA),
		.oDATA(load_data)
	);

	/****************************************
	System Register
	****************************************/
	wire sysreg_ctrl_idt_valid;
	wire sysreg_ctrl_psr_valid;
	wire [31:0] sysreg_reload_addr;

	execute_sys_reg EXE_SYS_REG(
		.iCMD(iPREV_CMD),
		.iPC(iPREV_PC),
		.iSOURCE0(ex_module_source0),
		.iSOURCE1(ex_module_source1),
		.oOUT(sys_reg_data),
		.oCTRL_IDT_VALID(sysreg_ctrl_idt_valid),
		.oCTRL_PSR_VALID(sysreg_ctrl_psr_valid),
		.oCTRL_RELOAD_ADDR(sysreg_reload_addr)
	);

	/****************************************
	Jump
	****************************************/
	//Branch
	execute_branch EXE_BRANCH(
		.iDATA_0(ex_module_source0),
		.iDATA_1(ex_module_source1),
		.iPC(iPREV_PC - 32'h4),
		.iFLAG(sysreg_flags_register),
		.iCC(iPREV_CC_AFE),
		.iCMD(iPREV_CMD),
		.oBRANCH_ADDR(branch_branch_addr),
		.oJUMP_VALID(branch_jump_valid),
		.oNOT_JUMP_VALID(branch_not_jump_valid),
		.oIB_VALID(branch_ib_valid),
		//.oIDTS_VALID(branch_idts_valid),
		.oHALT_VALID()
	);

	//Branch Predict
	wire branch_with_predict_predict_ena;
	wire branch_with_predict_predict_hit;
	wire branch_with_predict_branch_valid;
	wire branch_with_predict_ib_valid;
	wire [31:0] branch_with_predict_jump_addr;

	//Branch Predicter
	execute_branch_predict EXE_BRANCH_PREDICT(
		//State
		.iSTATE_NORMAL(b_state == L_PARAM_STT_NORMAL),
		//Previous - PREDICT
		.iPREV_VALID(iPREV_VALID),
		.iPREV_EX_BRANCH(iPREV_EX_BRANCH),
		.iPREV_BRANCH_PREDICT_ENA(iPREV_BRANCH_PREDICT),
		.iPREV_BRANCH_PREDICT_ADDR(iPREV_BRANCH_PREDICT_ADDR),
		//BRANCH
		.iPREV_BRANCH_VALID(branch_jump_valid),
		.iPREV_BRANCH_IB_VALID(branch_ib_valid),
		.iPREV_JUMP_ADDR(branch_branch_addr),
		//Next
		.iNEXT_BUSY(lock_condition),
		.oNEXT_PREDICT_HIT(branch_with_predict_predict_hit)
	);

	wire branch_valid_with_predict_miss = branch_not_jump_valid && iPREV_BRANCH_PREDICT;											//not need jump, but predict jump
	wire branch_valid_with_predict_addr_miss = branch_jump_valid && !(iPREV_BRANCH_PREDICT && branch_with_predict_predict_hit);		//need jump, but predict addr is diffelent (predict address diffelent)

	wire branch_valid_with_predict = branch_valid_with_predict_miss || branch_valid_with_predict_addr_miss;

	//Jump
	wire jump_stage_predict_ena;
	wire jump_stage_predict_hit;
	wire jump_stage_jump_valid;
	wire [31:0] jump_stage_jump_addr;
	
	wire jump_normal_jump_inst;
	
	wire jump_stage_branch_valid;
	wire jump_stage_branch_ib_valid;
	wire jump_stage_sysreg_idt_valid;
	wire jump_stage_sysreg_psr_valid;
	execute_jump STAGE_JUMP(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Event CTRL
		.iEVENT_HOLD(iEVENT_HOLD),
		.iEVENT_START(iEVENT_START),
		.iEVENT_IRQ_FRONT2BACK(iEVENT_IRQ_FRONT2BACK),
		.iEVENT_IRQ_BACK2FRONT(iEVENT_IRQ_BACK2FRONT),
		.iEVENT_END(iEVENT_END),
		//State
		.iSTATE_NORMAL(b_state == L_PARAM_STT_NORMAL),
		//Previous - PREDICT
		.iPREV_VALID(iPREV_VALID),
		.iPREV_EX_BRANCH(iPREV_EX_BRANCH),
		.iPREV_EX_SYS_REG(iPREV_EX_SYS_REG),
		.iPREV_PC(iPREV_PC),
		.iPREV_BRANCH_PREDICT_ENA(iPREV_BRANCH_PREDICT),
		.iPREV_BRANCH_PREDICT_HIT(branch_with_predict_predict_hit),
		.iPREV_BRANCH_NORMAL_JUMP_INST(branch_jump_valid || branch_not_jump_valid),		//ignore branch predict result
		//BRANCH
		.iPREV_BRANCH_PREDICT_MISS_VALID(branch_valid_with_predict_miss),
		.iPREV_BRANCH_PREDICT_ADDR_MISS_VALID(branch_valid_with_predict_addr_miss),
		.iPREV_BRANCH_IB_VALID(branch_ib_valid),
		.iPREV_BRANCH_ADDR(branch_branch_addr),
		//SYSREG JUMP
		.iPREV_SYSREG_IDT_VALID(sysreg_ctrl_idt_valid),
		.iPREV_SYSREG_PDT_VALID(1'b0),
		.iPREV_SYSREG_PSR_VALID(sysreg_ctrl_psr_valid),
		.iPREV_SYSREG_ADDR(sysreg_reload_addr),
		/*************************************
		Next
		*************************************/
		//Next
		.iNEXT_BUSY(lock_condition),
		.oNEXT_PREDICT_ENA(jump_stage_predict_ena),
		.oNEXT_PREDICT_HIT(jump_stage_predict_hit),
		.oNEXT_JUMP_VALID(jump_stage_jump_valid),
		.oNEXT_JUMP_ADDR(jump_stage_jump_addr),
		//for Branch Predictor
		.oNEXT_NORMAL_JUMP_INST(jump_normal_jump_inst),			//ignore branch predict result
		//Kaind of Jump
		.oNEXT_TYPE_BRANCH_VALID(jump_stage_branch_valid),
		.oNEXT_TYPE_BRANCH_IB_VALID(jump_stage_branch_ib_valid),
		.oNEXT_TYPE_SYSREG_IDT_VALID(jump_stage_sysreg_idt_valid),
		.oNEXT_TYPE_SYSREG_PDT_VALID(),
		.oNEXT_TYPE_SYSREG_PSR_VALID(jump_stage_sysreg_psr_valid)
	);


	/*********************************************************************************************************
	Pipelined Register
	*********************************************************************************************************/
	/****************************************
	State
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= L_PARAM_STT_NORMAL;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_state <= L_PARAM_STT_NORMAL;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_VALID && !lock_condition)begin
							//Load Store
							if(iPREV_EX_LDST)begin
								if(!ldst_pipe_rw)begin
									b_state <= L_PARAM_STT_LOAD;
								end
								else begin
									b_state <= L_PARAM_STT_STORE;
								end
							end
							//Branch
							else if(iPREV_EX_BRANCH)begin
								//Interrupt Return Branch
								if(branch_ib_valid)begin
									b_state <= L_PARAM_STT_BRANCH;
								end
								//Branch(with Branch predict)
								else if(branch_valid_with_predict)begin
									b_state <= L_PARAM_STT_BRANCH;
								end
							end
							//System Register(for need re-load instructions)
							if(iPREV_EX_SYS_REG)begin
								if(sysreg_ctrl_idt_valid || sysreg_ctrl_psr_valid)begin
									b_state <= L_PARAM_STT_RELOAD;
								end
							end
						end
					end
				L_PARAM_STT_LOAD:
					begin
						if(iDATAIO_REQ)begin
							b_state <= L_PARAM_STT_NORMAL;
						end
					end
				L_PARAM_STT_STORE:
					begin
						if(iDATAIO_REQ)begin
							b_state <= L_PARAM_STT_NORMAL;
						end
					end
				L_PARAM_STT_BRANCH:
					begin
						//Branch Wait
						b_state <= L_PARAM_STT_BRANCH;
					end
				L_PARAM_STT_RELOAD:
					begin
						//Branch Wait
						b_state <= L_PARAM_STT_RELOAD;
					end
				default:
					begin
						b_state <= L_PARAM_STT_NORMAL;
					end
			endcase
		end
	end //state always

	/****************************************
	For PC
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_pc <= 32'h0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_pc <= 32'h0;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_VALID && !lock_condition)begin
							b_pc <= iPREV_PC;
						end
					end
				default:
					begin
						b_pc <= b_pc;
					end
			endcase
		end
	end
	
	/****************************************
	For FRCR
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_frcr <= 64'h0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_frcr <= 64'h0;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_VALID && !lock_condition)begin
							b_frcr <= iPREV_SYSREG_FRCR;
						end
					end
				default:
					begin
						b_frcr <= b_frcr;
					end
			endcase
		end
	end
	

	/****************************************
	Result Data
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_r_data <= 32'h0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_r_data <= 32'h0;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_VALID && !lock_condition)begin
							//SPR Read Store
							if(iPREV_EX_SYS_LDST)begin
								b_r_data <= ldst_spr;
							end
							//System Register
							else if(iPREV_EX_SYS_REG)begin
								b_r_data <= sys_reg_data;
							end
							//Logic
							else if(iPREV_EX_LOGIC)begin
								b_r_data <= logic_data;
							end
							//SHIFT
							else if(iPREV_EX_SHIFT)begin
								b_r_data <= shift_data;
							end
							//ADDER
							else if(iPREV_EX_ADDER)begin
								b_r_data <= adder_data;
							end
							//MUL
							else if(iPREV_EX_MUL)begin
								b_r_data <= mul_data;
							end
							//Error
							else begin
								b_r_data <= 32'h0;
							end
						end
					end
				L_PARAM_STT_LOAD:
					begin
						if(iDATAIO_REQ)begin
							b_r_data <= load_data;
						end
					end
				default:
					begin
						b_r_data <= 32'h0;
					end
			endcase
		end
	end

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_r_spr <= 32'h0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_r_spr <= 32'h0;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_EX_LDST || iPREV_EX_SYS_LDST)begin
							b_r_spr <= ldst_spr;
						end
					end
				default:
					begin
						b_r_spr <= b_r_spr;
					end
			endcase
		end
	end

	/****************************************
	Execute Category
	****************************************/
	reg b_ex_category_ldst;

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_ex_category_ldst <= 1'b0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_ex_category_ldst <= 1'b0;
		end
		else begin
			if(b_state == L_PARAM_STT_NORMAL && iPREV_VALID && !lock_condition)begin
				b_ex_category_ldst <= iPREV_EX_LDST;
			end
		end
	end


	/****************************************
	Pass Line
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_writeback <= 1'b0;
			b_destination_sysreg  <= 1'b0;
			b_destination <= 5'h0;
			b_afe <= 4'h0;
			b_spr_writeback <= 1'b0;
		end
		else if(iEVENT_HOLD || iRESET_SYNC || iEVENT_START)begin
			b_writeback <= 1'b0;
			b_destination_sysreg  <= 1'b0;
			b_destination <= 5'h0;
			b_afe <= 4'h0;
			b_spr_writeback <= 1'b0;
		end
		else if(b_state == L_PARAM_STT_NORMAL)begin
			if(iPREV_VALID && !lock_condition)begin
				if(iPREV_EX_LDST || iPREV_EX_SYS_LDST || iPREV_EX_SYS_REG || iPREV_EX_LOGIC || iPREV_EX_SHIFT || iPREV_EX_ADDER || iPREV_EX_MUL)begin
					b_writeback <= iPREV_WRITEBACK;
					b_destination_sysreg  <= iPREV_DESTINATION_SYSREG;
					b_destination <= iPREV_DESTINATION;
					b_afe <= iPREV_CC_AFE;
					b_spr_writeback <= (iPREV_EX_LDST || iPREV_EX_SYS_LDST) && ldst_spr_valid;
				end
				else if(iPREV_EX_BRANCH)begin
					b_writeback <= 1'b0;
					b_destination_sysreg  <= iPREV_DESTINATION_SYSREG;
					b_destination <= iPREV_DESTINATION;
					b_afe <= iPREV_CC_AFE;
					b_spr_writeback <= 1'b0;
				end
			end
		end
	end


	/****************************************
	Valid
	****************************************/
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_valid <= 1'b0;
		end
		else if(iEVENT_HOLD || iEVENT_START || iRESET_SYNC)begin
			b_valid <= 1'b0;
		end
		else begin
			case(b_state)
				L_PARAM_STT_NORMAL:
					begin
						if(iPREV_VALID && !lock_condition && (iPREV_EX_LDST && !ldst_pipe_rw))begin
							b_valid <= 1'b0;
						end
						else if(iPREV_VALID && !lock_condition && iPREV_EX_BRANCH)begin
							//Interrupt Return Branch
							if(branch_ib_valid)begin
								b_valid <= 1'b1;
							end
							//Branch(with Branch predict) - True
							else if(branch_valid_with_predict)begin
								b_valid <= 1'b1;
							end
							else if(branch_with_predict_predict_hit)begin
								b_valid <= 1'b1;
							end
							else begin
								//b_valid <= 1'b0;
								b_valid <= 1'b1;
							end
						end
						else begin
							b_valid <= iPREV_VALID && !lock_condition;
						end
					end
				L_PARAM_STT_LOAD:
					begin
						if(iDATAIO_REQ)begin
							b_valid <= 1'b1;
						end
					end
				L_PARAM_STT_STORE:
					begin
						if(iDATAIO_REQ)begin
							b_valid <= 1'b1;
						end
					end
				default:
					begin
						b_valid <= 1'b0;
					end
			endcase
		end
	end


	/*********************************************************************************************************
	Assign
	*********************************************************************************************************/
	//Branch Predict
	assign oBPREDICT_JUMP_INST = jump_normal_jump_inst;			//Is normal jump Instruction?
	assign oBPREDICT_PREDICT = jump_stage_predict_ena;
	assign oBPREDICT_HIT = jump_stage_predict_hit || (!jump_stage_jump_valid && !jump_stage_predict_ena && b_valid);
	assign oBPREDICT_JUMP = jump_stage_jump_valid;
	assign oBPREDICT_JUMP_ADDR = jump_stage_jump_addr;
	assign oBPREDICT_INST_ADDR = b_pc - 32'h00000004;

	//Branch - Controller
	assign oBRANCH_ADDR = jump_stage_jump_addr;
	assign oJUMP_VALID = jump_stage_jump_valid;
	assign oINTR_VALID = jump_stage_branch_ib_valid;
	assign oIDTSET_VALID = jump_stage_sysreg_idt_valid;
	assign oPSRSET_VALID = jump_stage_sysreg_psr_valid;

	//Writeback
	assign oNEXT_VALID = b_valid && !iEVENT_HOLD;
	assign oNEXT_DATA = b_r_data;
	assign oNEXT_DESTINATION = b_destination;
	assign oNEXT_DESTINATION_SYSREG = b_destination_sysreg;
	assign oNEXT_WRITEBACK = b_writeback && (b_state != L_PARAM_STT_BRANCH);
	assign oNEXT_SPR_WRITEBACK = b_spr_writeback && (b_state != L_PARAM_STT_BRANCH);
	assign oNEXT_SPR = b_r_spr;
	assign oNEXT_FRCR = b_frcr;
	assign oNEXT_PC = b_pc;
	
	assign oEXCEPTION_LOCK = (b_state == L_PARAM_STT_LOAD) ||  (b_state == L_PARAM_STT_STORE) ||  (b_state == L_PARAM_STT_RELOAD); //new 20150526

	assign oSYSREG_FLAGR = {27'h0, sysreg_flags_register};

	assign oDEBUG_PC = b_pc;

	/*********************************************************************************************************
	Assertion
	*********************************************************************************************************/
	/*************************************************
	Verilog Assertion
	*************************************************/
	//synthesis translate_off
	function [31:0] func_assert_write_data;
		input [4:0] func_mask;
		input [31:0] func_data;
		begin
			if(func_mask == 4'hf)begin
				func_assert_write_data = func_data;
			end
			else if(func_mask == 4'b0011)begin
				func_assert_write_data = {16'h0, func_data[15:0]};
			end
			else if(func_mask == 4'b1100)begin
				func_assert_write_data = {16'h0, func_data[31:16]};
			end
			else if(func_mask == 4'b1000)begin
				func_assert_write_data = {24'h0, func_data[31:24]};
			end
			else if(func_mask == 4'b0100)begin
				func_assert_write_data = {24'h0, func_data[23:16]};
			end
			else if(func_mask == 4'b0010)begin
				func_assert_write_data = {24'h0, func_data[15:8]};
			end
			else if(func_mask == 4'b0001)begin
				func_assert_write_data = {24'h0, func_data[7:0]};
			end
			else begin
				func_assert_write_data = 32'h0;
			end
		end
	endfunction

	//`ifdef MIST1032ISA_VLG_ASSERTION
	localparam time_ena = 0;
	/*
	integer F_HANDLE;
	initial F_HANDLE = $fopen("ldst_time_dump.log");
	*/

	wire [31:0] for_assertion_store_real_data = func_assert_write_data(oDATAIO_MASK, oDATAIO_DATA);

	/*
	--------------------------------
	[S], "PC", "spr", "addr", "data"
	[L], "PC", "spr", "addr", "data"
	--------------------------------
	*/

	//synthesis translate_on



endmodule


`default_nettype wire