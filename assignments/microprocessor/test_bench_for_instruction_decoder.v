/***********************************************

Instructions For Using This Testbench
1. Make a Modelsim Altera project called
test_bench_for_instruction_decoder and include this as
well as the .vo file for your instruction decoder.

2. At the bottom of this file there is an instantiation of
the instruction decoder. Change the connection list so that
the names for the ports in the instruction decoder are the
one you used.

3. Compile the project and load the simulation.

4. In the transcript window do the wave.do file.

5. Load the memory file ``memory_for_inst_decoder_test.hex''
as follows:
i) With the wave window active select view. Check to see
if the ``Memory List'' option is check marked. If it
is not, click on it to activate it.
ii) Select the "Memory List" tab ( in the same row as the
project tab). This will bring up a window that
shows all the memories in the test bench.
In this case there is only one memory.
iii) Double click on the memory in the Memory List window.
This will bring up a window showing the contents of
the memory. At this point it should be filled with
``don't cares'' i.e. x's.
iv) Select File -> import -> Memory Data to bring up
a window that allows you to select the file you
need to import.
v)  In the ``Import Memory'' window  check the approapriate
radio buttons and type in the file name to make:
Load Type = File Only
File Format = Verilog Hex
File name = memory_for_inst_decoder_test.hex

Then click O.K.
vi) Run the simulation (i.e. type the command run -all in
the transcript window.)

***********************************************************

DESCRIPTION OF THE TEST BENCH

This test bench will check the non-trivial outputs of the
instruction decoder.

The heart of the test bench is a ram, which is initialized
with a hex file and used as a ROM. The initialization hex
file was created by writing the outputs of a working instruction
decoder to the ram. The contents of the ram were then copied
to the initialization hex file "memory_for_inst_decoder_test.hex"

After the initialization hex file was created, the test bench
was modified so that the ram is no longer written
(i.e. the write enable was connected to 1'b0).


The test bench produces an output vector called
output_vector_comparison.  This vector is the
xnor of  the output of the ram with outputs
from the instruction decoder under test and then
ored with a mask that masks all the ``don't cares''
occurences for the signals.

To make things work  a two-register `pipe-line' is
needed. (If you count the register in the instruction
decoder it would be called a three register pipeline.)
This means the first valid output is after the
third rising edge of the clock.

To show the value of ir that caused a particular
``output_vector_comparison'', the input pm_data has been delayed
3 clk cycles to produce  ``instr_reg'', which is ir delayed
to correspond to ``output_vector_comparison''.

NOTE: The select line that controls the 2-1 mux at the input
to the i register can be either a 1'b0 or 1'b1
(i.e. is a don't care) when the clock enable for the
i register is inactive (i.e. low). To make the
``output_vector_comparison[15]'' reflect this fact,
it is forced high when the clock enable for i
register is low.



NOTE: The ``source_register_select'' can be any value during
an ALU, jump or conditional jump instruction as the the
source bus multiplexer is not used for these instuctions.
This test bench forces ``output_vector_comparison[5:2]'',
which are the bits that verify ``source_register_select'',
high for these instructions.

NOTE: The x and y register select lines that control the muxes
on the input of the ALU and are not verified in this test bench.
*/


`timescale 1 us / 1 ns
module test_bench_for_instruction_decoder ();

	reg         clk                            ;
	reg  [ 7:0] pm_data                        ;
	reg  [ 7:0] pm_data_delayed_1;
	reg  [ 7:0] pm_data_delayed_2       ;
	reg  [ 7:0] instr_reg               ;
	reg  [15:0] test_inst_decoder_ram   [0:255];
	reg  [15:0] output_vector_comparison;
	reg  [15:0] output_vector_delayed   ;
	reg         we                             ;
	reg         load_or_mov_instrucion         ;
	reg         sync_reset                     ;
	wire [15:0] output_vector;
	wire [15:0] correct_output_vector   ;

	wire unconditional_jump;
	wire conditional_jump  ;
	wire i_mux_select      ;
	wire[3:0] source_register_select;
	wire[8:0] register_enables;
	wire [3:0] LS_nibble_of_ir; // output of instruction decoder but
	// not used in this test bench
	wire y_mux_select;
	wire x_mux_select; // output of instruction decoder but
	// not used in this test bench

	initial #260 $stop;

// modified by NTN on Nov.1
	initial
		begin
			sync_reset = 1'b1;

			#0.080 sync_reset = 1'b0;// at 80ns turn to zero
		end

	initial
		we = 1'b0; // this must be 1'b0 when in test mode
	// and 1'b1 when the gold standard is used
	// to generate the memory

	initial clk = 1'b0;
	always #0.5 clk =~clk;

	initial pm_data = 8'H0; //  input to the instruction decoder
	always @ (posedge clk)
		#0.010 pm_data <= pm_data+8'b1; // test sequence is a counter

	always @ (posedge clk)
		begin
			pm_data_delayed_1 <= pm_data;
			pm_data_delayed_2 <= pm_data_delayed_1;
			instr_reg         <= pm_data_delayed_2; //a delay of 3 clock periods
			// is necessary to make the contents of ``instr_reg''
			// line up with output_vector_comparison
		end

	always @ *
		load_or_mov_instrucion <= ~pm_data_delayed_2[7] | (pm_data_delayed_2[7] &
			~pm_data_delayed_2[6]);


	always @ (posedge clk)
		output_vector_delayed <= output_vector;

/*  **************************************************
	**************************************************

	Test result are in the vector ``output_vector_comparison''.
	``output_vector_comparison'' should be FFFF from the instant
	instr_reg == 8'H00 to the end. Any bits in ``output_vector_comparison''
	that are not 1 indicate the instruction in instr_reg is not executed properly.

	The 16 bits in ``output_vector_comparison'' indicate whether or not there is an
    error in the corresponding bit position of the concatenation of signals
	{i_mux_select,register_enables[8:0], source_register_select[3:0],
    conditional_jump, unconditional_jump}.
	A 0 or x in ``output_vector_comparison'' indicates an error.

	************************************************** */
	always @ (posedge clk)
		if (load_or_mov_instrucion == 1'b1) // source bus is used
			output_vector_comparison <= (output_vector_delayed ~^
				correct_output_vector) |
			{correct_output_vector[12],15'h0};
		//correct_output_vector[12] corresponds to
		// reg_enables[6]
		else // source bus is not used so mask bits corresonding to source_bus_select
			output_vector_comparison <= (output_vector_delayed ~^
				correct_output_vector) | 16'b0000_0000_0011_1100
			| {correct_output_vector[12],15'h0};


	/* *************************************
	MEMORY SECTION
	************************************* */
	always @ (posedge clk)
		if (we)
			// test_inst_decoder_ram[pm_data] = output_vector;
			test_inst_decoder_ram[pm_data_delayed_1] = output_vector;
		else
			test_inst_decoder_ram[pm_data_delayed_1] = test_inst_decoder_ram[pm_data_delayed_1];

	assign correct_output_vector = test_inst_decoder_ram[pm_data_delayed_2];

	/* *************************************
	INSTANTIATION SECTION
	************************************* */
    ////// THIS TO BE ASSUMED THAT i_sel will be 1'b1 ON IDLE

	assign output_vector = {i_mux_select,register_enables, source_register_select,
		conditional_jump, unconditional_jump};
	instruction_decoder inst_decoder_1 (
		.clk       (clk                   ),
		.sync_reset(sync_reset            ), // added in Nov.1
		.next_instr(pm_data               ),
		.jmp       (unconditional_jump    ),
		.jmp_nz    (conditional_jump      ),
		.ir_nibble (LS_nibble_of_ir       ),
		.i_sel     (i_mux_select          ),
		.y_sel     (y_mux_select          ),
		.x_sel     (x_mux_select          ),
		.source_sel(source_register_select),
		.reg_en    (register_enables      )
	);

    /*
    output_vector_comparison
    15  i_sel
    14  o_reg
    13  dm
    12  i
    11  m
    10  r
    9   y1
    8   y0
    7   x1
    6   x0
    5   source_sel[3]
    4   source_sel[2]
    3   source_sel[1]
    2   source_sel[0]
    1   jmp_nz
    0   jmp
    */
endmodule