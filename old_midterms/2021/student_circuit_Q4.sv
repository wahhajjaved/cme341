module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] delay;

always @ (posedge clk)
	if (clear)
		delay = 8'd0;
	else
		delay = cct_input;

always @ (negedge clk)
	if (clear)
		cct_output = 8'd0;
	else
		cct_output = ~(cct_input & delay);

endmodule
