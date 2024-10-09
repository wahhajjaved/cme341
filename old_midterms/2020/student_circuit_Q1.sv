module student_circuit_Q1 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

always @ *
	if (cct_input >= 8'd7 && cct_input <= 8'd11)
		cct_output = cct_input;
	else
		cct_output  = 8'H0;

endmodule
