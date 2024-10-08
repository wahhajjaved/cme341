module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);


always @ *
	cct_output  = {cct_input[7], cct_input[7], cct_input[7:2]};
	// cct_output  = {
	// 	cct_input[7],
	// 	cct_input[7],
	// 	cct_input[7],
	// 	cct_input[6],
	// 	cct_input[5],
	// 	cct_input[4],
	// 	cct_input[3],
	// 	cct_input[2]

	// 	};

endmodule
