module student_circuit_Q3 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

wire [7:0] wire1;

reg [7:0] reg1;
reg [7:0] reg2;

always @ *
	if (clear)
		wire1 = 8'b11;
	else
		wire1 = cct_input;

always @ (posedge  clk)
		reg1 = wire1;

always @ (posedge clk)
	if (clear)
		reg2 = 8'h55;
	else
		reg2 = reg1 ^ (wire1 + 8'h22);

always @ *
	cct_output  = reg1 ^ reg2;

endmodule
