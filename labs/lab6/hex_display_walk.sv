module hex_display_walk(
	input clk,
	input [2:0] state, //{walk, flashing_dont_walk, dont_walk}
	output reg [6:0] hex_segments
);

localparam 	OFF = 3'b000,
			DONTWALK = 3'b001,
			FLASHINGDONTWALK = 3'b010,
			WALK = 3'b100;

reg flash;

always @(posedge clk)
	flash <= ~flash;

always @ *
	case(state)
		OFF: hex_segments = 7'b1_111_111;
		DONTWALK: hex_segments = 7'b0_100_001;
		FLASHINGDONTWALK: hex_segments = flash ? 7'b0_100_001 : 7'b1_111_111;
		WALK: hex_segments = 7'b1_011_111;
		default: hex_segments = 7'b0_000_000;
	endcase
endmodule
