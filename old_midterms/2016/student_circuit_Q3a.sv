module student_circuit_Q3a (
  input wire        clk,
  input wire        clear,
  input wire  [7:0] cct_input,
  output reg  [7:0] cct_output
);

// initial circuit - should give 16'H622D in testbench for seed 8'HAA
// (replace with a different circuit as directed in the preamble)
  reg [7:0] count_down;

  always @ (posedge clk)
    if (clear == 1'b1)
		  count_down  = 8'd0;
    else
		  count_down  = count_down - 1'd1;

  always @ (*)
    cct_output = cct_input ^ count_down;


endmodule