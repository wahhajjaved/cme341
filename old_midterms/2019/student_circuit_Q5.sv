module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

wire and1_o;
wire and2_o;
wire and3_o;
wire and4_o;
wire or1_o;

and and1 (and1_o, 1'b0, cct_input[6]);
and and2 (and2_o, 1'b1, ~cct_input[6]);
or or1 (or1_o, and1_o, and2_o);
and and3 (and3_o, 1'b1, cct_input[7]);
and and4 (and4_o, ~cct_input[7], or1_o);
or or2 (cct_output[7], and3_o, and4_o);

always @ *
	cct_output[6:0] = cct_input[6:0];




endmodule
