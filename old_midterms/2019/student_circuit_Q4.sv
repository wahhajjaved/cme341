module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


reg new_clock;
reg [7:0] counter;

always @ (posedge clk)
	new_clock = ~new_clock;

always @ (posedge new_clock)
	if (clear)
		counter = 8'd0;
	else
		counter = counter + 1'd1;

always @ *
	cct_output = counter;

endmodule
