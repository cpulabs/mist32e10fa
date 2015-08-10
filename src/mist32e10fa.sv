/****************************************
MIST32E10FA Processor
****************************************/
`default_nettype none
`include "processor.h"
`include "common.h"

module mist32e10fa(
		/****************************************
		System
		****************************************/
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		/****************************************
		Memory BUS
		****************************************/
		//Req
		output wire oMEMORY_REQ,
		input wire iMEMORY_LOCK,
		output wire [1:0] oMEMORY_ORDER,				//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		output wire [3:0] oMEMORY_MASK,
		output wire oMEMORY_RW,						//1:Write | 0:Read
		output wire [31:0] oMEMORY_ADDR,
		//This -> Data RAM
		output wire [31:0] oMEMORY_DATA,
		//Data RAM -> This
		input wire iMEMORY_VALID,
		output wire oMEMORY_BUSY,
		input wire [63:0] iMEMORY_DATA,
		/****************************************
		GCI BUS
		****************************************/
		//Request
		output wire oEXTIO_REQ,					//Input
		input wire iEXTIO_BUSY,
		output wire oEXTIO_RW,						//0=Read : 1=Write
		output wire [31:0] oEXTIO_ADDR,
		output wire [31:0] oEXTIO_DATA,
		//Return
		input wire iEXTIO_REQ,						//Output
		output wire oEXTIO_BUSY,
		input wire [31:0] iEXTIO_DATA,
		//Interrupt
		input wire iEXTIO_IRQ_REQ,
		input wire [5:0] iEXTIO_IRQ_NUM,
		output wire oEXTIO_IRQ_ACK,
		//Interrupt Controll
		output wire oIO_IRQ_CONFIG_TABLE_REQ,
		output wire [5:0] oIO_IRQ_CONFIG_TABLE_ENTRY,
		output wire oIO_IRQ_CONFIG_TABLE_FLAG_MASK,
		output wire oIO_IRQ_CONFIG_TABLE_FLAG_VALID,
		output wire [1:0] oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL
	);


	/****************************************
	Register and Wire
	****************************************/
	//Memory
	wire core2mem_inst_req;
	wire mem2core_inst_lock;
	wire [31:0] core2mem_inst_addr;
	wire mem2core_inst_valid;
	wire core2mem_inst_lock;
	wire [63:0] mem2core_inst_data;
	wire core2mem_data_req;
	wire mem2core_data_lock;
	wire [1:0] core2mem_data_order;
	wire [3:0] core2mem_data_mask;
	wire core2mem_data_rw;		//0=Read | 1=Write
	wire [31:0] core2mem_data_addr;
	wire [31:0] core2mem_data_data;
	wire mem2core_data_valid;
	wire core2mem_data_lock;
	wire [63:0] mem2core_data_data;
	//IO
	wire io2cpu_sysinfo_iosr_valid;
	wire [31:0] io2cpu_sysinfo_iosr;
	wire cpu2io_req;
	wire io2cpu_busy;
	wire [1:0] cpu2io_order;
	wire cpu2io_rw;
	wire [31:0] cpu2io_addr;
	wire [31:0] cpu2io_data;
	wire io2cpu_valid;
	wire [31:0] io2cpu_data;
	wire io2cpu_interrupt_valid;
	wire cpu2io_interrupt_ack;
	wire [5:0] io2cpu_interrupt_num;
	//Memory Port
	wire processor2memory_req;
	wire memory2processor_lock;
	wire [1:0] processor2memory_order;
	wire [3:0] processor2memory_mask;
	wire processor2memory_rw;
	wire [31:0] processor2memory_addr;
	wire [31:0] processor2memory_data;
	wire memory2processor_req;
	wire processor2memory_busy;
	wire [63:0] memory2processor_data;


	/********************************************************************************
	Memory Out
	********************************************************************************/
	//Processor -> Memory
	assign oMEMORY_REQ = processor2memory_req;
	assign oMEMORY_ORDER = processor2memory_order;
	assign oMEMORY_MASK = processor2memory_mask;
	assign oMEMORY_RW = processor2memory_rw;
	assign oMEMORY_ADDR = processor2memory_addr;
	assign oMEMORY_DATA = processor2memory_data;
	assign oMEMORY_BUSY = processor2memory_busy;
	//Memory -> Processor
	assign memory2processor_lock = iMEMORY_LOCK;
	assign memory2processor_req = iMEMORY_VALID;
	assign memory2processor_data = iMEMORY_DATA;


	/********************************************************************************
	Processor Core
	********************************************************************************/
	wire core2io_irq_tables_req;
	wire [5:0] core2io_irq_tables_entry;
	wire core2io_irq_tables_flag_mask;
	wire core2io_irq_tables_flag_valid;
	wire [1:0] core2io_irq_tables_flag_level;

	assign oIO_IRQ_CONFIG_TABLE_REQ = core2io_irq_tables_req;
	assign oIO_IRQ_CONFIG_TABLE_ENTRY = core2io_irq_tables_entry;
	assign oIO_IRQ_CONFIG_TABLE_FLAG_MASK = core2io_irq_tables_flag_mask;
	assign oIO_IRQ_CONFIG_TABLE_FLAG_VALID = core2io_irq_tables_flag_valid;
	assign oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL = core2io_irq_tables_flag_level;

	core CORE(
		/****************************************
		System
		****************************************/
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		/****************************************
		GCI Controll
		****************************************/
		//Interrupt Control
		.oIO_IRQ_CONFIG_TABLE_REQ(core2io_irq_tables_req),
		.oIO_IRQ_CONFIG_TABLE_ENTRY(core2io_irq_tables_entry),
		.oIO_IRQ_CONFIG_TABLE_FLAG_MASK(core2io_irq_tables_flag_mask),
		.oIO_IRQ_CONFIG_TABLE_FLAG_VALID(core2io_irq_tables_flag_valid),
		.oIO_IRQ_CONFIG_TABLE_FLAG_LEVEL(core2io_irq_tables_flag_level),
		/****************************************
		Instruction Memory
		****************************************/
		//Req
		.oINST_REQ(core2mem_inst_req),
		.iINST_LOCK(mem2core_inst_lock),
		.oINST_ADDR(core2mem_inst_addr),
		//Data RAM -> This
		.iINST_VALID(mem2core_inst_valid),
		.oINST_BUSY(core2mem_inst_lock),
		.iINST_DATA(mem2core_inst_data),
		/****************************************
		Data Memory
		****************************************/
		//Req
		.oDATA_REQ(core2mem_data_req),
		.iDATA_LOCK(mem2core_data_lock),
		.oDATA_ORDER(core2mem_data_order),	//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oDATA_MASK(core2mem_data_mask),
		.oDATA_RW(core2mem_data_rw),			//1=Write 0=Read
		.oDATA_ADDR(core2mem_data_addr),
		//This -> Data RAM
		.oDATA_DATA(core2mem_data_data),
		//Data RAM -> This
		.iDATA_VALID(mem2core_data_valid),
		.iDATA_DATA(mem2core_data_data),
		/****************************************
		IO
		****************************************/
		//Req
		.oIO_REQ(cpu2io_req),
		.iIO_BUSY(io2cpu_busy),
		.oIO_ORDER(cpu2io_order),		//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oIO_RW(cpu2io_rw),			//0=Write 1=Read
		.oIO_ADDR(cpu2io_addr),
		//Write
		.oIO_DATA(cpu2io_data),
		//Rec
		.iIO_VALID(io2cpu_valid),
		.iIO_DATA(io2cpu_data),
		/****************************************
		Interrupt
		****************************************/
		.iINTERRUPT_VALID(io2cpu_interrupt_valid),
		.oINTERRUPT_ACK(cpu2io_interrupt_ack),
		.iINTERRUPT_NUM(io2cpu_interrupt_num)
	);


	/********************************************************************************
	Memory Interface
	********************************************************************************/
	//Arbiter to Processor
	wire [3:0] processor2endian_mask;
	wire [31:0] processor2endian_data;

	wire [63:0] endian2processor_data;

	//Memory Pipe Arbiter
	memory_pipe_arbiter MEM_ARBITER(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		//Data(Core -> Memory)
		.iDATA_REQ(core2mem_data_req),
		.oDATA_LOCK(mem2core_data_lock),
		.iDATA_ORDER(core2mem_data_order),
		.iDATA_MASK(core2mem_data_mask),
		.iDATA_RW(core2mem_data_rw),
		.iDATA_ADDR(core2mem_data_addr),
		.iDATA_DATA(core2mem_data_data),
		//Data(Memory -> Core)
		.oDATA_REQ(mem2core_data_valid),
		.iDATA_BUSY(1'b0),
		.oDATA_DATA(mem2core_data_data),
		//Inst(Core -> Memory)
		.iINST_REQ(core2mem_inst_req),
		.oINST_LOCK(mem2core_inst_lock),
		.iINST_ADDR(core2mem_inst_addr),
		//Inst(Memory -> Core)
		.oINST_REQ(mem2core_inst_valid),
		.iINST_BUSY(core2mem_inst_lock),
		.oINST_DATA(mem2core_inst_data),
		//Memory(OutPort)
		.oMEMORY_REQ(processor2memory_req),
		.iMEMORY_LOCK(memory2processor_lock),
		.oMEMORY_ORDER(processor2memory_order),
		.oMEMORY_MASK(processor2endian_mask),
		.oMEMORY_RW(processor2memory_rw),
		.oMEMORY_ADDR(processor2memory_addr),
		.oMEMORY_DATA(processor2endian_data),
		//Memory(InPort)
		.iMEMORY_VALID(memory2processor_req),
		.oMEMORY_BUSY(processor2memory_busy),
		.iMEMORY_DATA(endian2processor_data)		
	);
	
	//Endian Control
	endian_controller ENDIAN_TO_MEM(
		//Source
		.iSRC_MASK(processor2endian_mask),
		.iSRC_DATA(processor2endian_data),
		//Destnation
		.oDEST_MASK(processor2memory_mask),
		.oDEST_DATA(processor2memory_data)
	);

	endian_controller ENDIAN_TO_CPU_L(
		//Source
		.iSRC_MASK(4'hf),
		.iSRC_DATA(memory2processor_data[31:0]),
		//Destnation
		.oDEST_MASK(),
		.oDEST_DATA(endian2processor_data[31:0])
	);

	endian_controller ENDIAN_TO_CPU_H(
		//Source
		.iSRC_MASK(4'hf),
		.iSRC_DATA(memory2processor_data[63:32]),
		//Destnation
		.oDEST_MASK(),
		.oDEST_DATA(endian2processor_data[63:32])
	);


	/********************************************************************************
	IO Interface
	********************************************************************************/
	//Peripheral Interface Controller
	peripheral_interface_controller PIC( //peripheral_interface_controller
		/****************************************
		System
		****************************************/
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		/****************************************
		IO - CPU Connection
		****************************************/
		//Req
		.iIO_REQ(cpu2io_req),
		.oIO_BUSY(io2cpu_busy),
		.iIO_ORDER(cpu2io_order),				//if (!iIO_RW && iIO_ORDER!=2'h2) then Alignment Fault
		.iIO_RW(cpu2io_rw),					//0=Write 1=Read
		.iIO_ADDR(cpu2io_addr),
		.iIO_DATA(cpu2io_data),
		//Output
		.oIO_VALID(io2cpu_valid),
		.iIO_BUSY(1'b0),
		.oIO_DATA(io2cpu_data),
		//Interrupt
		.oIO_INTERRUPT_VALID(io2cpu_interrupt_valid),
		.iIO_INTERRUPT_ACK(cpu2io_interrupt_ack),
		.oIO_INTERRUPT_NUM(io2cpu_interrupt_num),
		/****************************************
		To GCI Connection
		****************************************/
		//Request
		.oEXTIO_REQ(oEXTIO_REQ),
		.iEXTIO_BUSY(iEXTIO_BUSY),
		.oEXTIO_RW(oEXTIO_RW),				//0=Read : 1=Write
		.oEXTIO_ADDR(oEXTIO_ADDR),
		.oEXTIO_DATA(oEXTIO_DATA),
		//Return
		.iEXTIO_REQ(iEXTIO_REQ),
		.oEXTIO_BUSY(oEXTIO_BUSY),
		.iEXTIO_DATA(iEXTIO_DATA),
		//Interrupt
		.iEXTIO_IRQ_REQ(iEXTIO_IRQ_REQ),
		.iEXTIO_IRQ_NUM(iEXTIO_IRQ_NUM),
		.oEXTIO_IRQ_ACK(oEXTIO_IRQ_ACK)
	);



endmodule


`default_nettype wire

