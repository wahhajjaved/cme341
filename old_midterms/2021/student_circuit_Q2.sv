module student_circuit_Q2 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


always @ (posedge clk)
	cct_output  = 8'H2;


endmodule
