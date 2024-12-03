module traffic_controller_fsm (
	input clk,
	input reset,
	input southbound_left_request,
	input walk_request,

	output northbound_green, northbound_amber, northbound_red,
	output northbound_walk, northbound_flashing_dont_walk, northbound_dont_walk,

	output southbound_green, southbound_amber, southbound_red, southbound_left,
	output southbound_walk, southbound_flashing_dont_walk, southbound_dont_walk,

	output eastbound_green, eastbound_amber, eastbound_red,
	output eastbound_walk, eastbound_flashing_dont_walk, eastbound_dont_walk,

	output westbound_green, westbound_amber, westbound_red,
	output westbound_walk, westbound_flashing_dont_walk, westbound_dont_walk,

	output [3:0] t
);

`define TO timer == 6'd1 //timeout
`define NTO timer != 6'd1 //not timeout

reg [5:0] timer;
reg southbound_left_request_waiting;
reg walk_request_waiting;

reg entering_state_1w, entering_state_1fd, entering_state_1d, entering_state_1,
	entering_state_2, entering_state_3, entering_state_4a, entering_state_4w,
	entering_state_4fd, entering_state_4d, entering_state_4a, entering_state_4,
	entering_state_5, entering_state_6;

reg staying_in_state_1w, staying_in_state_1fd, staying_in_state_1d, staying_in_state_1,
	staying_in_state_2, staying_in_state_3, staying_in_state_4a, staying_in_state_4w,
	staying_in_state_4fd, staying_in_state_4d, staying_in_state_4a, staying_in_state_4,
	staying_in_state_5, staying_in_state_6;

reg state_1w_d, state_1fd_d, state_1d_d, state_1_d,
	state_2_d, state_3_d, state_4a_d, state_4w_d,
	state_4fd_d, state_4d_d, state_4a_d, state_4_d,
	state_5_d, state_6_d;

reg state_1w, state_1fd, state_1d, state_1,
	state_2, state_3, state_4a, state_4w,
	state_4fd, state_4d, state_4a, state_4,
	state_5, state_6;


/********************************************************/
/*						DEBUG	 						*/
/********************************************************/
always @ *
	t = {3'b0, southbound_left_request_waiting};
	// t = {3'b0, reset};
	// t = timer[3:0];



/********************************************************/
/* 						Inputs	 						*/
/********************************************************/
always @ *
	if (reset)
		southbound_left_request_waiting <= 1'b0;
	else if (entering_state_4a)
		southbound_left_request_waiting <= 1'b0;
	else
		southbound_left_request_waiting <= southbound_left_request;


/*************** walk request ***************/

always @ *
	if (reset)
		walk_request_waiting = 1'b0;
	else
		walk_request_waiting <= walk_request;





/********************************************************/
/* 						Timer	 						*/
/********************************************************/
always @ (posedge clk or posedge reset)
	if (reset)
		timer <= 6'd60;
	else if (entering_state_1w)
		timer <= 6'd10;
	else if (entering_state_1fd)
		timer <= 6'd20;
	else if (entering_state_1d)
		timer <= 6'd30;
	else if (entering_state_1)
		timer <= 6'd60;
	else if (entering_state_2)
		timer <= 6'd6;
	else if (entering_state_3)
		timer <= 6'd2;
	else if (entering_state_4a)
		timer <= 6'd20;
	else if (entering_state_4w)
		timer <= 6'd10;
	else if (entering_state_4fd)
		timer <= 6'd20;
	else if (entering_state_4d)
		timer <= 6'd30;
	else if (entering_state_4)
		timer <= 6'd60;
	else if (entering_state_5)
		timer <= 6'd6;
	else if (entering_state_6)
		timer <= 6'd2;
	else if (`TO)
		timer <= timer;
	else
		timer <= timer - 6'd1;





/********************************************************/
/* 						States	 						*/
/********************************************************/


/*************** State 1 ***************/

//state 1 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_1 <= 1'b1;
	else
		state_1 <= state_1_d;

//logic for entering state 1
always @ *
	if (state_6 && !walk_request_waiting && `TO)
		entering_state_1 <= 1'b1;
	else
		entering_state_1 <= 1'b0;

//logic for staying in state 1
always @ *
	if (state_1 && `NTO)
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




/*************** State 1w ***************/

//state 1w flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_1w <= 1'b0;
	else
		state_1w <= state_1w_d;

//logic for entering state 1w
always @ *
	if (state_6 && walk_request_waiting && `TO)
		entering_state_1w <= 1'b1;
	else
		entering_state_1w <= 1'b0;

//logic for staying in state 1w
always @ *
	if (state_1w && `NTO)
		staying_in_state_1w <= 1'b1;
	else
		staying_in_state_1w <= 1'b0;

// d-input for state_1w flip/flop
always @ *
	if (entering_state_1w)
		state_1w_d <= 1'b1;
	else if (staying_in_state_1w)
		state_1w_d <= 1'b1;
	else
		state_1w_d <= 1'b0;



/*************** State 1fd ***************/

//state 1fd flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_1fd <= 1'b0;
	else
		state_1fd <= state_1fd_d;

//logic for entering state 1fd
always @ *
	if (state_1w && `TO)
		entering_state_1fd <= 1'b1;
	else
		entering_state_1fd <= 1'b0;

//logic for staying in state 1fd
always @ *
	if (state_1fd && `NTO)
		staying_in_state_1fd <= 1'b1;
	else
		staying_in_state_1fd <= 1'b0;

// d-input for state_1fd flip/flop
always @ *
	if (entering_state_1fd)
		state_1fd_d <= 1'b1;
	else if (staying_in_state_1fd)
		state_1fd_d <= 1'b1;
	else
		state_1fd_d <= 1'b0;



/*************** State 1d ***************/

//state 1d flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_1d <= 1'b0;
	else
		state_1d <= state_1d_d;

//logic for entering state 1d
always @ *
	if (state_1fd && `TO)
		entering_state_1d <= 1'b1;
	else
		entering_state_1d <= 1'b0;

//logic for staying in state 1d
always @ *
	if (state_1d && `NTO)
		staying_in_state_1fd <= 1'b1;
	else
		staying_in_state_1fd <= 1'b0;

// d-input for state_1d flip/flop
always @ *
	if (entering_state_1d)
		state_1d_d <= 1'b1;
	else if (staying_in_state_1fd)
		state_1d_d <= 1'b1;
	else
		state_1d_d <= 1'b0;



/*************** State 2 ***************/

//state 2 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_2 <= 1'b0;
	else
		state_2 <= state_2_d;

//logic for entering state 2
always @ *
	if (state_1 && `TO)
		entering_state_2 <= 1'b1;
	else if (state_1d && `TO)
		entering_state_2 <= 1'b1;
	else
		entering_state_2 <= 1'b0;

//logic for staying in state 2
always @ *
	if (state_2 && `NTO)
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
	if (state_2 && `TO)
		entering_state_3 <= 1'b1;
	else
		entering_state_3 <= 1'b0;

//logic for staying in state 3
always @ *
	if (state_3 && `NTO)
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

//state 4a flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4a <= 1'b0;
	else
		state_4a <= state_4a_d;

//logic for entering state 4a
always @ *
	if (state_3 && southbound_left_request_waiting && `TO )
		entering_state_4a <= 1'b1;
	else
		entering_state_4a <= 1'b0;

//logic for staying in state 4a
always @ *
	if (state_4a && `NTO)
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
	if (state_3 && !southbound_left_request_waiting && !walk_request_waiting && `TO )
		entering_state_4 <= 1'b1;
	else if (state_4a && !walk_request_waiting && `TO)
		entering_state_4 <= 1'b1;
	else
		entering_state_4 <= 1'b0;

//logic for staying in state 4
always @ *
	if (state_4 && `NTO)
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



/*************** State 4w ***************/

//state 4w flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4w <= 1'b0;
	else
		state_4w <= state_4w_d;

//logic for entering state 4w
always @ *
	if (state_3 && !southbound_left_request_waiting && walk_request_waiting && `TO )
		entering_state_4w <= 1'b1;
	else if (state_4a && walk_request_waiting && `TO )
		entering_state_4w <= 1'b1;
	else
		entering_state_4w <= 1'b0;

//logic for staying in state 4w
always @ *
	if (state_4w && `NTO)
		staying_in_state_4w <= 1'b1;
	else
		staying_in_state_4w <= 1'b0;

// d-input for state_4w flip/flop
always @ *
	if (entering_state_4w) // enter state 4w on next posedge clk
		state_4w_d <= 1'b1;
	else if (staying_in_state_4w)
		state_4w_d <= 1'b1;
	else // not in state 4w on next posedge clk
		state_4w_d <= 1'b0;



/*************** State 4fd ***************/

//state 4fd flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4fd <= 1'b0;
	else
		state_4fd <= state_4fd_d;

//logic for entering state 4fd
always @ *
	if (state_4w && `TO )
		entering_state_4fd <= 1'b1;
	else
		entering_state_4fd <= 1'b0;

//logic for staying in state 4fd
always @ *
	if (state_4fd && `NTO)
		staying_in_state_4fd <= 1'b1;
	else
		staying_in_state_4fd <= 1'b0;

// d-input for state_4fd flip/flop
always @ *
	if (entering_state_4fd) // enter state 4fd on next posedge clk
		state_4fd_d <= 1'b1;
	else if (staying_in_state_4fd)
		state_4fd_d <= 1'b1;
	else // not in state 4fd on next posedge clk
		state_4fd_d <= 1'b0;



/*************** State 4d ***************/

//state 4d flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_4d <= 1'b0;
	else
		state_4d <= state_4d_d;

//logic for entering state 4d
always @ *
	if (state_4fd && `TO )
		entering_state_4d <= 1'b1;
	else
		entering_state_4d <= 1'b0;

//logic for staying in state 4d
always @ *
	if (state_4d && `NTO)
		staying_in_state_4d <= 1'b1;
	else
		staying_in_state_4d <= 1'b0;

// d-input for state_4d flip/flop
always @ *
	if (entering_state_4d) // enter state 4d on next posedge clk
		state_4d_d <= 1'b1;
	else if (staying_in_state_4d)
		state_4d_d <= 1'b1;
	else // not in state 4d on next posedge clk
		state_4d_d <= 1'b0;



/*************** State 5 ***************/
//state 5 flip flop
always @ (posedge clk or posedge reset)
	if (reset)
		state_5 <= 1'b0;
	else
		state_5 <= state_5_d;

//logic for entering state 5
always @ *
	if (state_4 && `TO )
		entering_state_5 <= 1'b1;
	else if (state_4d && `TO )
		entering_state_5 <= 1'b1;
	else
		entering_state_5 <= 1'b0;

//logic for staying in state 5
always @ *
	if (state_5 && `NTO)
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
	if (state_5 && `TO )
		entering_state_6 <= 1'b1;
	else
		entering_state_6 <= 1'b0;

//logic for staying in state 6
always @ *
	if (state_6 && `NTO)
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





/********************************************************/
/* 						Outputs	 						*/
/********************************************************/

// northbound_green enabled in state 4w 4fd 4d 4
always @ *
	if (state_4w || state_4fd || state_4d || state_4)
		northbound_green = 1'b1;
	else
		northbound_green = 1'b0;

// northbound_amber enabled in state 5
always @ *
	if (state_5)
		northbound_amber = 1'b1;
	else
		northbound_amber = 1'b0;

// northbound_red enabled in state 1w 1fd 1d 1 2 3 4a 6
always @ *
	if (state_1w || state_1fd || state_1d || state_1 || state_2 || state_3 || state_4a ||state_6)
		northbound_red = 1'b1;
	else
		northbound_red = 1'b0;




// northbound_walk enabled in state 4w
always @ *
	if (state_4w)
		northbound_walk = 1'b1;
	else
		northbound_walk = 1'b0;

// northbound_flashing_dont_walk enabled in state 4fd
always @ *
	if (state_4fd)
		northbound_flashing_dont_walk = 1'b1;
	else
		northbound_flashing_dont_walk = 1'b0;

// northbound_dont_walk enabled in state 1w 1fd 1d 1 2 3 4a 4d 4 5 6
always @ *
	if (state_1w || state_1fd || state_1d || state_1 || state_2 || state_3
		|| state_4a || state_4d || state_4 || state_5 || state_6)
		northbound_dont_walk = 1'b1;
	else
		northbound_dont_walk = 1'b0;




// southbound_left enabled in state 4a
always @ *
	if (state_4a)
		southbound_left = 1'b1;
	else
		southbound_left = 1'b0;




// southbound_green enabled in state 4w 4fd 4d 4
always @ *
	if (state_4w || state_4fd || state_4d || state_4)
		southbound_green = 1'b1;
	else
		southbound_green = 1'b0;

// southbound_amber enabled in state 5
always @ *
	if (state_5)
		southbound_amber = 1'b1;
	else
		southbound_amber = 1'b0;

// southbound_red enabled in state 1w 1fd 1d 1 2 3 6
always @ *
	if (state_1w || state_1fd || state_1d || state_1 || state_2 || state_3 || state_6)
		southbound_red = 1'b1;
	else
		southbound_red = 1'b0;




// southbound_walk enabled in state 4w
always @ *
	if (state_4w)
		southbound_walk = 1'b1;
	else
		southbound_walk = 1'b0;

// southbound_flashing_dont_walk enabled in state 4fd
always @ *
	if (state_4fd)
		southbound_flashing_dont_walk = 1'b1;
	else
		southbound_flashing_dont_walk = 1'b0;

// southbound_dont_walk enabled in state 1w 1fd 1d 1 2 3 4a 4d 4 5 6
always @ *
	if (state_1w || state_1fd || state_1d || state_1 || state_2 || state_3
		|| state_4a || state_4d || state_4 || state_5 || state_6)
		southbound_dont_walk = 1'b1;
	else
		southbound_dont_walk = 1'b0;




// eastbound_green enabled in state 1w 1fd 1d 1
always @ *
	if (state_1w || state_1fd || state_1d || state_1)
		eastbound_green = 1'b1;
	else
		eastbound_green = 1'b0;

// eastbound_amber enabled in state 2
always @ *
	if (state_2)
		eastbound_amber = 1'b1;
	else
		eastbound_amber = 1'b0;

// eastbound_red enabled in state 3 4a 4w 4fd 4d 4 5 6
always @ *
	if (state_3 || state_4a || state_4w || state_4fd || state_4d || state_4 || state_5 || state_6)
		eastbound_red = 1'b1;
	else
		eastbound_red = 1'b0;



// eastbound_walk enabled in state 1w
always @ *
	if (state_1w)
		eastbound_walk = 1'b1;
	else
		eastbound_walk = 1'b0;

// eastbound_flashing_dont_walk enabled in state 1fd
always @ *
	if (state_1fd)
		eastbound_flashing_dont_walk = 1'b1;
	else
		eastbound_flashing_dont_walk = 1'b0;

// eastbound_dont_walk enabled in state 1d 1 2 3 4a 4w 4fd 4d 4 5 6
always @ *
	if (state_1d || state_1 || state_2 || state_3 || state_4a || state_4w
		|| state_4fd || state_4d || state_4 || state_5 || state_6)
		eastbound_dont_walk = 1'b1;
	else
		eastbound_dont_walk = 1'b0;




// westbound_green enabled in state 1w 1fd 1d 1
always @ *
	if (state_1w || state_1fd || state_1d || state_1)
		westbound_green = 1'b1;
	else
		westbound_green = 1'b0;

// westbound_amber enabled in state 2
always @ *
	if (state_2)
		westbound_amber = 1'b1;
	else
		westbound_amber = 1'b0;

// westbound_red enabled in state 3 4a 4w 4fd 4d 4 5 6
always @ *
	if (state_3 || state_4a || state_4w || state_4fd ||
		state_4d || state_4 || state_5 || state_6)
		westbound_red = 1'b1;
	else
		westbound_red = 1'b0;



// westbound_walk enabled in state 1w
always @ *
	if (state_1w)
		westbound_walk = 1'b1;
	else
		westbound_walk = 1'b0;

// westbound_flashing_dont_walk enabled in state 1fd
always @ *
	if (state_1fd)
		westbound_flashing_dont_walk = 1'b1;
	else
		westbound_flashing_dont_walk = 1'b0;

// westbound_dont_walk enabled in state 1d 1 2 3 4a 4w 4fd 4d 4 5 6
always @ *
	if (state_1d || state_1 || state_2 || state_3 || state_4a || state_4w
		|| state_4fd || state_4d || state_4 || state_5 || state_6)
		westbound_dont_walk = 1'b1;
	else
		westbound_dont_walk = 1'b0;



endmodule
