module traffic_controller (
	input clk_27,
	input debug,

	input not_reset,
	input not_southbound_left_request,
	input not_ns_walk_request,
	input not_ew_walk_request,

	output [6:0] hex7,
	output [6:0] hex6,
	output [6:0] hex5,
	output [6:0] hex4,
	output [6:0] hex3,
	output [6:0] hex2,
	output [6:0] hex1,
	output [6:0] hex0,

	//debug
	output ledg0, ledg2, ledg4, ledg6,
	// output ledr9
	output [12:0] LEDR
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
reg [12:0] s;
always @ *
	ledg0 = reset;
always @ *
	ledg2 = southbound_left_request;
always @ *
	ledg4 = ns_walk_request;
always @ *
	ledg6 = ew_walk_request;


always @ *
	LEDR = s;
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

	.t(counter),
	.s(s)
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




hex_display_walk northbound_walk_light (
	.clk(clk),
	.state({northbound_walk, northbound_flashing_dont_walk, northbound_dont_walk}),
	.hex_segments(hex6)
);

hex_display_walk southbound_walk_light (
	.clk(clk),
	.state({southbound_walk, southbound_flashing_dont_walk, southbound_dont_walk}),
	.hex_segments(hex4)
);

hex_display_walk eastbound_walk_light (
	.clk(clk),
	.state({eastbound_walk, eastbound_flashing_dont_walk, eastbound_dont_walk}),
	.hex_segments(hex2)
);

// hex_display_walk westbound_walk_light (
// 	.clk(clk),
// 	.state({westbound_walk, westbound_flashing_dont_walk, westbound_dont_walk}),
// 	.hex_segments(hex0)
// );

hex_display_driver d (
	.hex_digit(counter),
	.hex_segments(hex0)
);





endmodule
