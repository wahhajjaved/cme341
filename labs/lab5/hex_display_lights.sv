module hex_display_lights(
	input [3:0] colour, //{green, amber, red, left}
	output [6:0] hex_segments
);

localparam 	OFF = 4'b0000,
			RED = 4'b0001,
			AMBER = 4'b0010,
			GREEN = 4'b0100,
			LEFT = 4'b1000;

always @ *
	//1 is off, 0 is on
	case(colour)
		OFF: hex_segments = 7'b1_111_111;
		RED: hex_segments = 7'b1_111_110;
		AMBER: hex_segments = 7'b0_111_111;
		GREEN: hex_segments = 7'b1_110_111;
		LEFT: hex_segments = 7'b1_110_001;
		default: hex_segments = 7'b0_000_000;
	endcase

endmodule