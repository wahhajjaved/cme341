module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

wire xor1_o;
wire or1_o, or2_o;
wire and1_o, and2_o, and3_o, and4_o;
xor xor1(xor1_o, cct_input[0], cct_input[1]);
or or1(or1_o, cct_input[2], cct_input[3]);

and and1(and1_o, cct_input[4], xor1_o, or1_o);
and and2(and2_o, cct_input[5], xor1_o, ~or1_o);
and and3(and3_o, cct_input[6], ~xor1_o, or1_o);
and and4(and4_o, cct_input[7], ~xor1_o, ~or1_o);

or or2(cct_output[4], and1_o, and2_o, and3_o, and4_o);

// cct_output = {0, 0, 0, 0, or2_o, 0, 0, 0};

endmodule