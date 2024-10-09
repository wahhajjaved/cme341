module student_circuit_Q1 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

always @ *
	cct_output  = 8'H1;

endmodule
