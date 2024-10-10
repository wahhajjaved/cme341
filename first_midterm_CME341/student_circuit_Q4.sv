module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


always @ *
	case({cct_input[0], cct_input[1]})
		2'b00: cct_output = {1'b0, cct_input[2], 6'b0};
		2'b10: cct_output = {1'b0, cct_input[4] ^ cct_input[5], 6'b0};
		2'b01: cct_output = {1'b0, ~((cct_input[4] ^ cct_input[5]) | cct_input[3]), 6'b0};
		2'b11: cct_output = {1'b0, cct_input[6] ~^ cct_input[7], 6'b0};
	endcase


endmodule
