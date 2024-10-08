module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] ring_counter;
always @ (posedge clk)
	if (clear == 1'b1)
		ring_counter = 8'b1;
	else if (ring_counter == 8'b1000_0000)
		ring_counter = 8'b1;
	else
		ring_counter = ring_counter << 1;

always @ *
	cct_output = ring_counter;
endmodule
