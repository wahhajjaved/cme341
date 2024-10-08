module student_circuit_Q3 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);
	integer i;
	always @ *
		for (i = 0; i < 8; i++)
			cct_output[i]  = cct_input[7-i];

endmodule
