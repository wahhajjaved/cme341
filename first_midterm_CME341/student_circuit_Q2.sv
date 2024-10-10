module student_circuit_Q2 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

always @ *
	if (cct_input[0] == 0 && cct_input < 8'ha5)
		cct_output = ~cct_input;
	else if (cct_input[0] == 0 && cct_input > 8'ha5)
		cct_output = 8'd255 - cct_input;
	else
		cct_output = cct_input;




endmodule
