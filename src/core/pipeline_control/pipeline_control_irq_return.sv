

`default_nettype none
`include "core.h"

module pipeline_control_irq_return(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESET_SYNC,
		//Request
		input wire iRETURN_START,
		//Finish
		output wire oFINISH
	);

	//SPR Exchange
	wire spr_exchange_finish;
	wire [31:0] spr_exchange_spr;

	/*****************************************************
	State
	*****************************************************/
	localparam PL_STT_IDLE = 2'h0;
	localparam PL_STT_DONE = 2'h1;

	reg [1:0] state;
	reg [1:0] b_state;
	always@*begin
		case(b_state)
			PL_STT_IDLE:
				begin
					if(iRETURN_START)begin
						state = PL_STT_DONE;
					end
					else begin
						state = b_state;
					end
				end
			PL_STT_DONE:
				begin
					state = PL_STT_IDLE;
				end
			default:
				begin
					state = PL_STT_IDLE;
				end
		endcase // b_state
	end

	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= PL_STT_IDLE;
		end
		else if(iRESET_SYNC)begin
			b_state <= PL_STT_IDLE;
		end
		else begin
			b_state <= state;
		end
	end

	reg b_finish;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_finish <= 1'h0;
		end
		else if(iRESET_SYNC)begin
			b_finish <= 1'h0;
		end
		else begin
			b_finish <= state == PL_STT_DONE;
		end
	end



	/*****************************************************
	Assign
	*****************************************************/
	//Out for 1-Latency
	assign oFINISH = b_finish;


endmodule // pipeline_control_irq_call

`default_nettype wire 

