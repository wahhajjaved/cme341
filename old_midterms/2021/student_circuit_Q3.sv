module student_circuit_Q3 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

always @ *
	if (clear)
		cct_output = 0;
	else if (cct_input[7])
		cct_output  = {4{cct_input[1:0]}};
	else
		cct_output = ~cct_input;

endmodule
