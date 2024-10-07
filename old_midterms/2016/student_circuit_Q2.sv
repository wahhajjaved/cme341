module student_circuit_Q2 (
  input wire        clk,
  input wire        clear,
  input wire  [7:0] cct_input,
  output reg  [7:0] cct_output
);

// initial circuit - should give 16'H622D in testbench for seed 8'HAA
// (replace with a different circuit as directed in the preamble)

  always @ *
    if (clear)
		  cct_output  = 8'H0;
    else
      if (cct_input[7:5] == 3'b111 || cct_input[7:5] == 3'b000)
        cct_output  = cct_input;
      else if (cct_input[7:5] >= 3'd3 && cct_input[7:5] <= 3'd5)
        cct_output  = 8'd255 - cct_input;
      else
        cct_output  = {cct_input[0], cct_input[6:1], cct_input[7]};

endmodule