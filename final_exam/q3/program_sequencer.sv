module program_sequencer (
	input wire clk,
	input wire sync_reset,
	input wire jmp,
	input wire jmp_nz,
	input wire [3:0] jmp_addr,
	input wire dont_jmp,

	output reg [7:0] pm_addr,
	output reg [7:0] pc,
	output reg [7:0] from_PS
);

//state 1 is waiting at jump_nz
reg state_1, state_1_d, entering_state_1, staying_in_state_1;
reg [7:0] timer;

always @ (negedge clk)
	if(sync_reset)
		timer <= 8'h00;
	else if (entering_state_1)
		if (jmp_addr == 4'h0)
		timer <= 8'h00;
		else
		timer <= {4'h0, jmp_addr - 4'h1};
	else if (timer == 8'h00)
		timer <= timer;
	else
		timer <= timer - 8'h01;


//state 1 flip flop
always @ (negedge clk)
	if (sync_reset)
		state_1 <= 1'b0;
	else
		state_1 <= state_1_d;

//logic for entering state 1
always @ *
	if (!state_1 && jmp_nz)
		entering_state_1 <= 1'b1;
	else
		entering_state_1 <= 1'b0;

//logic for staying in state 1
always @ *
	if (state_1 && timer != 8'h00)
		staying_in_state_1 <= 1'b1;
	else
		staying_in_state_1 <= 1'b0;

// d-input for state_1 flip/flop
always @ *
	if (entering_state_1) // enter state 1 on next posedge clk
		state_1_d <= 1'b1;
	else if (staying_in_state_1)
		state_1_d <= 1'b1;
	else // not in state 1 on next posedge clk
		state_1_d <= 1'b0;




always @ (posedge clk)
	if(sync_reset)
		pc = 8'h0;
	else if (entering_state_1 || state_1)
		pc = pc;
	else
		pc = pm_addr;


always @ (*)
	if(sync_reset)
		pm_addr = 8'h0;
	else if(jmp)
		pm_addr = {jmp_addr, 4'h0};
	else if (pc == 8'hff)
		pm_addr = 8'h0;
	else
		pm_addr = pc + 8'h1;

//exam code
always @(*)
	// from_PS = {timer[1:0], state_1, state_1_d, staying_in_state_1, entering_state_1, jmp_nz, dont_jmp};
	from_PS = 8'h00;

endmodule