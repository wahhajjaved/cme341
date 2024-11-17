`timescale 1us/1ns
module program_sequencer_test ();

reg clk;
reg sync_reset;
reg [7:0] pm_address;
reg jump;
reg conditional_jump;
reg [3:0] LS_nibble_ir;
reg zero_flag;

reg correct;
reg [3:0] count;



initial #5 $stop;
initial count = 4'd0;
initial clk = 1'b0;

always #0.5 clk = ~clk;


always @(posedge clk )
	#0.005 count = count + 4'd1;


always @ *
	case (count)
		4'd0: begin
			sync_reset = 1'b1;
			correct = pm_address == 8'd0 ? 1'b1 : 1'b0;
		end
		4'd1: begin
			sync_reset = 1'b0;
			jump = 1'b1;
			LS_nibble_ir = 4'ha;
			correct = pm_address == 8'ha0 ? 1'b1 : 1'b0;

		end
	endcase

program_sequencer prog_sequencer (
	.clk(clk),
	.sync_reset(sync_reset),
	.jmp_addr(LS_nibble_ir),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.dont_jmp(zero_flag),
	.pm_addr(pm_address)
);
endmodule