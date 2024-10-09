module student_circuit_Q4 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

// wire or1_o;
// wire and1_o;

// or or1(or1_o, cct_input[4], cct_input[5], cct_input[6], cct_input[7]);
// and and1(and1_o, cct_input[4], cct_input[5], cct_input[6], cct_input[7]);

// reg [7:0] mux1;

// always @ *
// 	if (or1_o)
// 		mux1 = {7'b0, cct_input[2]};
// 	else
// 		mux1 = {6'b0, cct_input[1:0]};

// always @ *
// 	if (and1_o)
// 		cct_output = {7'b0, cct_input[3]};
// 	else
// 		cct_output = mux1;

reg [7:0] mux1;

always @ *
	if (|cct_input[7:4])
		mux1 = {7'b0, cct_input[2]};
	else
		mux1 = {6'b0, cct_input[1:0]};

always @ *
	if (&cct_input[7:4])
		cct_output = {7'b0, cct_input[3]};
	else
		cct_output = mux1;


endmodule
