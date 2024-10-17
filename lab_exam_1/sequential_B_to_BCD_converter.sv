module sequential_B_to_BCD_converter(
	input [9:0] sw,
	input clk,
	output [6:0] hex0,
	output [6:0] hex1,
	output [6:0] hex2,
	output [6:0] hex3
);

(* keep *) reg sync_clr;
(* keep *) reg [3:0] digit_001;
(* keep *) reg [3:0] digit_010;
(* keep *) reg [3:0] digit_100;
(* keep *) reg [3:0] digit_1000;
(* keep *) reg [3:0] digit_001_o;
(* keep *) reg [3:0] digit_010_o;
(* keep *) reg [3:0] digit_100_o;
(* keep *) reg [3:0] digit_1000_o;
reg [9:0] binary_counter;
reg [9:0] bin_num;

always @ (posedge clk)
	if (sync_clr)
		bin_num = sw;
	else
		bin_num = bin_num;

always @ (posedge clk)
	if (sync_clr)
		binary_counter = 8'b0;
	else
		binary_counter = binary_counter + 8'd1;

always @ *
	if (binary_counter == bin_num)
		sync_clr = 1'b1;
	else
		sync_clr = 1'b0;

always @ (posedge clk)
	if (sync_clr) begin
		digit_001_o = digit_001;
		digit_010_o = digit_010;
		digit_100_o = digit_100;
		digit_1000_o = digit_1000;
	end
	else begin
		digit_001_o = digit_001_o;
		digit_010_o = digit_010_o;
		digit_100_o = digit_100_o;
		digit_1000_o = digit_1000_o;
	end



BCD_counter counter(
	.clk(clk),
	.sync_clr(sync_clr),
	.count_enable(1'b1),
	.digit_001(digit_001),
	.digit_010(digit_010),
	.digit_100(digit_100),
	.digit_1000(digit_1000)
);

hex_display_driver hex001(
	.hex_digit(digit_001_o),
	.hex_segments(hex0)
);
hex_display_driver hex010(
	.hex_digit(digit_010_o),
	.hex_segments(hex1)
);
hex_display_driver hex100(
	.hex_digit(digit_100_o),
	.hex_segments(hex2)
);
hex_display_driver hex1000(
	.hex_digit(digit_1000_o),
	.hex_segments(hex3)
);


endmodule