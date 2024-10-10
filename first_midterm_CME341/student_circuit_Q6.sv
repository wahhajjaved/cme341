module student_circuit_Q6 (
	input wire        clk,
	input wire        clear,
	input wire  [7:0] cct_input,
	output reg  [7:0] cct_output
);

reg [7:0] output1;
reg [7:0] output2;
reg [7:0] output3;
reg [7:0] output4;
reg [7:0] counter;

always @ (posedge clk)
	case(counter)
	8'd0: cct_output = output4;
	8'd1: cct_output = output3;
	8'd2: cct_output = output2;
	default: cct_output = output1;
	endcase

always @ (posedge clk)
	if (clear)
		begin
			output1 = 8'd0;
			output2 = 8'd0;
			output3 = 8'd0;
			output4 = 8'd0;
		end
	else
		begin
			case(counter)
			8'd0: output1 = ~cct_input;
			8'd1: output2 = ~cct_input;
			8'd2: output3 = ~cct_input;
			8'd3: output4 = ~cct_input;
			endcase
			if (counter == 8'd3)
				counter = 8'd0;
			else
				counter = counter + 8'd1;
		end

endmodule
