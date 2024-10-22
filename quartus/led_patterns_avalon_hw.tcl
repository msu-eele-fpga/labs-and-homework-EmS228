# TCL File Generated by Component Editor 23.1
# Mon Oct 21 19:06:36 MDT 2024
# DO NOT MODIFY


# 
# led_patterns_avalon "led_patterns_avalon" v1.0
#  2024.10.21.19:06:36
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module led_patterns_avalon
# 
set_module_property DESCRIPTION ""
set_module_property NAME led_patterns_avalon
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME led_patterns_avalon
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL led_patterns_avalon
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file led_patterns_avalon.vhd VHDL PATH ../hdl/led-patterns/led_patterns_avalon.vhd TOP_LEVEL_FILE
add_fileset_file LED_7bitDOWNcount.vhd VHDL PATH ../hdl/led-patterns/LED_7bitDOWNcount.vhd
add_fileset_file LED_7bitUPcount.vhd VHDL PATH ../hdl/led-patterns/LED_7bitUPcount.vhd
add_fileset_file LED_shiftINOUT.vhd VHDL PATH ../hdl/led-patterns/LED_shiftINOUT.vhd
add_fileset_file LED_shift_left_2.vhd VHDL PATH ../hdl/led-patterns/LED_shift_left_2.vhd
add_fileset_file LED_shift_right.vhd VHDL PATH ../hdl/led-patterns/LED_shift_right.vhd
add_fileset_file led_patterns.vhd VHDL PATH ../hdl/led-patterns/led_patterns.vhd
add_fileset_file async_conditioner.vhd VHDL PATH ../hdl/async-conditioner/async_conditioner.vhd
add_fileset_file debouncer.vhd VHDL PATH ../hdl/debouncer/debouncer.vhd
add_fileset_file one_pulse.vhd VHDL PATH ../hdl/one_pulse/one_pulse.vhd
add_fileset_file synchronizer.vhd VHDL PATH ../hdl/synchronizer/synchronizer.vhd
add_fileset_file timed_counter.vhd VHDL PATH ../hdl/timed-counter/timed_counter.vhd
add_fileset_file clkDiv.vhd VHDL PATH ../hdl/clkDivider/clkDiv.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clk
set_interface_property avalon_slave_0 associatedReset rst
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 avs_read read Input 1
add_interface_port avalon_slave_0 avs_write write Input 1
add_interface_port avalon_slave_0 avs_address address Input 2
add_interface_port avalon_slave_0 avs_readdata readdata Output 32
add_interface_port avalon_slave_0 avs_writedata writedata Input 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk clk clk Input 1


# 
# connection point rst
# 
add_interface rst reset end
set_interface_property rst associatedClock clk
set_interface_property rst synchronousEdges DEASSERT
set_interface_property rst ENABLED true
set_interface_property rst EXPORT_OF ""
set_interface_property rst PORT_NAME_MAP ""
set_interface_property rst CMSIS_SVD_VARIABLES ""
set_interface_property rst SVD_ADDRESS_GROUP ""

add_interface_port rst rst reset Input 1


# 
# connection point export
# 
add_interface export conduit end
set_interface_property export associatedClock clk
set_interface_property export associatedReset ""
set_interface_property export ENABLED true
set_interface_property export EXPORT_OF ""
set_interface_property export PORT_NAME_MAP ""
set_interface_property export CMSIS_SVD_VARIABLES ""
set_interface_property export SVD_ADDRESS_GROUP ""

add_interface_port export switches switches Input 4
add_interface_port export led led Output 8
add_interface_port export push_button push_button Input 1

