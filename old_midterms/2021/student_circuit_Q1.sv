module student_circuit_Q1 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] counter;

always @ (posedge clk)
	if (clear)
		counter = 8'd0;
	else if (cct_input == 8'd31)
		counter = 8'd100;
	else
		counter = counter + 8'd1;

always @ *
	cct_output = counter;

endmodule
