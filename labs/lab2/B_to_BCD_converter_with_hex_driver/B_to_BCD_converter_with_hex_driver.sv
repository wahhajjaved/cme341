module B_to_BCD_converter_with_hex_driver(
input [7:0] binary_input,
output reg[7:0] leds,
output wire [6:0]seven_segments_100, seven_segments_10, seven_segments_1
);

always @ *
	leds = binary_input;


reg[7:0] remainder_under_100, remainder_under_10;
reg[3:0] digit_100, digit_010;

always @ *
	if (binary_input >= 8'd200) begin
		digit_100 = 4'd2;
		remainder_under_100 = binary_input - 8'd200;
	end
	else if (binary_input >= 8'd100) begin
		digit_100 = 4'd1;
		remainder_under_100 = binary_input - 8'd100;
	end
	else begin
		digit_100 = 4'd0;
		remainder_under_100 = binary_input - 8'd000 ;
	end

always @ *
	if (remainder_under_100 >= 8'd90) begin
		digit_010 = 4'd9;
		remainder_under_10 = remainder_under_100 - 8'd90;
	end
	else if (remainder_under_100 >= 8'd80) begin
		digit_010 = 4'd8;
		remainder_under_10 = remainder_under_100 - 8'd80;
	end
	else if (remainder_under_100 >= 8'd70) begin
		digit_010 = 4'd7;
		remainder_under_10 = remainder_under_100 - 8'd70;
	end
	else if (remainder_under_100 >= 8'd60) begin
		digit_010 = 4'd6;
		remainder_under_10 = remainder_under_100 - 8'd60;
	end
	else if (remainder_under_100 >= 8'd50) begin
		digit_010 = 4'd5;
		remainder_under_10 = remainder_under_100 - 8'd50;
	end
	else if (remainder_under_100 >= 8'd40) begin
		digit_010 = 4'd4;
		remainder_under_10 = remainder_under_100 - 8'd40;
	end
	else if (remainder_under_100 >= 8'd30) begin
		digit_010 = 4'd3;
		remainder_under_10 = remainder_under_100 - 8'd30;
	end
	else if (remainder_under_100 >= 8'd20) begin
		digit_010 = 4'd2;
		remainder_under_10 = remainder_under_100 - 8'd20;
	end
	else if (remainder_under_100 >= 8'd10) begin
		digit_010 = 4'd1;
		remainder_under_10 = remainder_under_100 - 8'd10;
	end
	else begin
		digit_010 = 4'd0;
		remainder_under_10 = remainder_under_100 - 8'd00;
	end


hex_display_driver hex_driver_100(
.hex_digit(digit_100),
.hex_segments(seven_segments_100)
);

hex_display_driver hex_driver_10(
.hex_digit(digit_010),
.hex_segments(seven_segments_10)
);

hex_display_driver hex_driver_1(
.hex_digit(remainder_under_10[3:0]),
.hex_segments(seven_segments_1)
);


endmodule