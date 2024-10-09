module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

always @ *
	if (cct_input[4] && cct_input[0])
		cct_output  = 8'hff;
	else if (cct_input[4] == 0 && cct_input[0] == 0)
		cct_output  = 8'h0;
	else
		cct_output  = 8'b01110000;

endmodule
