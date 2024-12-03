module traffic_controller (
	input clk_27,
	input debug,

	input not_reset,
	input not_southbound_left_request,
	input not_ns_walk_request,
	input not_ew_walk_request,

	output [6:0] hex7, //northbound
	output [6:0] hex5, //southbound
	output [6:0] hex3, //eastbound
	output [6:0] hex1, //westbound
	output [6:0] hex0, //debug

	//debug
	output ledg0, ledg1, ledg2, ledg3
);

wire clk;

wire northbound_green, northbound_amber, northbound_red;
wire northbound_walk, northbound_flashing_dont_walk, northbound_dont_walk;

wire southbound_green, southbound_amber, southbound_red, southbound_left;
wire southbound_walk, southbound_flashing_dont_walk, southbound_dont_walk;

wire eastbound_green, eastbound_amber, eastbound_red;
wire eastbound_walk, eastbound_flashing_dont_walk, eastbound_dont_walk;

wire westbound_green, westbound_amber, westbound_red;
wire westbound_walk, westbound_flashing_dont_walk, westbound_dont_walk;


//inverted KEY input
reg reset;
reg southbound_left_request;
reg ns_walk_request;
reg ew_walk_request;

/********************************************************/
/*						DEBUG	 						*/
/********************************************************/
reg [3:0] counter;
always @ *
	ledg0 = reset;
always @ *
	ledg1 = southbound_left_request;
always @ *
	ledg2 = ns_walk_request;
always @ *
	ledg3 = ew_walk_request;


// always @ (posedge clk)
// 	if (reset)
// 		counter = 4'h0;
// 	else if (counter == 4'hf)
// 		counter = 4'h0;
// 	else
// 		counter = counter + 4'h1;

/********************************************************/
/*					Invert Input						*/
/********************************************************/

always @ *
	reset = ~not_reset;

always @ *
	southbound_left_request = ~not_southbound_left_request;

always @ *
	ns_walk_request = ~not_ns_walk_request;

always @ *
	ew_walk_request = ~not_ew_walk_request;

/********************************************************/
/*					Instansiations						*/
/********************************************************/
//KEY push buttons are active low so reset needs to be inverted


clock clock_1(
	.clk_27(clk_27),
	.debug(debug),
	.reset(reset),
	.clk(clk)
);

traffic_controller_fsm traffic_controller_fsm_1 (
	.clk(clk),
	.reset(reset),
	.southbound_left_request(southbound_left_request),
	.walk_request(ns_walk_request || ew_walk_request),

	.northbound_green(northbound_green),
	.northbound_amber(northbound_amber),
	.northbound_red(northbound_red),
	.northbound_walk(northbound_walk),
	.northbound_flashing_dont_walk(northbound_flashing_dont_walk),
	.northbound_dont_walk(northbound_dont_walk),

	.southbound_green(southbound_green),
	.southbound_amber(southbound_amber),
	.southbound_red(southbound_red),
	.southbound_left(southbound_left),
	.southbound_walk(southbound_walk),
	.southbound_flashing_dont_walk(southbound_flashing_dont_walk),
	.southbound_dont_walk(southbound_dont_walk),

	.eastbound_green(eastbound_green),
	.eastbound_amber(eastbound_amber),
	.eastbound_red(eastbound_red),
	.eastbound_walk(eastbound_walk),
	.eastbound_flashing_dont_walk(eastbound_flashing_dont_walk),
	.eastbound_dont_walk(eastbound_dont_walk),

	.westbound_green(westbound_green),
	.westbound_amber(westbound_amber),
	.westbound_red(westbound_red),
	.westbound_walk(westbound_walk),
	.westbound_flashing_dont_walk(westbound_flashing_dont_walk),
	.westbound_dont_walk(westbound_dont_walk),

	.t(counter)
);


hex_display_lights northbound_traffic_light (
	.colour({1'b0, northbound_green, northbound_amber, northbound_red}),
	.hex_segments(hex7)
);

hex_display_lights southbound_traffic_light (
	.colour({southbound_left, southbound_green, southbound_amber, southbound_red}),
	.hex_segments(hex5)
);

hex_display_lights eastbound_traffic_light (
	.colour({1'b0, eastbound_green, eastbound_amber, eastbound_red}),
	.hex_segments(hex3)
);

hex_display_lights westbound_traffic_light (
	.colour({1'b0, westbound_green, westbound_amber, westbound_red}),
	.hex_segments(hex1)
);




hex_display_walk northbound_traffic_light (
	.state({northbound_walk, northbound_flashing_dont_walk, northbound_dont_walk}),
	.hex_segments(hex6)
);

hex_display_walk southbound_traffic_light (
	.state({southbound_walk, southbound_flashing_dont_walk, southbound_dont_walk}),
	.hex_segments(hex4)
);

hex_display_walk eastbound_traffic_light (
	.state({eastbound_walk, eastbound_flashing_dont_walk, eastbound_dont_walk}),
	.hex_segments(hex2)
);

hex_display_walk westbound_traffic_light (
	.state({westbound_walk, westbound_flashing_dont_walk, westbound_dont_walk}),
	.hex_segments(hex0)
);



endmodule
