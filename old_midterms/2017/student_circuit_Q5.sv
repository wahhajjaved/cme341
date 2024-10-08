module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [15:0] product;
always @ *
	product = cct_input * cct_input;

always @ *
	cct_output = product[11:4];

endmodule
