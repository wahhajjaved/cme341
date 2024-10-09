module student_circuit (
  input wire        clk,
  input wire        clear,
  input wire  [7:0] cct_input,
  output wire [7:0] cct_output
);

/*  NB: It is strongly suggested that this module be organized so that all questions can be answered using a single quartus project.
This can be done by answering the questions in separate modules, perhaps named student_circuit_Q1, student_circuit_Q2, student_circuit_Q3 and student_circuit_Q4, as shown below.
Then one of these modules is instantiated within this module.  For example the answer to question 1, 2, 3, or 4 is answered by uncommenting the instantiation of interest and commenting all others.
 */

// student_circuit_preamble the_cct (
// student_circuit_Q1 the_cct(
// student_circuit_Q2 the_cct(
// student_circuit_Q3 the_cct(
student_circuit_Q4 the_cct(
// student_circuit_Q5 the_cct(
  .clk(clk),
  .clear(clear),
  .cct_input(cct_input),
  .cct_output(cct_output)
);

endmodule
