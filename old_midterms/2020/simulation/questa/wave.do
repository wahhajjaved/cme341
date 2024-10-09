onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/clk
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/clear
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/seed
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/stimulus
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/student_output
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/counter_full_bar
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 sim:/midterm_1_testbench/accumulator_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 304
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
WaveRestoreZoom {0 ps} {1190 ps}
