`timescale 1ms/1us

module B_to_BCD_converter_with_hex_driver_test();

reg [7:0] binary_input;
wire[7:0] leds;
wire [6:0]seven_segments_100, seven_segments_10, seven_segments_1;
reg [3:0]d_100, d_10, d_1;

B_to_BCD_converter_with_hex_driver dut(
	.binary_input(binary_input),
	.leds(leds),
	.seven_segments_100(seven_segments_100),
	.seven_segments_10(seven_segments_10),
	.seven_segments_1(seven_segments_1),
	.d_100(d_100), .d_10(d_10), .d_1(d_1)
);

initial begin
	binary_input = 8'b0;
	#1000;
	for (integer i = 0; i < 256; i++) begin
		binary_input = binary_input + 8'b1;
		#1000;
	end
	$stop;
end



endmodule