`timescale 1us/1ns

module clock_test();
reg clk;
initial #50 $stop;
initial clk = 1'b1;
always #0.5 clk = ~clk; // 1 MHz clock

reg new_clock;
reg ready;
always @ (posedge clk)
	if (ready)
		begin
		new_clock = clk;
		ready = 1'b0;
		end
	else
		ready = 1'b1;


endmodule