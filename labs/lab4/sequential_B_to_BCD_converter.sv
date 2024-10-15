module sequential_B_to_BCD_converter(
	input clk,
	input [7:0] binary_input,
	input [6:0] hex0,
	input [6:0] hex1,
	input [6:0] hex2
);

reg [3:0] digit_001;
reg [3:0] digit_010;
reg [3:0] digit_100;

BCD_counter counter(
	.clk(clk),
	.sync_clr(sync_clr),
	.count_enable(count_enable),
	.digit_001(digit_001),
	.digit_010(digit_010),
	.digit_100(digit_100)
);

hex_display_driver hex001(
	.hex_digit(digit_001),
	.hex_segments(hex0)
);
hex_display_driver hex010(
	.hex_digit(digit_010),
	.hex_segments(hex1)
);
hex_display_driver hex100(
	.hex_digit(digit_100),
	.hex_segments(hex2)
);


endmodule