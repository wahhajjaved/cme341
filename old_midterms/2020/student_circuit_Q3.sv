module student_circuit_Q3 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [1:0] pulse;
reg [7:0] output;

always @ (posedge clk)
	if (clear)
		begin
		pulse = 2'd0;
		output = 8'd0;
		end

	else
		pulse = pulse + 1;




endmodule
