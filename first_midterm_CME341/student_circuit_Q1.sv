module student_circuit_Q1 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


always @ *
	if (clear)
		cct_output  = cct_input - 8'd10;
	else
		cct_output  = 8'ha5;

endmodule
