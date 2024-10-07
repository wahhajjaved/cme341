module student_circuit_Q3b (
  input wire        clk,
  input wire        clear,
  input wire  [7:0] cct_input,
  output reg  [7:0] cct_output
);

  reg [7:0] count_down;

  always @ (posedge clk)
    if (clear == 1'b1)
		  count_down  = 8'd0;
    else if (cct_input[7] == 1'b1)
		  count_down  = count_down + 1'd1;
    else
		  count_down  = count_down - 1'd1;

  always @ (*)
    cct_output = cct_input ^ count_down;


endmodule