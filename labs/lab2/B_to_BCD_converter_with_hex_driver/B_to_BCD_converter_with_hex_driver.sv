module B_to_BCD_converter_with_hex_driver(
input [7:0] binary_input,
output reg[7:0] remainder_under_100,
output wire [6:0]seven_segments_100
);

reg[3:0] digit_100;

always @ *
	if (binary_input >= 8'd200) begin // note: since binary_input is 8 bits,
	// its maximum value is 255
		digit_100 = 4'd2;
		remainder_under_100 = binary_input - 8'd200; // max value is 55
	end
	else if (binary_input >= 8'd100) begin
		digit_100 = 4'd1;
		remainder_under_100 = binary_input - 8'd100; // max value is 99
	end
	else begin
		digit_100 = 4'd0;
		remainder_under_100 = binary_input -8'd000 ; // max value is 99
	end

hex_display_driver hex_driver_100(
.hex_digit(digit_100),
.hex_segments(seven_segments_100)
);

endmodule