## Generated SDC file "lab_exam_card_lock.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Standard Edition"

## DATE    "Tue Nov 22 20:07:10 2022"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLOCK_27} -period 37.000 -waveform { 0.000 18.500 } [get_ports {CLOCK_27}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {sl_clk} -source [get_ports {CLOCK_27}] -divide_by 6 -master_clock {CLOCK_27} [get_registers {magic_exam_card:mxc|sl_clk}]
create_generated_clock -name {maid_lfsr_clk} -source [get_ports {CLOCK_27}] -divide_by 6 -master_clock {CLOCK_27} [get_registers {magic_exam_card:mxc|magic_clock_maid}] 
create_generated_clock -name {guest_lfsr_clk} -source [get_ports {CLOCK_27}] -divide_by 6 -master_clock {CLOCK_27} [get_registers {magic_exam_card:mxc|magic_clock_guest}]
#create_generated_clock -name {maid_lfsr_clk} -source [get_registers {magic_exam_card:mxc|sl_clk}] -master_clock {sl_clk} [get_registers {magic_exam_card:mxc|magic_clock_maid}]
#create_generated_clock -name {guest_lfsr_clk} -source [get_registers {magic_exam_card:mxc|sl_clk}] -master_clock {sl_clk} [get_registers {magic_exam_card:mxc|magic_clock_guest}]
#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

derive_clock_uncertainty


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

