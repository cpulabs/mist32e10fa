

`default_nettype none
`timescale 1ns/1ns

module tb_inst_level;

	localparam PL_CYCLE = 20;		//It's necessary "Core Clock == Bus Clock". This restriction is removed near future.
	localparam PL_RESET_TIME = 20;

	/****************************************
	System
	****************************************/
	reg iCLOCK;
	reg inRESET;
	reg iRESET_SYNC;
	/****************************************
	Memory BUS
	****************************************/
	//Req
	wire oMEMORY_REQ;
	wire iMEMORY_LOCK;
	wire [1:0] oMEMORY_ORDER;				//00=Byte Order 01=2Byte Order 10= Word Order 11= None
	wire [3:0] oMEMORY_MASK;
	wire oMEMORY_RW;						//1:Write | 0:Read
	wire [31:0] oMEMORY_ADDR;
	//This -> Data RAM
	wire [31:0] oMEMORY_DATA;
	//Data RAM -> This
	wire iMEMORY_VALID;
	wire oMEMORY_BUSY;
	wire [63:0] iMEMORY_DATA;



	/******************************************************
	Target
	******************************************************/
	mist32e10fa TARGET(
		/****************************************
		System
		****************************************/
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		.iRESET_SYNC(iRESET_SYNC),
		/****************************************
		Memory BUS
		****************************************/
		//Req
		.oMEMORY_REQ(oMEMORY_REQ),
		.iMEMORY_LOCK(iMEMORY_LOCK),
		.oMEMORY_ORDER(oMEMORY_ORDER),				//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.oMEMORY_MASK(oMEMORY_MASK),
		.oMEMORY_RW(oMEMORY_RW),						//1:Write | 0:Read
		.oMEMORY_ADDR(oMEMORY_ADDR),
		//This -> Data RAM
		.oMEMORY_DATA(oMEMORY_DATA),
		//Data RAM -> This
		.iMEMORY_VALID(iMEMORY_VALID),
		.oMEMORY_BUSY(oMEMORY_BUSY),
		.iMEMORY_DATA(iMEMORY_DATA),
		/****************************************
		GCI BUS
		****************************************/
		//Request
		.iEXTIO_BUSY(1'b0),
		//Return
		.iEXTIO_REQ(1'h0),		
		.iEXTIO_DATA(32'h0),
		//Interrupt
		.iEXTIO_IRQ_REQ(1'b0),
		.iEXTIO_IRQ_NUM(6'h00)
	);


	/******************************************************
	Clock
	******************************************************/
	always#(PL_CYCLE/2)begin
		iCLOCK = !iCLOCK;
	end

	/******************************************************
	State
	******************************************************/
	initial begin
		$display("Check Start");
		//Initial
		iCLOCK = 1'b0;
		inRESET = 1'b0;
		iRESET_SYNC = 1'b0;

		//After Reset
		#(PL_RESET_TIME);
		inRESET = 1'b1;

		//
		#(PL_CYCLE*32);
		

		#15000000 begin
			$stop;
		end
	end

	/******************************************************
	Simulation Task
	******************************************************/
	/*
	always@(posedge iCORE_CLOCK)begin
		if(inRESET)begin
			//task_disp_branch();
			//task_disp_loadstore();
		end
	end
	*/



	/******************************************************
	Memory Model
	******************************************************/
	sim_memory_model #(1, "sim_software.hex") MEMORY_MODEL(
		.iCLOCK(iCLOCK),
		.inRESET(inRESET),
		//Req
		.iMEMORY_REQ(oMEMORY_REQ),
		.oMEMORY_LOCK(iMEMORY_LOCK),
		.iMEMORY_ORDER(oMEMORY_ORDER),				//00=Byte Order 01=2Byte Order 10= Word Order 11= None
		.iMEMORY_MASK(oMEMORY_MASK),
		.iMEMORY_RW(oMEMORY_RW),						//1:Write | 0:Read
		.iMEMORY_ADDR(oMEMORY_ADDR),
		//This -> Data RAM
		.iMEMORY_DATA(oMEMORY_DATA),
		//Data RAM -> This
		.oMEMORY_VALID(iMEMORY_VALID),
		.iMEMORY_LOCK(oMEMORY_BUSY),
		.oMEMORY_DATA(iMEMORY_DATA)
	);

	/******************************************************
	Assertion
	******************************************************/
	reg assert_check_flag;
	reg [31:0] assert_wrong_number;
	reg [31:0] assert_wrong_type;
	reg [31:0] assert_result;
	reg [31:0] assert_expect;

		always@(posedge iCLOCK)begin
		if(inRESET && oMEMORY_REQ && !iMEMORY_LOCK && oMEMORY_ORDER == 2'h2 && oMEMORY_RW)begin
			//Finish Check
			if(oMEMORY_ADDR == 32'h0002_0004)begin
				if(!assert_check_flag)begin
					$display("[SIM-ERR]Wrong Data.");
					$display("[SIM-ERR]Wrong Type : %d", assert_wrong_type);
					$display("[SIM-ERR]Index:%d, Expect:%x, Result:%x", assert_wrong_number, assert_expect, assert_result);
					$display("[SIM-ERR]Simulation Finished.");
					$finish;
				end
				else begin
					$display("[SIM-OK]Simulation Finished.");
					$finish;
				end
			end
			//Check Flag
			else if(oMEMORY_ADDR == 32'h0002_0000)begin
				assert_check_flag = oMEMORY_DATA[24];
			end
			//Error Number
			else if(oMEMORY_ADDR == 32'h0002_000c)begin
				assert_wrong_number = {oMEMORY_DATA[7:0], oMEMORY_DATA[15:8], oMEMORY_DATA[23:16], oMEMORY_DATA[31:24]};
			end
			//Error Type
			else if(oMEMORY_ADDR == 32'h0002_0008)begin
				assert_wrong_type = {oMEMORY_DATA[7:0], oMEMORY_DATA[15:8], oMEMORY_DATA[23:16], oMEMORY_DATA[31:24]};
			end
			//Error Result
			else if(oMEMORY_ADDR == 32'h0002_0010)begin
				assert_result = {oMEMORY_DATA[7:0], oMEMORY_DATA[15:8], oMEMORY_DATA[23:16], oMEMORY_DATA[31:24]};
			end
			//Error Expect
			else if(oMEMORY_ADDR == 32'h0002_0014)begin
				assert_expect = {oMEMORY_DATA[7:0], oMEMORY_DATA[15:8], oMEMORY_DATA[23:16], oMEMORY_DATA[31:24]};
			end

		end
	end


endmodule

`default_nettype wire

