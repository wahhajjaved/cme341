onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/clk
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/clear
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/seed
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/stimulus
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/student_output
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/counter_full_bar
add wave -noupdate -height 30 -radix hexadecimal -radixshowbase 1 /midterm_1_testbench/accumulator_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6955 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
configure wave -valuecolwidth 106
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
WaveRestoreZoom {0 ps} {18273 ps}
