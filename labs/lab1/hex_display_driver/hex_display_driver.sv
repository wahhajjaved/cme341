module hex_display_driver(
	input [3:0] hex_digit,
	output [6:0] hex_segments
);

always @ *
	case(hex_digit)

		4'h0: hex_segments = 7'b1_000_000;
		4'h1: hex_segments = 7'b1_111_001;
		4'h2: hex_segments = 7'b0_100_100;
		4'h3: hex_segments = 7'b0_110_000;
		4'h4: hex_segments = 7'b0_011_001;
		4'h5: hex_segments = 7'b0_010_010;
		4'h6: hex_segments = 7'b0_000_010;
		4'h7: hex_segments = 7'b1_111_000;
		4'h8: hex_segments = 7'b0_000_000;
		4'h9: hex_segments = 7'b0_010_000;
		4'ha: hex_segments = 7'b0_001_000;
		4'hb: hex_segments = 7'b0_000_011;
		4'hc: hex_segments = 7'b1_000_110;
		4'hd: hex_segments = 7'b0_100_001;
		4'he: hex_segments = 7'b0_000_110;
		4'hf: hex_segments = 7'b0_001_110;
		default: hex_segments = 7'b1_111_111;

	endcase

endmodule