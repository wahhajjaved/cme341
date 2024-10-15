module counter(up_down, ena, clk, cnt, clk_out, seven_segments);
input up_down, ena, clk;
output clk_out;
output [3:0] cnt;
assign clk_out = clk;
reg [3:0] cnt;
output wire [6:0]seven_segments;

always @ (posedge clk)
	if (ena == 1'b0)
		cnt = cnt;
	else if (up_down == 1'b1)
		cnt = cnt + 4'd1;
	else
		cnt = cnt - 4'd1;

hex_display_driver hex_driver_1(
.hex_digit(cnt),
.hex_segments(seven_segments)
);

endmodule