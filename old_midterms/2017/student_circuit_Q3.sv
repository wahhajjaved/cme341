// This file contains the initial version of the student circuit for
// the midterm exam preamble.  When working through the 'example exam question'
// section of the preamble, you are asked to change this module to implement
// a different circuit.

module student_circuit_Q3 (
    input wire        clk,
    input wire        clear,
    input wire  [7:0] cct_input,
    output reg  [7:0] cct_output
);

reg [7:0] reg1;
reg [7:0] reg2;
reg [7:0] reg3;

always @ (posedge clk)
    if (clear)
        reg1 = 8'b11;
    else
        reg1 = cct_input;

always @ (posedge clk)
    if (clear)
        reg2 = 8'b11;
    else
        reg2 = cct_input;

always @ (posedge clk)
    if (clear)
        reg3 = 8'b0;
    else
        reg3 = reg2;

always @ *
    cct_output = reg3 ^ (reg1 ^ (cct_input + 8'd17));



endmodule
