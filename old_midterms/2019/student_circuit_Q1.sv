module student_circuit_Q1 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] ring_counter;

always @ (posedge clk)
	if (clear || ring_counter == 8'b0000_0001 )
		ring_counter  = 8'b1000_0000;
	else
		ring_counter  = ring_counter >> 1;

always @ *
	cct_output = ring_counter;

endmodule
