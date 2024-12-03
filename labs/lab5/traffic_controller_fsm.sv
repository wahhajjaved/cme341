module traffic_controller_fsm (
	input clk,
	input reset,
	input southbound_left_request,
	output northbound_green, northbound_amber, northbound_red,
	output southbound_green, southbound_amber, southbound_red, southbound_left,
	output eastbound_green, eastbound_amber, eastbound_red,
	output westbound_green, westbound_amber, westbound_red,
	output [3:0] t
);

reg [5:0] timer;
reg southbound_left_request_waiting;

reg entering_state_1;
reg entering_state_2;
reg entering_state_3;
reg entering_state_4a;
reg entering_state_4;
reg entering_state_5;
reg entering_state_6;

reg staying_in_state_1;
reg staying_in_state_2;
reg staying_in_state_3;
reg staying_in_state_4a;
reg staying_in_state_4;
reg staying_in_state_5;
reg staying_in_state_6;

reg state_1_d;
reg state_2_d;
reg state_3_d;
reg state_4a_d;
reg state_4_d;
reg state_5_d;
reg state_6_d;

reg state_1;
reg state_2;
reg state_3;
reg state_4a;
reg state_4;
reg state_5;
reg state_6;

// timer
always @ (posedge clk or posedge reset)
	if (reset)
		timer <= 6'd60;
	else if (entering_state_1)
		timer <= 6'd60;
	else if (entering_state_2)
		timer <= 6'd6;
	else if (entering_state_3)
		timer <= 6'd2;
	else if (entering_state_4a)
		timer <= 6'd20;
	else if (entering_state_4)
		timer <= 6'd60;
	else if (entering_state_5)
		timer <= 6'd6;
	else if (entering_state_6)
		timer <= 6'd2;
	else if (timer == 6'd1)
		timer <= timer;
	else
		timer <= timer - 6'd1;



always @ *
	t = {3'b0, southbound_left_request_waiting};
	// t = {3'b0, reset};
	// t = timer[3:0];

/*************** State 1 ***************/

//state 1 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_1 <= 1'b1;
	else
		state_1 <= state_1_d;


//logic for entering state 1
always @ *
	if (state_6 && timer == 6'd1 )
		entering_state_1 <= 1'b1;
	else
		entering_state_1 <= 1'b0;


//logic for staying in state 1
always @ *
	if( (state_1 == 1'b1) && (timer != 6'd1) )
		staying_in_state_1 <= 1'b1;
	else
		staying_in_state_1 <= 1'b0;


// d-input for state_1 flip/flop
always @ *
	if (entering_state_1) // enter state 1 on next posedge clk
		state_1_d <= 1'b1;
	else if (staying_in_state_1)
		state_1_d <= 1'b1;
	else // not in state 2 on next posedge clk
		state_1_d <= 1'b0;



/*************** State 2 ***************/

//state 2 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_2 <= 1'b0;
	else
		state_2 <= state_2_d;

//logic for entering state 2
always @ *
	if (state_1 && timer == 6'd1 )
		entering_state_2 <= 1'b1;
	else
		entering_state_2 <= 1'b0;


//logic for staying in state 2
always @ *
	if( (state_2 == 1'b1) && (timer != 6'd1) )
		staying_in_state_2 <= 1'b1;
	else
		staying_in_state_2 <= 1'b0;


// d-input for state_2 flip/flop
always @ *
	if (entering_state_2) // enter state 2 on next posedge clk
		state_2_d <= 1'b1;
	else if (staying_in_state_2)
		state_2_d <= 1'b1;
	else // not in state 2 on next posedge clk
		state_2_d <= 1'b0;




/*************** State 3 ***************/

//state 3 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_3 <= 1'b0;
	else
		state_3 <= state_3_d;


//logic for entering state 3
always @ *
	if (state_2 && timer == 6'd1)
		entering_state_3 <= 1'b1;
	else
		entering_state_3 <= 1'b0;


//logic for staying in state 3
always @ *
	if( (state_3 == 1'b1) && (timer != 6'd1) )
		staying_in_state_3 <= 1'b1;
	else
		staying_in_state_3 <= 1'b0;


// d-input for state_3 flip/flop
always @ *
	if (entering_state_3) // enter state 3 on next posedge clk
		state_3_d <= 1'b1;
	else if (staying_in_state_3)
		state_3_d <= 1'b1;
	else // not in state 2 on next posedge clk
		state_3_d <= 1'b0;


/*************** State 4a ***************/

always @ *
	southbound_left_request_waiting <= southbound_left_request;


//state 4a flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4a <= 1'b0;
	else
		state_4a <= state_4a_d;


//logic for entering state 4a
always @ *
	if (state_3 && southbound_left_request_waiting && timer == 6'd1 )
		entering_state_4a <= 1'b1;
	else
		entering_state_4a <= 1'b0;


//logic for staying in state 4a
always @ *
	if( (state_4a == 1'b1) && (timer != 6'd1) )
		staying_in_state_4a <= 1'b1;
	else
		staying_in_state_4a <= 1'b0;


// d-input for state_4a flip/flop
always @ *
	if (entering_state_4a) // enter state 4a on next posedge clk
		state_4a_d <= 1'b1;
	else if (staying_in_state_4a)
		state_4a_d <= 1'b1;
	else // not in state 4a on next posedge clk
		state_4a_d <= 1'b0;




/*************** State 4 ***************/

//state 4 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4 <= 1'b0;
	else
		state_4 <= state_4_d;


//logic for entering state 4
always @ *
	if (state_3 && !southbound_left_request_waiting && timer == 6'd1 )
		entering_state_4 <= 1'b1;
	else if (state_4a && timer == 6'd1)
		entering_state_4 <= 1'b1;
	else
		entering_state_4 <= 1'b0;


//logic for staying in state 4
always @ *
	if( (state_4 == 1'b1) && (timer != 6'd1) )
		staying_in_state_4 <= 1'b1;
	else
		staying_in_state_4 <= 1'b0;


// d-input for state_4 flip/flop
always @ *
	if (entering_state_4) // enter state 4 on next posedge clk
		state_4_d <= 1'b1;
	else if (staying_in_state_4)
		state_4_d <= 1'b1;
	else // not in state 4 on next posedge clk
		state_4_d <= 1'b0;




/*************** State 5 ***************/
//state 5 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_5 <= 1'b0;
	else
		state_5 <= state_5_d;


//logic for entering state 5
always @ *
	if (state_4 && timer == 6'd1 )
		entering_state_5 <= 1'b1;
	else
		entering_state_5 <= 1'b0;


//logic for staying in state 5
always @ *
	if( (state_5 == 1'b1) && (timer != 6'd1) )
		staying_in_state_5 <= 1'b1;
	else
		staying_in_state_5 <= 1'b0;


// d-input for state_5 flip/flop
always @ *
	if (entering_state_5) // enter state 5 on next posedge clk
		state_5_d <= 1'b1;
	else if (staying_in_state_5)
		state_5_d <= 1'b1;
	else // not in state 5 on next posedge clk
		state_5_d <= 1'b0;




/*************** State 6 ***************/

//state 6 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_6 <= 1'b0;
	else
		state_6 <= state_6_d;

//logic for entering state 6
always @ *
	if (state_5 && timer == 6'd1 )
		entering_state_6 <= 1'b1;
	else
		entering_state_6 <= 1'b0;


//logic for staying in state 6
always @ *
	if( (state_6 == 1'b1) && (timer != 6'd1) )
		staying_in_state_6 <= 1'b1;
	else
		staying_in_state_6 <= 1'b0;


// d-input for state_6 flip/flop
always @ *
	if (entering_state_6) // enter state 6 on next posedge clk
		state_6_d <= 1'b1;
	else if (staying_in_state_6)
		state_6_d <= 1'b1;
	else // not in state 2 on next posedge clk
		state_6_d <= 1'b0;




/*************** Outputs ***************/

// northbound_green enabled in state 4
always @ *
	if (state_4)
		northbound_green = 1'b1;
	else
		northbound_green = 1'b0;



// northbound_amber enabled in state 5
always @ *
	if (state_5)
		northbound_amber = 1'b1;
	else
		northbound_amber = 1'b0;



// northbound_red enabled in state 1, 2, 3, 4a, 6
always @ *
	if (state_1 || state_2 || state_3 || state_6 || state_4a)
		northbound_red = 1'b1;
	else
		northbound_red = 1'b0;



// southbound_green enabled in state 4
always @ *
	if (state_4)
		southbound_green = 1'b1;
	else
		southbound_green = 1'b0;



// southbound_amber enabled in state 5
always @ *
	if (state_5)
		southbound_amber = 1'b1;
	else
		southbound_amber = 1'b0;



// southbound_red enabled in state 1, 2, 3, 6
always @ *
	if (state_1 || state_2 || state_3 || state_6)
		southbound_red = 1'b1;
	else
		southbound_red = 1'b0;



// southbound_left enabled in state 4a
always @ *
	if (state_4a)
		southbound_left = 1'b1;
	else
		southbound_left = 1'b0;



// eastbound_green enabled in state 1
always @ *
	if (state_1)
		eastbound_green = 1'b1;
	else
		eastbound_green = 1'b0;



// eastbound_amber enabled in state 2
always @ *
	if (state_2)
		eastbound_amber = 1'b1;
	else
		eastbound_amber = 1'b0;




// eastbound_red enabled in state 3, 4a, 4, 5, 6
always @ *
	if (state_3 || state_4a || state_4 || state_5 || state_6)
		eastbound_red = 1'b1;
	else
		eastbound_red = 1'b0;




// westbound_green enabled in state 1
always @ *
	if (state_1)
		westbound_green = 1'b1;
	else
		westbound_green = 1'b0;




// westbound_amber enabled in state 2
always @ *
	if (state_2)
		westbound_amber = 1'b1;
	else
		westbound_amber = 1'b0;




// westbound_red enabled in state 3, 4a, 5, 6
always @ *
	if (state_3 || state_4a || state_4 || state_5 || state_6)
		westbound_red = 1'b1;
	else
		westbound_red = 1'b0;



endmodule
