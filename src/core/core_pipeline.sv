

`default_nettype none

module core_pipeline(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		/****************************************
		GCI Controll
		****************************************/
		//Interrupt Controll
		output wire oIO_IRQ_CONFIG_TABLE_REQ,
		output wire [5:0] oIO_IRQ_CONFIG_TABLE_ENTRY,
		output wire oIO_IRQ_CONFIG_TABLE_FLAG_MASK,
		output wire oIO_IRQ_CONFIG_TABLE_FLAG_VALID,
		output wire [1:0] oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL,
		/****************************************
		Instrution Memory
		****************************************/
		//Memory Instruction-Request
		output wire oINST_FETCH_REQ,
		input wire iINST_FETCH_BUSY,
		output wire [31:0] oINST_FETCH_ADDR,
		//Memory Instruction-Get
		input wire iINST_VALID,
		output wire oINST_BUSY,
		input wire [63:0] iINST_DATA,
		/****************************************
		Data Memory
		****************************************/
		//Req
		output wire oDATA_REQ,
		input wire iDATA_LOCK,
		output wire [1:0] oDATA_ORDER,
		output wire [3:0] oDATA_MASK,
		output wire oDATA_RW,		//0=Write 1=Read
		output wire [31:0] oDATA_ADDR,
		//This -> Data RAM
		output wire [31:0] oDATA_DATA,
		//Data RAM -> This
		input wire iDATA_VALID,
		input wire [63:0] iDATA_DATA,
		/****************************************
		IO
		****************************************/
		//Req
		output wire oIO_REQ,
		input wire iIO_BUSY,
		output wire [1:0] oIO_ORDER,
		output wire oIO_RW,			//0=Write 1=Read
		output wire [31:0] oIO_ADDR,
		//Write
		output wire [31:0] oIO_DATA,
		//Rec
		input wire iIO_VALID,
		input wire [31:0] iIO_DATA,
		/****************************************
		Interrupt
		****************************************/
		input wire iINTERRUPT_VALID,
		input wire [5:0] iINTERRUPT_NUM,
		output wire oINTERRUPT_ACK
	);

	//Cache
	wire icache2fetch_valid;
	wire [31:0] icache2fetch_inst;
	wire fetch2icache_lock;
	wire fetch2icache_req;
	wire [31:0] fetch2icache_addr;
	wire icache2fetch_lock;
	//Event
	wire core_event_hold;
	wire core_event_start;
	wire core_event_irq_front2back;
	wire core_event_irq_back2front;
	wire core_event_end;
	//Event-Sysreg
	wire core_event_sysreg_set_pcr_set;
	wire core_event_sysreg_set_ppcr_set;
	wire core_event_sysreg_set_spr_set;
	wire core_event_sysreg_set_fi0r_set;
	wire core_event_sysreg_set_fi1r_set;
	wire [31:0] core_event_sysreg_set_ppcr;
	wire [31:0] core_event_sysreg_set_spr;
	wire [31:0] core_event_sysreg_set_fi0r;
	wire [31:0] core_event_sysreg_set_fi1r;
	wire [31:0] core_event_sysreg_set_pcr;
	//Fetch
	wire fetch2lbuffer_inst_valid;
	wire fetch2lbuffer_branch_predict;
	wire [31:0] fetch2lbuffer_branch_predict_addr;
	wire [31:0] fetch2lbuffer_inst;
	wire [31:0] fetch2lbuffer_pc;
	wire lbuffer2fetch_fetch_stop;
	wire lbuffer2fetch_fetch_lock;
	//Decoder
	wire lbuffer2decoder_inst_valid;
	wire lbuffer2decoder_branch_predict;
	wire [31:0] lbuffer2decoder_branch_predict_addr;
	wire [31:0] lbuffer2decoder_inst;
	wire [31:0] lbuffer2decoder_pc;
	wire decoder2lbuffer_lock;
	//Dispatch
	wire decoder2dispatch_valid;
	wire decoder2dispatch_branch_predict;
	wire [31:0] decoder2dispatch_branch_predict_addr;
	wire decoder2dispatch_source0_active;
	wire decoder2dispatch_source1_active;
	wire decoder2dispatch_source0_sysreg;
	wire decoder2dispatch_source1_sysreg;
	wire decoder2dispatch_adv_active;
	wire decoder2dispatch_destination_sysreg;
	wire decoder2dispatch_writeback;
	wire decoder2dispatch_flags_writeback;
	wire [4:0] decoder2dispatch_cmd;
	wire [3:0] decoder2dispatch_cc_afe;
	wire [4:0] decoder2dispatch_source0;
	wire [31:0] decoder2dispatch_source1;
	wire [5:0] decoder2dispatch_adv_data;
	wire decoder2dispatch_source0_flags;
	wire decoder2dispatch_source1_imm;
	wire [4:0] decoder2dispatch_destination;
	wire decoder2dispatch_ex_sys_reg;
	wire decoder2dispatch_ex_sys_ldst;
	wire decoder2dispatch_ex_logic;
	wire decoder2dispatch_ex_shift;
	wire decoder2dispatch_ex_addr;
	wire decoder2dispatch_ex_mul;
	wire decoder2dispatch_ex_sdiv;
	wire decoder2dispatch_ex_udiv;
	wire decoder2dispatch_ex_ldst;
	wire decoder2dispatch_ex_branch;
	wire [31:0] decoder2dispatch_pc;
	wire dispatch2decoder_lock;
	//Execution
	wire dispatch2execution_valid;
	wire dispatch2execution_branch_predict;
	wire [31:0] dispatch2execution_branch_predict_addr;
	wire [31:0] dispatch2execution_sysreg_psr;
	wire [63:0] dispatch2execution_sysreg_frcr;
	wire dispatch2execution_destination_sysreg;
	wire dispatch2execution_writeback;
	wire dispatch2execution_flags_writeback;
	wire [4:0] dispatch2execution_cmd;
	wire [3:0] dispatch2execution_cc_afe;
	wire [31:0] dispatch2execution_spr;
	wire [31:0] dispatch2execution_source0;
	wire [31:0] dispatch2execution_source1;
	wire [5:0] dispatch2execution_adv_data;
	wire [4:0] dispatch2execution_source0_pointer;
	wire [4:0] dispatch2execution_source1_pointer;
	wire dispatch2execution_source0_sysreg;
	wire dispatch2execution_source1_sysreg;
	wire dispatch2execution_source1_imm;
	wire dispatch2execution_source0_flags;
	wire dispatch2execution_adv_active;
	wire [4:0] dispatch2execution_destination;
	wire dispatch2execution_ex_sys_reg;
	wire dispatch2execution_ex_sys_ldst;
	wire dispatch2execution_ex_logic;
	wire dispatch2execution_ex_shift;
	wire dispatch2execution_ex_addr;
	wire dispatch2execution_ex_mul;
	wire dispatch2execution_ex_sdiv;
	wire dispatch2execution_ex_udiv;
	wire dispatch2execution_ex_ldst;
	wire dispatch2execution_ex_branch;
	wire [31:0] dispatch2execution_pc;
	wire execution2dispatch_lock;
	//Writeback
	wire execution2dispatch_valid;
	wire [31:0] execution2dispatch_data;
	wire [4:0] execution2dispatch_destination;
	wire execution2dispatch_destination_sysreg;
	wire execution2dispatch_writeback;
	wire execution2dispatch_spr_writeback;
	wire [31:0] execution2dispatch_spr;
	wire [63:0] execution2dispatch_frcr;
	wire [31:0] execution2dispatch_pc;
	//Branch Predict
	wire branch_predict_fetch_flush;
	wire branch_predict_result_jump_inst;
	wire branch_predict_result_predict;
	wire branch_predict_result_hit;
	wire branch_predict_result_jump;
	wire [31:0] branch_predict_result_jump_addr;
	wire [31:0] branch_predict_result_inst_addr;
	//Load Store
	wire execution2ldst_ldst_req;
	wire [1:0] execution2ldst_ldst_order;
	wire [3:0] execution2ldst_ldst_mask;
	wire execution2ldst_ldst_rw;
	wire [31:0] execution2ldst_ldst_addr;
	wire [31:0] execution2ldst_ldst_data;
	wire ldst2execution_ldst_busy;
	wire ldst2execution_ldst_req;
	wire [31:0] ldst2execution_ldst_data;
	//Data Cache to Memory Pipe
	wire ldst_arbiter2d_cache_req;
	wire d_cache2ldst_arbiter_busy;
	wire [1:0] ldst_arbiter2d_cache_order;
	wire [3:0] ldst_arbiter2d_cache_mask;
	wire ldst_arbiter2d_cache_rw;
	wire [31:0] ldst_arbiter2d_cache_addr;
	wire [31:0] ldst_arbiter2d_cache_data;
	wire d_cache2ldst_arbiter_valid;
	wire [31:0] d_cache2ldst_arbiter_data;
	//System Register
	wire [31:0] sysreg_flagr;
	wire [31:0] sysreg_spr;
	wire [31:0] sysreg_idtr;
	wire [31:0] sysreg_psr;
	wire [31:0] sysreg_ppsr;
	wire [31:0] sysreg_pcr;
	wire [31:0] sysreg_ppcr;
	wire [31:0] sysreg_pflagr;
	//Interrupt Lock
	wire execute_exception_lock;
	//Exception Manager
	wire exception2ldst_ldst_use;
	wire exception2ldst_ldst_req;
	wire ldst2exception_ldst_busy;
	wire [1:0] exception2ldst_ldst_order;
	wire exception2ldst_ldst_rw;
	wire [31:0] exception2ldst_ldst_addr;
	wire [31:0] exception2ldst_ldst_data;
	wire ldst2exception_ldst_req;
	wire [31:0] ldst2exception_ldst_data;
	wire exception_jump_valid;
	wire [31:0] exception_branch_addr;
	wire exception_intr_valid;
	wire exception_pdts_valid;
	wire exception_psr_valid;
	wire exception2cim_ict_req;
	wire [5:0] exception2cim_ict_entry;
	wire exception2cim_ict_conf_mask;
	wire exception2cim_ict_conf_valid;
	wire [1:0] exception2cim_ict_conf_level;
	wire exception2cim_irq_lock;
	wire cim2exception_irq_req;
	wire [6:0] cim2exception_irq_num;
	wire [31:0] cim2exception_irq_fi0r;
	wire [31:0] cim2exception_irq_fi1r;
	wire exception2cim_irq_ack;
	wire exception_idtset_valid;
	wire exception_fault_valid;
	wire [6:0] exception_fault_num;
	wire [31:0] exception_fault_fi0r;
	wire [31:0] exception_fault_fi1r;

	wire sysreg_write_pdtr;

	interrupt_control IRQ_CTRL(
		//System
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Core Interrupt Configlation Table
		.iICT_VALID(exception2cim_ict_req),
		.iICT_ENTRY(exception2cim_ict_entry),
		.iICT_CONF_MASK(exception2cim_ict_conf_mask),
		.iICT_CONF_VALID(exception2cim_ict_conf_valid),
		.iICT_CONF_LEVEL(exception2cim_ict_conf_level),
		//Sysreg
		.iSYSREGINFO_PSR(sysreg_psr),
		//Interrupt Input
		.iEXT_ACTIVE(iINTERRUPT_VALID),
		.iEXT_NUM(iINTERRUPT_NUM),
		.oEXT_ACK(oINTERRUPT_ACK),
		//To Exception Manager
		.iEXCEPTION_LOCK(exception2cim_irq_lock),
		.oEXCEPTION_ACTIVE(cim2exception_irq_req),
		.oEXCEPTION_IRQ_NUM(cim2exception_irq_num),
		.oEXCEPTION_IRQ_FI0R(cim2exception_irq_fi0r),
		.oEXCEPTION_IRQ_FI1R(cim2exception_irq_fi1r),
		.iEXCEPTION_IRQ_ACK(exception2cim_irq_ack)
	);

	pipeline_control PIPELINE_CTRL(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		/************************************
		Core internal Event
		************************************/
		//Timing
		.oEVENT_HOLD(core_event_hold),
		.oEVENT_START(core_event_start),
		.oEVENT_IRQ_FRONT2BACK(core_event_irq_front2back),
		.oEVENT_IRQ_BACK2FRONT(core_event_irq_back2front),
		.oEVENT_END(core_event_end),
		//System Register
		.oEVENT_SETREG_PCR_SET(core_event_sysreg_set_pcr_set),
		.oEVENT_SETREG_PPCR_SET(core_event_sysreg_set_ppcr_set),
		.oEVENT_SETREG_SPR_SET(core_event_sysreg_set_spr_set),
		.oEVENT_SETREG_FI0R_SET(core_event_sysreg_set_fi0r_set),
		.oEVENT_SETREG_FI1R_SET(core_event_sysreg_set_fi1r_set),
		.oEVENT_SETREG_PCR(core_event_sysreg_set_pcr),
		.oEVENT_SETREG_PPCR(core_event_sysreg_set_ppcr),
		.oEVENT_SETREG_SPR(core_event_sysreg_set_spr),
		.oEVENT_SETREG_FI0R(core_event_sysreg_set_fi0r),
		.oEVENT_SETREG_FI1R(core_event_sysreg_set_fi1r),
		/************************************
		System Register - Input
		************************************/
		.iSYSREG_SPR(sysreg_spr),
		.iSYSREG_PSR(sysreg_psr),
		.iSYSREG_PCR(sysreg_pcr),
		.iSYSREG_PPSR(sysreg_ppsr),
		.iSYSREG_PPCR(sysreg_ppcr),
		.iSYSREG_IDTR(sysreg_idtr),
		/************************************
		Interrupt Lock
		************************************/
		.iINTERRUPT_LOCK(execute_exception_lock),
		/************************************
		Load Store
		************************************/
		.oLDST_USE(exception2ldst_ldst_use),
		.oLDST_REQ(exception2ldst_ldst_req),
		.iLDST_BUSY(ldst2exception_ldst_busy),
		.oLDST_ORDER(exception2ldst_ldst_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oLDST_RW(exception2ldst_ldst_rw),		//0=Read 1=Write
		.oLDST_ADDR(exception2ldst_ldst_addr),
		.oLDST_DATA(exception2ldst_ldst_data),
		.iLDST_REQ(ldst2exception_ldst_req),
		.iLDST_DATA(ldst2exception_ldst_data),
		/************************************
		Interrupt Configlation Table
		************************************/
		//GCI Interrupt Configlation Table
		.oIO_IRQ_CONFIG_TABLE_REQ(oIO_IRQ_CONFIG_TABLE_REQ),
		.oIO_IRQ_CONFIG_TABLE_ENTRY(oIO_IRQ_CONFIG_TABLE_ENTRY),
		.oIO_IRQ_CONFIG_TABLE_FLAG_MASK(oIO_IRQ_CONFIG_TABLE_FLAG_MASK),
		.oIO_IRQ_CONFIG_TABLE_FLAG_VALID(oIO_IRQ_CONFIG_TABLE_FLAG_VALID),
		.oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL(oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL),
		//Core Interrupt Configlation Table
		.oICT_REQ(exception2cim_ict_req),
		.oICT_ENTRY(exception2cim_ict_entry),
		.oICT_CONF_MASK(exception2cim_ict_conf_mask),
		.oICT_CONF_VALID(exception2cim_ict_conf_valid),
		.oICT_CONF_LEVEL(exception2cim_ict_conf_level),
		/************************************
		External Exception
		************************************/
		.iEXCEPT_IRQ_REQ(cim2exception_irq_req),
		.iEXCEPT_IRQ_NUM(cim2exception_irq_num),
		.iEXCEPT_IRQ_FI0R(cim2exception_irq_fi0r),
		.iEXCEPT_IRQ_FI1R(cim2exception_irq_fi1r),
		.oEXCEPT_IRQ_ACK(exception2cim_irq_ack),
		.oEXCEPT_IRQ_BUSY(exception2cim_irq_lock),
		/************************************
		Exception Input
		************************************/
		//Core Branch
		.iEXE_JUMP_ADDR(exception_branch_addr),
		.iEXE_BRANCH_VALID(exception_jump_valid),
		.iEXE_IDTS_VALID(exception_idtset_valid),
		.iEXE_IB_VALID(exception_intr_valid),
		.iEXE_RELOAD_VALID(exception_pdts_valid || exception_psr_valid)
	);


	//***********************************************OK?
	//Cache
	l1_inst_cache L1_INST_CACHE(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		/****************************************
		Memory Port Memory
		****************************************/
		//Req
		.oINST_REQ(oINST_FETCH_REQ),
		.iINST_LOCK(iINST_FETCH_BUSY),
		.oINST_ADDR(oINST_FETCH_ADDR),
		//Mem
		.iINST_VALID(iINST_VALID),
		.oINST_BUSY(oINST_BUSY),
		.iINST_DATA(iINST_DATA),
		/****************************************
		Fetch Module
		****************************************/
		//From Fetch
		.iNEXT_FETCH_REQ(fetch2icache_req),
		.oNEXT_FETCH_LOCK(icache2fetch_lock),
		.iNEXT_FETCH_ADDR(fetch2icache_addr),
		//To Fetch
		.oNEXT_0_INST_VALID(icache2fetch_valid),
		.oNEXT_0_INST(icache2fetch_inst),
		.iNEXT_LOCK(fetch2icache_lock)
	);

	//***********************************************OK?
	fetch FETCH(
		//System
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Core
		.iSYSREG_PSR(sysreg_psr),
		//Pipeline Control
		.iEVENT_HOLD(core_event_hold),
		.iEVENT_START(core_event_start),
		.iEVENT_END(core_event_end),
		//Pipeline Control - Register Set
		.iEVENT_SETREG_PCR_SET(core_event_sysreg_set_pcr_set),
		.iEVENT_SETREG_PCR(core_event_sysreg_set_pcr),
		//Exception - Legacy
		.iEXCEPTION_ADDR_SET(core_event_sysreg_set_pcr_set),
		.iEXCEPTION_ADDR(core_event_sysreg_set_pcr),
		//Branch Predict
		.iBRANCH_PREDICT_RESULT_JUMP_INST(branch_predict_result_jump_inst),
		.iBRANCH_PREDICT_RESULT_PREDICT(branch_predict_result_predict),
		.iBRANCH_PREDICT_RESULT_HIT(branch_predict_result_hit),
		.iBRANCH_PREDICT_RESULT_JUMP(branch_predict_result_jump),
		.iBRANCH_PREDICT_RESULT_JUMP_ADDR(branch_predict_result_jump_addr),
		.iBRANCH_PREDICT_RESULT_INST_ADDR(branch_predict_result_inst_addr),
		//Previous
		.iPREV_INST_VALID(icache2fetch_valid),
		.iPREV_INST(icache2fetch_inst),
		.oPREV_LOCK(fetch2icache_lock),
		//Fetch
		.oPREV_FETCH_REQ(fetch2icache_req),
		.oPREV_FETCH_ADDR(fetch2icache_addr),
		.iPREV_FETCH_LOCK(icache2fetch_lock),
		//Next
		.oNEXT_INST_VALID(fetch2lbuffer_inst_valid),
		.oNEXT_BRANCH_PREDICT(fetch2lbuffer_branch_predict),
		.oNEXT_BRANCH_PREDICT_ADDR(fetch2lbuffer_branch_predict_addr),
		.oNEXT_INST(fetch2lbuffer_inst),
		.oNEXT_PC(fetch2lbuffer_pc),
		.iNEXT_FETCH_STOP(lbuffer2fetch_fetch_stop),
		.iNEXT_LOCK(lbuffer2fetch_fetch_lock)
	);

	instruction_buffer LOOPBUFFER(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		.iEVENT_START(core_event_start),
		//Prev
		.iPREV_INST_VALID(fetch2lbuffer_inst_valid),
		.iPREV_BRANCH_PREDICT(fetch2lbuffer_branch_predict),
		.iPREV_BRANCH_PREDICT_ADDR(fetch2lbuffer_branch_predict_addr),
		.iPREV_INST(fetch2lbuffer_inst),
		.iPREV_PC(fetch2lbuffer_pc),
		.oPREV_FETCH_STOP(lbuffer2fetch_fetch_stop),
		.oPREV_LOCK(lbuffer2fetch_fetch_lock),
		//Next
		.oNEXT_INST_VALID(lbuffer2decoder_inst_valid),
		.oNEXT_BRANCH_PREDICT(lbuffer2decoder_branch_predict),
		.oNEXT_BRANCH_PREDICT_ADDR(lbuffer2decoder_branch_predict_addr),
		.oNEXT_INST(lbuffer2decoder_inst),
		.oNEXT_PC(lbuffer2decoder_pc),
		.iNEXT_LOCK(decoder2lbuffer_lock)
	);

	decode DECODE(
		//System
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Free
		.iEVENT_START(core_event_start),
		//Previous
		.iPREV_INST_VALID(lbuffer2decoder_inst_valid),
		.iPREV_BRANCH_PREDICT(lbuffer2decoder_branch_predict),
		.iPREV_BRANCH_PREDICT_ADDR(lbuffer2decoder_branch_predict_addr),
		.iPREV_INST(lbuffer2decoder_inst),
		.iPREV_PC(lbuffer2decoder_pc),
		.oPREV_LOCK(decoder2lbuffer_lock),
		//Next-0
		.oNEXT_VALID(decoder2dispatch_valid),
		.oNEXT_BRANCH_PREDICT(decoder2dispatch_branch_predict),
		.oNEXT_BRANCH_PREDICT_ADDR(decoder2dispatch_branch_predict_addr),
		.oNEXT_SOURCE0_ACTIVE(decoder2dispatch_source0_active),
		.oNEXT_SOURCE1_ACTIVE(decoder2dispatch_source1_active),
		.oNEXT_SOURCE0_SYSREG(decoder2dispatch_source0_sysreg),
		.oNEXT_SOURCE1_SYSREG(decoder2dispatch_source1_sysreg),
		.oNEXT_ADV_ACTIVE(decoder2dispatch_adv_active),
		.oNEXT_DESTINATION_SYSREG(decoder2dispatch_destination_sysreg),
		.oNEXT_WRITEBACK(decoder2dispatch_writeback),
		.oNEXT_FLAGS_WRITEBACK(decoder2dispatch_flags_writeback),
		.oNEXT_CMD(decoder2dispatch_cmd),
		.oNEXT_CC_AFE(decoder2dispatch_cc_afe),
		.oNEXT_SOURCE0(decoder2dispatch_source0),
		.oNEXT_SOURCE1(decoder2dispatch_source1),
		.oNEXT_ADV_DATA(decoder2dispatch_adv_data),
		.oNEXT_SOURCE0_FLAGS(decoder2dispatch_source0_flags),
		.oNEXT_SOURCE1_IMM(decoder2dispatch_source1_imm),
		.oNEXT_DESTINATION(decoder2dispatch_destination),
		.oNEXT_EX_SYS_REG(decoder2dispatch_ex_sys_reg),
		.oNEXT_EX_SYS_LDST(decoder2dispatch_ex_sys_ldst),
		.oNEXT_EX_LOGIC(decoder2dispatch_ex_logic),
		.oNEXT_EX_SHIFT(decoder2dispatch_ex_shift),
		.oNEXT_EX_ADDER(decoder2dispatch_ex_addr),
		.oNEXT_EX_MUL(decoder2dispatch_ex_mul),
		.oNEXT_EX_LDST(decoder2dispatch_ex_ldst),
		.oNEXT_EX_BRANCH(decoder2dispatch_ex_branch),
		.oNEXT_PC(decoder2dispatch_pc),
		.iNEXT_LOCK(dispatch2decoder_lock)
	);

	allocate ALLOCATE(
		//System
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Pipeline Controll
		.iEVENT_HOLD(core_event_hold),
		.iEVENT_START(core_event_start),
		.iEVENT_IRQ_FRONT2BACK(core_event_irq_front2back),
		.iEVENT_IRQ_BACK2FRONT(core_event_irq_back2front),
		.iEVENT_END(core_event_end),
		//Sysreg write
		.iEVENT_SETREG_PPCR_SET(core_event_sysreg_set_ppcr_set),
		.iEVENT_SETREG_FI0R_SET(core_event_sysreg_set_fi0r_set),
		.iEVENT_SETREG_FI1R_SET(core_event_sysreg_set_fi1r_set),
		.iEVENT_SETREG_PCR_SET(core_event_sysreg_set_pcr_set),
		.iEVENT_SETREG_PPCR(core_event_sysreg_set_ppcr),
		.iEVENT_SETREG_FI0R(core_event_sysreg_set_fi0r),
		.iEVENT_SETREG_FI1R(core_event_sysreg_set_fi1r),
		.iEVENT_SETREG_PCR(core_event_sysreg_set_pcr),
		//System Register Input
		.iSYSREG_FLAGR(sysreg_flagr),
		//System Register Output
		.oSYSREG_PCR(sysreg_pcr),
		.oSYSREG_IDTR(sysreg_idtr),
		.oSYSREG_PSR(sysreg_psr),
		.oSYSREG_PPSR(sysreg_ppsr),
		.oSYSREG_PPCR(sysreg_ppcr),
		.oSYSREG_SPR(sysreg_spr),
		.oSYSREG_PFLAGR(sysreg_pflagr),
		//Pipeline
		.iPREV_VALID(decoder2dispatch_valid),
		.iPREV_BRANCH_PREDICT(decoder2dispatch_branch_predict),
		.iPREV_BRANCH_PREDICT_ADDR(decoder2dispatch_branch_predict_addr),
		.iPREV_SOURCE0_ACTIVE(decoder2dispatch_source0_active),
		.iPREV_SOURCE1_ACTIVE(decoder2dispatch_source1_active),
		.iPREV_SOURCE0_SYSREG(decoder2dispatch_source0_sysreg),
		.iPREV_SOURCE1_SYSREG(decoder2dispatch_source1_sysreg),
		.iPREV_ADV_ACTIVE(decoder2dispatch_adv_active),
		.iPREV_DESTINATION_SYSREG(decoder2dispatch_destination_sysreg),
		.iPREV_DESTINATION(decoder2dispatch_destination),
		.iPREV_WRITEBACK(decoder2dispatch_writeback),
		.iPREV_FLAGS_WRITEBACK(decoder2dispatch_flags_writeback),
		.iPREV_CMD(decoder2dispatch_cmd),
		.iPREV_CC_AFE(decoder2dispatch_cc_afe),
		.iPREV_SOURCE0(decoder2dispatch_source0),
		.iPREV_SOURCE1(decoder2dispatch_source1),
		.iPREV_ADV_DATA(decoder2dispatch_adv_data),
		.iPREV_SOURCE0_FLAGS(decoder2dispatch_source0_flags),
		.iPREV_SOURCE1_IMM(decoder2dispatch_source1_imm),
		.iPREV_EX_SYS_REG(decoder2dispatch_ex_sys_reg),
		.iPREV_EX_SYS_LDST(decoder2dispatch_ex_sys_ldst),
		.iPREV_EX_LOGIC(decoder2dispatch_ex_logic),
		.iPREV_EX_SHIFT(decoder2dispatch_ex_shift),
		.iPREV_EX_ADDER(decoder2dispatch_ex_addr),
		.iPREV_EX_MUL(decoder2dispatch_ex_mul),
		.iPREV_EX_LDST(decoder2dispatch_ex_ldst),
		.iPREV_EX_BRANCH(decoder2dispatch_ex_branch),
		.iPREV_PC(decoder2dispatch_pc),
		.oPREV_LOCK(dispatch2decoder_lock),
		//Next
		.oNEXT_VALID(dispatch2execution_valid),
		.oNEXT_BRANCH_PREDICT(dispatch2execution_branch_predict),
		.oNEXT_BRANCH_PREDICT_ADDR(dispatch2execution_branch_predict_addr),
		.oNEXT_SYSREG_PSR(dispatch2execution_sysreg_psr),
		.oNEXT_SYSREG_FRCR(dispatch2execution_sysreg_frcr),
		.oNEXT_DESTINATION_SYSREG(dispatch2execution_destination_sysreg),
		.oNEXT_DESTINATION(dispatch2execution_destination),
		.oNEXT_WRITEBACK(dispatch2execution_writeback),
		.oNEXT_FLAGS_WRITEBACK(dispatch2execution_flags_writeback),
		.oNEXT_CMD(dispatch2execution_cmd),
		.oNEXT_CC_AFE(dispatch2execution_cc_afe),
		.oNEXT_SPR(dispatch2execution_spr),
		.oNEXT_SOURCE0(dispatch2execution_source0),
		.oNEXT_SOURCE1(dispatch2execution_source1),
		.oNEXT_ADV_DATA(dispatch2execution_adv_data),
		.oNEXT_SOURCE0_POINTER(dispatch2execution_source0_pointer),
		.oNEXT_SOURCE1_POINTER(dispatch2execution_source1_pointer),
		.oNEXT_SOURCE0_SYSREG(dispatch2execution_source0_sysreg),
		.oNEXT_SOURCE1_SYSREG(dispatch2execution_source1_sysreg),
		.oNEXT_SOURCE1_IMM(dispatch2execution_source1_imm),
		.oNEXT_SOURCE0_FLAGS(dispatch2execution_source0_flags),
		.oNEXT_ADV_ACTIVE(dispatch2execution_adv_active),
		.oNEXT_EX_SYS_REG(dispatch2execution_ex_sys_reg),
		.oNEXT_EX_SYS_LDST(dispatch2execution_ex_sys_ldst),
		.oNEXT_EX_LOGIC(dispatch2execution_ex_logic),
		.oNEXT_EX_SHIFT(dispatch2execution_ex_shift),
		.oNEXT_EX_ADDER(dispatch2execution_ex_addr),
		.oNEXT_EX_MUL(dispatch2execution_ex_mul),
		.oNEXT_EX_LDST(dispatch2execution_ex_ldst),
		.oNEXT_EX_BRANCH(dispatch2execution_ex_branch),
		.oNEXT_PC(dispatch2execution_pc),
		.iNEXT_LOCK(execution2dispatch_lock),
		//Write Back
		.iWB_VALID(execution2dispatch_valid),
		.iWB_DATA(execution2dispatch_data),
		.iWB_DESTINATION(execution2dispatch_destination),
		.iWB_DESTINATION_SYSREG(execution2dispatch_destination_sysreg),
		.iWB_WRITEBACK(execution2dispatch_writeback),
		.iWB_SPR_WRITEBACK(execution2dispatch_spr_writeback),
		.iWB_SPR(execution2dispatch_spr),
		.iWB_FRCR(execution2dispatch_frcr),
		.iWB_PC(execution2dispatch_pc)
	);

	execute EXECUTE(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Event CTRL
		.iEVENT_HOLD(core_event_hold),
		.iEVENT_START(core_event_start),
		.iEVENT_IRQ_FRONT2BACK(core_event_irq_front2back),
		.iEVENT_IRQ_BACK2FRONT(core_event_irq_back2front),
		.iEVENT_END(core_event_end),
		//Exception LOCK
		.oEXCEPTION_LOCK(execute_exception_lock),
		//System Register
		.iSYSREG_PFLAGR(sysreg_pflagr),
		.oSYSREG_FLAGR(sysreg_flagr),
		//Pipeline
		.iPREV_VALID(dispatch2execution_valid),
		.iPREV_BRANCH_PREDICT(dispatch2execution_branch_predict),
		.iPREV_BRANCH_PREDICT_ADDR(dispatch2execution_branch_predict_addr),
		.iPREV_SYSREG_PSR(dispatch2execution_sysreg_psr),
		.iPREV_SYSREG_FRCR(dispatch2execution_sysreg_frcr),
		.iPREV_DESTINATION_SYSREG(dispatch2execution_destination_sysreg),
		.iPREV_DESTINATION(dispatch2execution_destination),
		.iPREV_WRITEBACK(dispatch2execution_writeback),
		.iPREV_FLAGS_WRITEBACK(dispatch2execution_flags_writeback),
		.iPREV_CMD(dispatch2execution_cmd),
		.iPREV_CC_AFE(dispatch2execution_cc_afe),
		.iPREV_SPR(dispatch2execution_spr),
		.iPREV_SOURCE0(dispatch2execution_source0),
		.iPREV_SOURCE1(dispatch2execution_source1),
		.iPREV_ADV_DATA(dispatch2execution_adv_data),
		.iPREV_SOURCE0_POINTER(dispatch2execution_source0_pointer),
		.iPREV_SOURCE1_POINTER(dispatch2execution_source1_pointer),
		.iPREV_SOURCE0_SYSREG(dispatch2execution_source0_sysreg),
		.iPREV_SOURCE1_SYSREG(dispatch2execution_source1_sysreg),
		.iPREV_SOURCE1_IMM(dispatch2execution_source1_imm),
		.iPREV_SOURCE0_FLAGS(dispatch2execution_source0_flags),
		.iPREV_ADV_ACTIVE(dispatch2execution_adv_active),
		.iPREV_EX_SYS_REG(dispatch2execution_ex_sys_reg),
		.iPREV_EX_SYS_LDST(dispatch2execution_ex_sys_ldst),
		.iPREV_EX_LOGIC(dispatch2execution_ex_logic),
		.iPREV_EX_SHIFT(dispatch2execution_ex_shift),
		.iPREV_EX_ADDER(dispatch2execution_ex_addr),
		.iPREV_EX_MUL(dispatch2execution_ex_mul),
		.iPREV_EX_LDST(dispatch2execution_ex_ldst),
		.iPREV_EX_BRANCH(dispatch2execution_ex_branch),
		.iPREV_PC(dispatch2execution_pc),
		.oPREV_LOCK(execution2dispatch_lock),
		//Data Port
		.oDATAIO_REQ(execution2ldst_ldst_req),
		.iDATAIO_BUSY(ldst2execution_ldst_busy),
		.oDATAIO_ORDER(execution2ldst_ldst_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oDATAIO_MASK(execution2ldst_ldst_mask),//[0]=Byte0, [1]=Byte1...
		.oDATAIO_RW(execution2ldst_ldst_rw),		//0=Read 1=Write
		.oDATAIO_ADDR(execution2ldst_ldst_addr),
		.oDATAIO_DATA(execution2ldst_ldst_data),
		.iDATAIO_REQ(ldst2execution_ldst_req),
		.iDATAIO_DATA(ldst2execution_ldst_data),
		//Next
		.oNEXT_VALID(execution2dispatch_valid),
		.oNEXT_DATA(execution2dispatch_data),
		.oNEXT_DESTINATION(execution2dispatch_destination),
		.oNEXT_DESTINATION_SYSREG(execution2dispatch_destination_sysreg),
		.oNEXT_WRITEBACK(execution2dispatch_writeback),
		.oNEXT_SPR_WRITEBACK(execution2dispatch_spr_writeback),
		.oNEXT_SPR(execution2dispatch_spr),
		.oNEXT_FRCR(execution2dispatch_frcr),
		.oNEXT_PC(execution2dispatch_pc),
		//Branch
		.oBRANCH_ADDR(exception_branch_addr),
		.oJUMP_VALID(exception_jump_valid),
		.oINTR_VALID(exception_intr_valid),
		.oIDTSET_VALID(exception_idtset_valid),
		.oPSRSET_VALID(exception_psr_valid),
		//Branch Predictor
		.oBPREDICT_JUMP_INST(branch_predict_result_jump_inst),
		.oBPREDICT_PREDICT(branch_predict_result_predict),
		.oBPREDICT_HIT(branch_predict_result_hit),
		.oBPREDICT_JUMP(branch_predict_result_jump),
		.oBPREDICT_JUMP_ADDR(branch_predict_result_jump_addr),
		.oBPREDICT_INST_ADDR(branch_predict_result_inst_addr)
	);

	load_store_pipe_arbiter LDST_PIPE_ARBITOR(
		.oLDST_REQ(ldst_arbiter2d_cache_req),
		.iLDST_BUSY(d_cache2ldst_arbiter_busy),
		.oLDST_ORDER(ldst_arbiter2d_cache_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oLDST_MASK(ldst_arbiter2d_cache_mask),
		.oLDST_RW(ldst_arbiter2d_cache_rw),		//0=Read 1=Write
		.oLDST_ADDR(ldst_arbiter2d_cache_addr),
		.oLDST_DATA(ldst_arbiter2d_cache_data),
		.iLDST_VALID(d_cache2ldst_arbiter_valid),
		.iLDST_DATA(d_cache2ldst_arbiter_data),
		//Selector
		.iUSE_SEL(exception2ldst_ldst_use),		//0:Execution | 1:Exception
		//Execution Module
		.iEXE_REQ(execution2ldst_ldst_req),
		.oEXE_BUSY(ldst2execution_ldst_busy),
		.iEXE_ORDER(execution2ldst_ldst_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.iEXE_MASK(execution2ldst_ldst_mask),
		.iEXE_RW(execution2ldst_ldst_rw),		//0=Read 1=Write
		.iEXE_ADDR(execution2ldst_ldst_addr),
		.iEXE_DATA(execution2ldst_ldst_data),
		.oEXE_REQ(ldst2execution_ldst_req),
		.oEXE_DATA(ldst2execution_ldst_data),
		//Exception Module
		.iEXCEPT_REQ(exception2ldst_ldst_req),
		.oEXCEPT_BUSY(ldst2exception_ldst_busy),
		.iEXCEPT_ORDER(exception2ldst_ldst_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.iEXCEPT_RW(exception2ldst_ldst_rw),		//0=Read 1=Write
		.iEXCEPT_ADDR(exception2ldst_ldst_addr),
		.iEXCEPT_DATA(exception2ldst_ldst_data),
		.oEXCEPT_REQ(ldst2exception_ldst_req),
		.oEXCEPT_DATA(ldst2exception_ldst_data)
	);

	l1_data_cache L1_DATA_CACHE(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Remove
		.iREMOVE(core_event_start),
		/****************************************
		Load/Store Module
		****************************************/
		//Load Store -> Cache
		.iLDST_REQ(ldst_arbiter2d_cache_req),
		.oLDST_BUSY(d_cache2ldst_arbiter_busy),
		.iLDST_ORDER(ldst_arbiter2d_cache_order),
		.iLDST_MASK(ldst_arbiter2d_cache_mask),
		.iLDST_RW(ldst_arbiter2d_cache_rw),
		.iLDST_ADDR(ldst_arbiter2d_cache_addr),
		.iLDST_DATA(ldst_arbiter2d_cache_data),
		//Cache -> Load Store
		.oLDST_VALID(d_cache2ldst_arbiter_valid),
		.oLDST_DATA(d_cache2ldst_arbiter_data),
		/****************************************
		Data Memory
		****************************************/
		//Req
		.oDATA_REQ(oDATA_REQ),
		.iDATA_LOCK(iDATA_LOCK),
		.oDATA_ORDER(oDATA_ORDER),
		.oDATA_MASK(oDATA_MASK),
		.oDATA_RW(oDATA_RW),		//0=Write 1=Read
		.oDATA_ADDR(oDATA_ADDR),
		//This -> Data RAM
		.oDATA_DATA(oDATA_DATA),
		//Data RAM -> This
		.iDATA_VALID(iDATA_VALID),
		.iDATA_DATA(iDATA_DATA),
		/****************************************
		IO
		****************************************/
		//Req
		.oIO_REQ(oIO_REQ),
		.iIO_BUSY(iIO_BUSY),
		.oIO_ORDER(oIO_ORDER),
		.oIO_RW(oIO_RW),			//0=Write 1=Read
		.oIO_ADDR(oIO_ADDR),
		//Write
		.oIO_DATA(oIO_DATA),
		//Rec
		.iIO_VALID(iIO_VALID),
		.iIO_DATA(iIO_DATA)
	);


endmodule


`default_nettype wire

