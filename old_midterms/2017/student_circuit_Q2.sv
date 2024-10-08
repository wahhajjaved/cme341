// This file contains the initial version of the student circuit for
// the midterm exam preamble.  When working through the 'example exam question'
// section of the preamble, you are asked to change this module to implement
// a different circuit.

module student_circuit_Q2 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

  always @ *
	if (clear)
		cct_output = 8'b0;
	else if (cct_input[7:4] == 4'b11)
		cct_output = ~cct_input;
	else if (cct_input[7] == 1'b1)
		cct_output =   cct_input[0]  +
						cct_input[1] +
						cct_input[2] +
						cct_input[3] +
						cct_input[4] +
						cct_input[5] +
						cct_input[6] +
						cct_input[7];
	else
		cct_output = cct_input;


endmodule
