onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CONTROLLER
add wave -noupdate -radix hexadecimal /controller_tb/ALUSrcA
add wave -noupdate -radix hexadecimal /controller_tb/ALUSrcB
add wave -noupdate -radix hexadecimal /controller_tb/IRWrite
add wave -noupdate -radix hexadecimal /controller_tb/switches
add wave -noupdate -radix hexadecimal /controller_tb/IorD
add wave -noupdate -radix hexadecimal /controller_tb/LEDs
add wave -noupdate -radix hexadecimal /controller_tb/PCSource
add wave -noupdate -radix hexadecimal /controller_tb/PCWrite
add wave -noupdate -radix hexadecimal /controller_tb/PCWriteCond
add wave -noupdate -radix hexadecimal /controller_tb/RegDst
add wave -noupdate -radix hexadecimal /controller_tb/RegWrite
add wave -noupdate -radix hexadecimal /controller_tb/clk
add wave -noupdate -radix hexadecimal /controller_tb/instRegLow5
add wave -noupdate -radix hexadecimal /controller_tb/ireg_out
add wave -noupdate -radix hexadecimal /controller_tb/isSigned
add wave -noupdate -radix hexadecimal /controller_tb/jumpAndLink
add wave -noupdate -radix hexadecimal /controller_tb/memRead
add wave -noupdate -radix hexadecimal /controller_tb/memToReg
add wave -noupdate -radix hexadecimal /controller_tb/memWrite
add wave -noupdate -radix hexadecimal /controller_tb/rst
add wave -noupdate -radix hexadecimal /controller_tb/ALUOP
add wave -noupdate -radix hexadecimal /controller_tb/U_CONTROLLER/ireg_out
add wave -noupdate -radix hexadecimal /controller_tb/branchTaken
add wave -noupdate -radix hexadecimal /controller_tb/U_CONTROLLER/state
add wave -noupdate -divider LO_REG
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_LO/output
add wave -noupdate -divider HI_REG
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_HI/output
add wave -noupdate -divider {ALU_OUT REGISTER}
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_ALUOUT/input
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_ALUOUT/output
add wave -noupdate -divider INPORT0
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/REG_IN_0/input
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/REG_IN_0/output
add wave -noupdate -divider INPORT1
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/REG_IN_1/input
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/REG_IN_1/output
add wave -noupdate -divider MEMORY
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/outdata
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/outPort
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/inport
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/address
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEM/input
add wave -noupdate -divider ALU_CONTROL
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALUCONTROL/ALUop
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALUCONTROL/instReg
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALUCONTROL/HI_en
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALUCONTROL/instReg2016
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALUCONTROL/op_select
add wave -noupdate -divider MUX_ALU_A
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX_ALU_A/in1
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX_ALU_A/in2
add wave -noupdate -divider ALU
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/inputA
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/inputB
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/shift
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/result
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_LO/output
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/result
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/result_hi
add wave -noupdate -divider IR
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_INSTRUCTION_REGISTER/input
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_INSTRUCTION_REGISTER/output
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_ALU/op_select
add wave -noupdate -divider CONCAT
add wave -noupdate /controller_tb/U_DATAPATH/U_CONCAT/in1
add wave -noupdate /controller_tb/U_DATAPATH/U_CONCAT/in2
add wave -noupdate -radix binary /controller_tb/U_DATAPATH/U_CONCAT/output
add wave -noupdate -divider MUX_INTO_PC
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/shift28_out
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX3/in1
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX3/in2
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX3/in3
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MUX3/output
add wave -noupdate -divider PC
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_PC/input
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_PC/output
add wave -noupdate -divider REGFILE
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/rd_addr0
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/rd_addr1
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/rd_data0
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/rd_data1
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/wr_addr
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_REG_FILE/wr_data
add wave -noupdate -radix hexadecimal -childformat {{/controller_tb/U_DATAPATH/U_REG_FILE/registers(0) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(1) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(2) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(3) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(4) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(5) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(6) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(7) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(8) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(9) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(10) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(11) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(12) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(13) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(14) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(15) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(16) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(17) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(18) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(19) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(20) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(21) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(22) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(23) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(24) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(25) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(26) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(27) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(28) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(29) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(30) -radix hexadecimal} {/controller_tb/U_DATAPATH/U_REG_FILE/registers(31) -radix hexadecimal}} -expand -subitemconfig {/controller_tb/U_DATAPATH/U_REG_FILE/registers(0) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(1) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(2) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(3) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(4) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(5) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(6) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(7) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(8) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(9) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(10) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(11) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(12) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(13) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(14) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(15) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(16) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(17) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(18) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(19) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(20) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(21) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(22) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(23) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(24) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(25) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(26) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(27) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(28) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(29) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(30) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/U_REG_FILE/registers(31) {-height 15 -radix hexadecimal}} /controller_tb/U_DATAPATH/U_REG_FILE/registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {195000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 405
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {720918572 ps} {721020076 ps}
