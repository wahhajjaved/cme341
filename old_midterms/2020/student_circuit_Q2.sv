module student_circuit_Q2 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] counter;

always @ (posedge clk)
	if (clear)
		counter = 8'H0;
	else
		counter = counter + 8'd3;

always @ *
	cct_output = counter;

endmodule
