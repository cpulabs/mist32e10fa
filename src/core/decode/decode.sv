
`include "core.h"
`default_nettype none			


module decode(
		//System
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//Free
		input wire iEVENT_START,	
		//Previous
		input wire iPREV_INST_VALID,
		input wire iPREV_BRANCH_PREDICT,
		input wire [31:0] iPREV_BRANCH_PREDICT_ADDR,
		input wire [31:0] iPREV_INST,
		input wire [31:0] iPREV_PC,
		output wire oPREV_LOCK,
		//Next	
		output wire oNEXT_VALID,
		output wire oNEXT_BRANCH_PREDICT,
		output wire [31:0] oNEXT_BRANCH_PREDICT_ADDR,
		output wire oNEXT_SOURCE0_ACTIVE,			
		output wire oNEXT_SOURCE1_ACTIVE,		
		output wire oNEXT_SOURCE0_SYSREG,		
		output wire oNEXT_SOURCE1_SYSREG,		
		output wire oNEXT_ADV_ACTIVE,	
		output wire oNEXT_DESTINATION_SYSREG,		
		output wire oNEXT_WRITEBACK,
		output wire oNEXT_FLAGS_WRITEBACK,				
		output wire [4:0] oNEXT_CMD,
		output wire [3:0] oNEXT_CC_AFE,
		output wire [4:0] oNEXT_SOURCE0,
		output wire [31:0] oNEXT_SOURCE1,
		output wire [5:0] oNEXT_ADV_DATA,
		output wire oNEXT_SOURCE0_FLAGS,
		output wire oNEXT_SOURCE1_IMM,
		output wire [4:0] oNEXT_DESTINATION,
		output wire oNEXT_EX_SYS_REG,	
		output wire oNEXT_EX_SYS_LDST,	
		output wire oNEXT_EX_LOGIC,
		output wire oNEXT_EX_SHIFT,
		output wire oNEXT_EX_ADDER,
		output wire oNEXT_EX_MUL,		
		output wire oNEXT_EX_LDST,
		output wire oNEXT_EX_BRANCH,
		output wire [31:0] oNEXT_PC,
		input wire iNEXT_LOCK
	);

	/****************************************
	Decode Function Module
	****************************************/
	wire decode_source0_active;			
	wire decode_source1_active;		
	wire decode_source0_sysreg;		
	wire decode_source1_sysreg;		
	wire decode_adv_active;	
	wire decode_destination_sysreg;	
	wire decode_writeback;
	wire decode_flags_writeback;			
	wire [4:0] decode_cmd;
	wire [3:0] decode_cc_afe;
	wire [4:0] decode_source0;
	wire [31:0] decode_source1;
	wire [5:0] decode_adv_data;
	wire decode_source0_flags;
	wire decode_source1_imm;
	wire [4:0] decode_destination;
	wire decode_ex_sys_reg;	
	wire decode_ex_sys_ldst;	
	wire decode_ex_logic;
	wire decode_ex_shift;
	wire decode_ex_adder;
	wire decode_ex_mul;			
	wire decode_ex_ldst;
	wire decode_ex_branch;



	decode_function DECODE_FUNCTION(
		//Input
		.iINSTLUCTION(iPREV_INST),
		//Info
		//.oINF_ERROR(),
		//Decode
		.oDECODE_SOURCE0_ACTIVE(decode_source0_active),			
		.oDECODE_SOURCE1_ACTIVE(decode_source1_active),		
		.oDECODE_SOURCE0_SYSREG(decode_source0_sysreg),		
		.oDECODE_SOURCE1_SYSREG(decode_source1_sysreg),	
		.oDECODE_ADV_ACTIVE(decode_adv_active),	
		.oDECODE_DESTINATION_SYSREG(decode_destination_sysreg),	
		.oDECODE_WRITEBACK(decode_writeback),
		.oDECODE_FLAGS_WRITEBACK(decode_flags_writeback),			
		.oDECODE_CMD(decode_cmd),
		.oDECODE_CC_AFE(decode_cc_afe),
		.oDECODE_SOURCE0(decode_source0),
		.oDECODE_SOURCE1(decode_source1),
		.oDECODE_ADV_DATA(decode_adv_data),
		.oDECODE_SOURCE0_FLAGS(decode_source0_flags),
		.oDECODE_SOURCE1_IMM(decode_source1_imm),
		.oDECODE_DESTINATION(decode_destination),
		.oDECODE_EX_SYS_REG(decode_ex_sys_reg),	
		.oDECODE_EX_SYS_LDST(decode_ex_sys_ldst),	
		.oDECODE_EX_LOGIC(decode_ex_logic),
		.oDECODE_EX_SHIFT(decode_ex_shift),
		.oDECODE_EX_ADDER(decode_ex_adder),
		.oDECODE_EX_MUL(decode_ex_mul),			
		.oDECODE_EX_LDST(decode_ex_ldst),
		.oDECODE_EX_BRANCH(decode_ex_branch)
	);

	
	//Pipeline 
	reg b_valid;
	reg b_branch_predict;
	reg [31:0] b_branch_predict_addr;
	reg [13:0] b_mmu_flags;
	reg b_destination_sysreg;			
	reg b_writeback;	
	reg b_flag_writeback;				
	reg [4:0] b_cmd;
	reg [3:0] b_cc_afe;
	reg [4:0] b_source0;
	reg [31:0] b_source1;
	reg b_source0_flags;
	reg b_source1_imm;
	reg b_source0_active;	
	reg b_source1_active;	
	reg b_source0_sysreg;				
	reg b_source1_sysreg;
	reg [5:0] b_adv_data;
	reg b_adv_active;
	reg [4:0] b_destination;	
	reg b_ex_sys_reg;
	reg b_ex_sys_ldst;
	reg b_ex_logic;
	reg b_ex_shift;
	reg b_ex_adder;
	reg b_ex_mul;
	reg b_ex_ldst;
	reg b_ex_branch;
	reg b_error;
	reg [31:0] b_pc;
	
	always@(posedge iCLOCK, negedge inRESET)begin
		if(!inRESET)begin
			b_valid <= 1'b0;	
			b_branch_predict <= 1'b0;
			b_branch_predict_addr <= 32'h0;
			b_source0_active <= 1'b0;			
			b_source1_active <= 1'b0;	
			b_source0_sysreg <= 1'b0;	
			b_source1_sysreg <= 1'b0;	
			b_adv_data <= 6'h0;
			b_adv_active <= 1'b0;					
			b_destination_sysreg <= 1'b0;	
			b_writeback <= 1'b0;		
			b_flag_writeback <= 1'b0;			
			b_cmd <= {5{1'b0}};
			b_cc_afe <= {4{1'b0}};
			b_source0 <= {5{1'b0}};
			b_source1 <= {32{1'b0}};
			b_source0_flags <= 1'b0;
			b_source1_imm <= 1'b0;
			b_destination <= {5{1'b0}};
			b_ex_sys_reg <= 1'b0;
			b_ex_sys_ldst <= 1'b0;
			b_ex_logic <= 1'b0;
			b_ex_shift <= 1'b0;
			b_ex_adder <= 1'b0;
			b_ex_mul <= 1'b0;
			b_ex_ldst <= 1'b0;
			b_ex_branch <= 1'b0;
			b_error <= 1'b0;
			b_pc <= 32'h0;
		end
		else if(iRESET_SYNC || iEVENT_START)begin
			b_valid <= 1'b0;
			b_branch_predict <= 1'b0;
			b_branch_predict_addr <= 32'h0;
			b_source0_active <= 1'b0;			
			b_source1_active <= 1'b0;	
			b_source0_sysreg <= 1'b0;	
			b_source1_sysreg <= 1'b0;	
			b_adv_data <= 6'h0;
			b_adv_active <= 1'b0;	
			b_destination_sysreg <= 1'b0;	
			b_writeback <= 1'b0;		
			b_flag_writeback <= 1'b0;				
			b_cmd <= {5{1'b0}};
			b_cc_afe <= {4{1'b0}};
			b_source0 <= {5{1'b0}};
			b_source1 <= {32{1'b0}};
			b_source0_flags <= 1'b0;
			b_source1_imm <= 1'b0;
			b_destination <= {5{1'b0}};
			b_ex_sys_reg <= 1'b0;
			b_ex_sys_ldst <= 1'b0;
			b_ex_logic <= 1'b0;
			b_ex_shift <= 1'b0;
			b_ex_adder <= 1'b0;
			b_ex_mul <= 1'b0;
			b_ex_ldst <= 1'b0;
			b_ex_branch <= 1'b0;
			b_error <= 1'b0;
			b_pc <= 32'h0;
		end
		else begin
			if(!iNEXT_LOCK)begin
				//Pipeline 1
				b_valid <= iPREV_INST_VALID;
				//Flag
				b_branch_predict <= iPREV_BRANCH_PREDICT;
				b_branch_predict_addr <= iPREV_BRANCH_PREDICT_ADDR;
				//Inst
				b_source0_active <= decode_source0_active;			
				b_source1_active <= decode_source1_active;
				b_source0_sysreg <= decode_source0_sysreg;
				b_source1_sysreg <= decode_source1_sysreg;
				b_adv_data <= decode_adv_data;
				b_adv_active <= decode_adv_active;
				b_destination_sysreg <= decode_destination_sysreg;	
				b_writeback <= decode_writeback;
				b_flag_writeback <= decode_flags_writeback;					
				b_cmd <= decode_cmd;
				b_cc_afe <= decode_cc_afe;
				b_source0 <= decode_source0;
				b_source1 <= decode_source1;
				b_source0_flags <= decode_source0_flags;
				b_source1_imm <= decode_source1_imm;
				b_destination <= decode_destination;
				b_ex_sys_reg <= decode_ex_sys_reg;
				b_ex_sys_ldst <= decode_ex_sys_ldst;
				b_ex_logic <= decode_ex_logic;
				b_ex_shift <= decode_ex_shift;
				b_ex_adder <= decode_ex_adder;
				b_ex_mul <= decode_ex_mul;
				b_ex_ldst <= decode_ex_ldst;
				b_ex_branch <= decode_ex_branch;
				b_error <= 1'b0;
				//Program Counter
				b_pc <= iPREV_PC;
			end
		end
	end //always
	
	
	/****************************************
	This -> Previous
	****************************************/			
	assign oPREV_LOCK = iNEXT_LOCK;
				
	/****************************************
	This -> Next
	****************************************/
	//Pipeline1
	assign oNEXT_VALID = b_valid;
	assign oNEXT_BRANCH_PREDICT = b_branch_predict;
	assign oNEXT_BRANCH_PREDICT_ADDR = b_branch_predict_addr;
	assign oNEXT_SOURCE0_ACTIVE = b_source0_active;
	assign oNEXT_SOURCE1_ACTIVE = b_source1_active;
	assign oNEXT_SOURCE0_SYSREG = b_source0_sysreg;
	assign oNEXT_SOURCE1_SYSREG = b_source1_sysreg;
	assign oNEXT_ADV_DATA = b_adv_data;
	assign oNEXT_ADV_ACTIVE = b_adv_active;
	assign oNEXT_DESTINATION_SYSREG = b_destination_sysreg;
	assign oNEXT_WRITEBACK = b_writeback;
	assign oNEXT_FLAGS_WRITEBACK = b_flag_writeback;
	assign oNEXT_CMD = b_cmd;
	assign oNEXT_CC_AFE = b_cc_afe;
	assign oNEXT_SOURCE0 = b_source0;
	assign oNEXT_SOURCE1 = b_source1;
	assign oNEXT_SOURCE0_FLAGS = b_source0_flags;
	assign oNEXT_SOURCE1_IMM = b_source1_imm;
	assign oNEXT_DESTINATION = b_destination;
	assign oNEXT_EX_SYS_REG = b_ex_sys_reg;
	assign oNEXT_EX_SYS_LDST = b_ex_sys_ldst;
	assign oNEXT_EX_LOGIC = b_ex_logic;
	assign oNEXT_EX_SHIFT = b_ex_shift;
	assign oNEXT_EX_ADDER = b_ex_adder;
	assign oNEXT_EX_MUL = b_ex_mul;
	assign oNEXT_EX_LDST = b_ex_ldst;
	assign oNEXT_EX_BRANCH = b_ex_branch;
	assign oNEXT_PC = b_pc;

endmodule


`default_nettype wire


