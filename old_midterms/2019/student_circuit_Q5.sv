module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

	always @ *
		if (clear)
			cct_output  = 8'H0;
		else
			cct_output  = cct_input;

endmodule
