module student_circuit_Q2 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


always @ *
	if (clear)
		cct_output  = 8'H0;
	else if (cct_input == 8'b10)
		cct_output = ~cct_input;
	else if (cct_input > 8'd35)
		cct_output = cct_input[0] +
					cct_input[1] +
					cct_input[2] +
					cct_input[3];
	else
		cct_output  = cct_input;

endmodule
