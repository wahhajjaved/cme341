module traffic_controller (
	input clk_27,
	input debug,

	input not_reset,
	input not_southbound_left_request,
	input not_ns_walk_request,
	input not_ew_walk_request,

	output [6:0] north_traffic_hex, //northbound_traffic_light
	output [6:0] north_walk_hex, //northbound_walk_light
	output [6:0] south_hex, //southbound_traffic_light
	output [6:0] south_walk_hex, //southbound_walk_light
	output [6:0] east_light_hex, //eastbound_traffic_light
	output [6:0] east_walk_hex, //eastbound_walk_light
	output [6:0] west_light_hex, //westbound_traffic_light
	output [6:0] west_walk_hex, //westbound_walk_light

	//debug
	output walk_request_waiting,
	output [12:0] states
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


	.walk_request_waiting_debug(walk_request_waiting),
	.states(states)
);


hex_display_lights northbound_traffic_light (
	.colour({1'b0, northbound_green, northbound_amber, northbound_red}),
	.hex_segments(north_traffic_hex)
);

hex_display_lights southbound_traffic_light (
	.colour({southbound_left, southbound_green, southbound_amber, southbound_red}),
	.hex_segments(south_hex)
);

hex_display_lights eastbound_traffic_light (
	.colour({1'b0, eastbound_green, eastbound_amber, eastbound_red}),
	.hex_segments(east_light_hex)
);

hex_display_lights westbound_traffic_light (
	.colour({1'b0, westbound_green, westbound_amber, westbound_red}),
	.hex_segments(west_light_hex)
);




hex_display_walk northbound_walk_light (
	.clk(clk),
	.state({northbound_walk, northbound_flashing_dont_walk, northbound_dont_walk}),
	.hex_segments(north_walk_hex)
);

hex_display_walk southbound_walk_light (
	.clk(clk),
	.state({southbound_walk, southbound_flashing_dont_walk, southbound_dont_walk}),
	.hex_segments(south_walk_hex)
);

hex_display_walk eastbound_walk_light (
	.clk(clk),
	.state({eastbound_walk, eastbound_flashing_dont_walk, eastbound_dont_walk}),
	.hex_segments(east_walk_hex)
);

hex_display_walk westbound_walk_light (
	.clk(clk),
	.state({westbound_walk, westbound_flashing_dont_walk, westbound_dont_walk}),
	.hex_segments(west_walk_hex)
);






endmodule
