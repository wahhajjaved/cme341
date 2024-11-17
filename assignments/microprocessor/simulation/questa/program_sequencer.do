onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -label clk -radix binary /program_sequencer_test/clk
add wave -noupdate -height 30 -label count -radix unsigned /program_sequencer_test/count
add wave -noupdate -height 30 -label sync_reset /program_sequencer_test/sync_reset
add wave -noupdate -height 30 -label jump /program_sequencer_test/jump
add wave -noupdate -height 30 -label conditional_jump /program_sequencer_test/conditional_jump
add wave -noupdate -height 30 -label LS_nibble_ir /program_sequencer_test/LS_nibble_ir
add wave -noupdate -height 30 -label zero_flag /program_sequencer_test/zero_flag
add wave -noupdate -height 30 -label pm_address /program_sequencer_test/pm_address
add wave -noupdate -color yellow -height 30 -label correct /program_sequencer_test/correct
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 314
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {5250 ns}
