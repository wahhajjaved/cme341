module student_circuit_Q5 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);
reg [7:0] counter;

always @ (posedge clk)
	if (clear == 1'b1 || counter == 8'b1000_0010)
		counter = 8'h05;
	else if (counter == 8'b1010_0000)
		counter = 8'b0100_0001;
	else
		counter = {counter << 1};

// always @ (posedge clk)
// 	if (clear)
// 		counter = 8'h05;
// 	else
// 		case(counter)
// 		8'b0000_0101: counter = 8'b0000_0100
// 		endcase

always @ *
	cct_output = counter;

endmodule
