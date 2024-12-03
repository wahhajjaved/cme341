module hex_display_lights(
	input [2:0] colour, //{green, amber, red}
	output [6:0] hex_segments
);

localparam 	OFF = 3'b000,
			RED = 3'b001,
			AMBER = 3'b010,
			GREEN = 3'b100;

always @ *
	//1 is off, 0 is on
	case(colour)
		OFF: hex_segments = 7'b1_111_111;
		RED: hex_segments = 7'b1_111_110;
		AMBER: hex_segments = 7'b0_111_111;
		GREEN: hex_segments = 7'b1_110_111;
		default: hex_segments = 7'b0_000_000;
	endcase

endmodule