module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] goofy_counter;

always @ (posedge clk)
	if (clear == 1'b1 || goofy_counter == 8'b0001_1000)
		goofy_counter = 8'b1000_0001;
	else
		goofy_counter = {goofy_counter[7:4] >> 1, goofy_counter[3:0] << 1 };

always @ *
	cct_output = goofy_counter;

endmodule
