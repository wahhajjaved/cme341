module electronic_card_lock(
	input key_0,
	input key_1,
	input [15:0] entry_code_on_card,
	input [1:0] card_type,
	output card_read,
	output trip_lock_for_guest
);


`define IS_GUEST_CARD card_type == 2'b00
`define IS_MAID_CARD card_type == 2'b01
`define IS_GUEST_RESET_CARD card_type == 2'b10
`define IS_MAID_RESET_CARD card_type == 2'b11
`define IS_GUEST_RESET_CODE entry_code_on_card == 16'habcd
`define IS_MAID_RESET_CODE entry_code_on_card == 16'habcd


wire guest_d0, maid_d0;
reg [15:0] current_guest_code, current_maid_code, guest_lfsr, maid_lfsr;
reg guest_open_door, maid_open_door;


always @ *
	if (key_1)
		card_read = 1'b1;
	else if (key_0)
		card_read = 1'b0;
	else
		card_read = card_read;


assign trip_lock_for_guest = card_read && (guest_open_door || maid_open_door);


/********************************************************/
/*						Guest	 						*/
/********************************************************/


assign guest_d0 = guest_lfsr[4] ^ guest_lfsr[15] ^ guest_lfsr[1] ^ guest_lfsr[2];

//guest lfsr
always @ (posedge card_read)
	if (`IS_GUEST_RESET_CARD && `IS_GUEST_RESET_CODE)
		guest_lfsr <= 16'h0;
	else if (`IS_GUEST_CARD && guest_lfsr == 16'h0)
		guest_lfsr <= entry_code_on_card;
	else if (`IS_GUEST_CARD && entry_code_on_card == guest_lfsr)
		guest_lfsr <= {guest_lfsr[14:0], guest_d0};
	else
		guest_lfsr <= guest_lfsr;


//current guest code
always @ (posedge card_read)
	if (`IS_GUEST_RESET_CARD && `IS_GUEST_RESET_CODE)
		current_guest_code <= 16'h0;
	else if (`IS_GUEST_CARD && guest_lfsr == 16'h0)
		current_guest_code <= 16'h0;
	else if (`IS_GUEST_CARD && entry_code_on_card == guest_lfsr)
		current_guest_code <= entry_code_on_card;
	else
		current_guest_code <= current_guest_code;


//open door
always @ (posedge card_read)
	if (`IS_GUEST_RESET_CARD && `IS_GUEST_RESET_CODE)
		guest_open_door <= 1'b0;
	else if (`IS_GUEST_CARD && guest_lfsr == 16'h0)
		guest_open_door <= 1'b1;
	else if (`IS_GUEST_CARD && entry_code_on_card == guest_lfsr)
		guest_open_door <= 1'b1;
	else if (`IS_GUEST_CARD && current_guest_code == entry_code_on_card)
		guest_open_door <= 1'b1;
	else
		guest_open_door <= 1'b0;



/********************************************************/
/*						MAID	 						*/
/********************************************************/


assign maid_d0 = maid_lfsr[4] ^ maid_lfsr[15] ^ maid_lfsr[1] ^ maid_lfsr[2];

//maid lfsr
always @ (posedge card_read)
	if (`IS_MAID_RESET_CARD && `IS_MAID_RESET_CODE)
		maid_lfsr <= 16'h0;
	else if (`IS_GUEST_RESET_CARD && `IS_GUEST_RESET_CODE)
		maid_lfsr <= 16'h0;
	else if (`IS_MAID_CARD && maid_lfsr == 16'h0)
		maid_lfsr <= entry_code_on_card;
	else if (`IS_MAID_CARD && entry_code_on_card == maid_lfsr)
		maid_lfsr <= {maid_lfsr[14:0], maid_d0};
	else
		maid_lfsr <= maid_lfsr;


//current maid code
always @ (posedge card_read)
	if (`IS_MAID_RESET_CARD && `IS_MAID_RESET_CODE)
		current_maid_code <= 16'h0;
	else if (`IS_GUEST_RESET_CARD && `IS_GUEST_RESET_CODE)
		current_maid_code <= 1'b0;
	else if (`IS_MAID_CARD && maid_lfsr == 16'h0)
		current_maid_code <= 16'h0;
	else if (`IS_MAID_CARD && entry_code_on_card == maid_lfsr)
		current_maid_code <= entry_code_on_card;
	else
		current_maid_code <= current_maid_code;


//open door
always @ (posedge card_read)
	if (`IS_MAID_RESET_CARD && `IS_MAID_RESET_CODE)
		maid_open_door <= 1'b0;
	else if (`IS_MAID_CARD && maid_lfsr == 16'h0)
		maid_open_door <= 1'b1;
	else if (`IS_MAID_CARD && entry_code_on_card == maid_lfsr)
		maid_open_door <= 1'b1;
	else if (`IS_MAID_CARD && current_maid_code == entry_code_on_card)
		maid_open_door <= 1'b1;
	else
		maid_open_door <= 1'b0;







endmodule