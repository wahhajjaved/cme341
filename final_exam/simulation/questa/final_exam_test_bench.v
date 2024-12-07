`timescale 1us/1ns
module final_exam_testbench ();
reg clk, reset;
reg [7:0] seed, exam_dependent_seed;
reg [7:0] stimulus;
reg counter_full_bar;
reg [15:0] accumulator_output;


reg [7:0] scrambled_output;
reg [7:0] adder_output;
reg [15:0] rotator_output;


wire [8:0] register_enables;
wire [7:0] pm_address, pm_data;
// wire [8:0]	register_enables;
wire [7:0] 	pc, ir;
wire [7:0] from_PS, from_ID, from_CU; // signals to convey changes
                              // that were made in the program
                             // sequencer, instruction decoder
                             // and the computational unit
wire [3:0] x0, x1, y0, y1, r, m, i, o_reg;
wire zero_flag;
wire NOPC8, NOPCF, NOPD8, NOPDF;

//my debug signals
wire[3:0] data_bus, source_select, alu_out;

// define the length of the simulation
initial #960 $stop;

//set the exam dependent seed

initial exam_dependent_seed = 8'HE1;

// set the seed

initial
      begin
           seed = 8'HAA;
           #640 seed = exam_dependent_seed;
      end

// Print three one-line messages to transcript window
initial
begin
#310 $display(,,); // make a blank line at time 310 us
$display("Accumulator output is %H for seed %H at time 310 us", accumulator_output, seed);
$display(,,); // make another blank line
#320 $display("Accumulator output is %H for seed %H at time 630 us", accumulator_output, seed);
$display(,,); // make a blank line at time 630 us
#320 if (seed == 8'HFF)
        $display("Warning:  exam dependent seed is 8'HFF, which is not normally used in an exam. ");
$display("Accumulator output = %H for exam dependent seed %H at time 950 us", accumulator_output, seed);
$display(,,); // make a blank line at time 960 us
$display(,,); // make another blank line at time 960 us
end

// generate the reset

initial
forever
  begin    reset = 1'b1; #5.2 reset = 1'b0;
            #3 reset = 1'b1; #1 reset = 1'b0;
            #8 reset = 1'b1; #0.1 reset = 1'b0;
            #(320-5.2-3-1-8-0.1) reset =1'b1;
  end


//initial begin reset = 1'b1; #5.2 reset = 1'b0;  #3 reset = 1'b1; #1 reset = 1'b0; #8 reset = 1'b1; #0.1 reset = 1'b0; end
//initial begin #320 reset = 1'b1; #5.2 reset = 1'b0; #3 reset = 1'b1; #1 reset = 1'b0; #8 reset = 1'b1; #0.1 reset = 1'b0; end

 // make the clock

 initial clk = 1'b0;
 always #0.5 clk = ~clk; // 1 MHz clock



always @ (posedge clk)  //design the accumulator
if (reset == 1'b1)
 accumulator_output <= 8'b0;
else if (counter_full_bar == 0)
  accumulator_output <= accumulator_output;
else
   accumulator_output <= rotator_output;


always @ (posedge clk)  //design the counter
if (reset == 1'b1)
 #0.05 stimulus <=  8'b0;
else if (counter_full_bar == 0)
  #0.05 stimulus <= stimulus;
else
  #0.05 stimulus <=
         stimulus + 8'b1;

always @ * //design the rotator
rotator_output = {accumulator_output[14:8],
          adder_output, accumulator_output[15]};

always @ * //design the adder
adder_output = accumulator_output[7:0]+scrambled_output;

always @ * // design the scrambler
scrambled_output =  seed ^{m,o_reg}^
                    {x1,x0}^{y1,y0}^{3'b0,zero_flag,r}^
                    ir^pc^pm_address^
                    from_PS^from_ID^from_CU;


always @ * // design the counter full dectector
if (& stimulus == 1'b1) // counter is full
		counter_full_bar = 1'b0;
else    counter_full_bar = 1'b1;

/* ***************************
 instantiate the .vo file
 that resulted from the student
 design
******************************/
microprocessor   micro_1 (
	.clk(clk),
	.reset(reset),
	.i_pins(stimulus[7:4]),
	.o_reg(o_reg),
	.x0(x0),
	.x1(x1),
	.y0(y0),
	.y1(y1),
	.r(r),
	.zero_flag(zero_flag),
	.m(m),
	.i(i),
	.pm_data(pm_data),
	.pm_address(pm_address),
	.pc(pc),
	.ir(ir),
	.reg_enables(register_enables),
	.from_PS(from_PS),
	.from_ID(from_ID),
	.from_CU(from_CU),
        .NOPC8(NOPC8),  .NOPCF(NOPCF),
        .NOPD8(NOPD8), .NOPDF(NOPDF),
        //my debug signals
        .data_bus(data_bus),
        .source_select(source_select),
        .alu_out(alu_out)
        );


endmodule
