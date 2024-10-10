module student_circuit_Q3 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] counter;

always @ (posedge clk)
	if (clear)
		counter = 8'h0a;
	else if (counter != 8'hf0)
		counter = counter + 8'd2;
	else
		counter = counter;

always @ *
	cct_output = counter;

endmodule
