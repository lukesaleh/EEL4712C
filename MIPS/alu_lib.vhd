library ieee;
use ieee.std_logic_1164.all;

package alu_lib is 
type ALU_OP_t is (NULLS, ADD,SUB,MULT, MULT_S, AND_OP, OR_OP, XOR_OP, LSL, LSR, ASR, SLTU, SLTS, BEQ, BNE, BLEZ, BGTZ, BLTZ, BGEZ, MFHI, MFLO, J, JAL);
end alu_lib; 