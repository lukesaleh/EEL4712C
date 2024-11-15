library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity ALUcontrol is
  port (
    instReg      : in  std_logic_vector(5 downto 0);
    instReg2016  : in std_logic_vector(4 downto 0);
    ALUop        : in  std_logic_vector(5 downto 0);
    ALU_LO_HI    : out std_logic_vector(1 downto 0);
    LO_en        : out std_logic;
    HI_en        : out std_logic;
    op_select    : out ALU_OP_T);
end ALUcontrol;

architecture BHV of ALUcontrol is
begin
    process(ALUop, instReg, instReg2016)
    begin
     
        ALU_LO_HI <= "00";
        LO_en <= '0';
        HI_en <= '0';
        op_select <= NULLS;
      
        case(ALUop) is
          when "000000" =>
              case(instReg) is 
                when "100001" =>
                  op_select <= ADD;
                when "100011"=>
                  op_select <= SUB;
                when "011000" => 
                  op_select <= MULT_S;
                  LO_en <= '1';
                  HI_en <= '1';
                when "011001" =>
                  op_select <= MULT;
                  LO_en <= '1';
                  HI_en <= '1';
                when "100100" =>
                  op_select <= AND_OP;
                when "100101" =>
                  op_select <= OR_OP;
                when "100110" =>
                  op_select <= XOR_OP;
                when "000010"=>
                  op_select <= LSR;
                when "000000" =>
                  op_select <= LSL;
                when "000011" =>
                  op_select <= ASR;
                when "101010" =>
                  op_select <= SLTS;
                when "101011" =>
                  op_select <= SLTU;
                when "010000" =>
                  op_select <= MFHI; 
                  ALU_LO_HI <= "10";
                when "010010" => 
                  op_select <= MFLO;
                  ALU_LO_HI <= "01";
                when others =>
                  null;
              end case;
          when "001001" =>
            op_select <= ADD;
          when "010000" =>
            op_select <= SUB;
          when "001100"=>
            op_select <= AND_OP;
          when "001101" =>
            op_select <= OR_OP;
          when "001110" =>
            op_select <= XOR_OP;
          when "001010" =>
            op_select <= SLTS;
          when "001011" =>
            op_select <= SLTU;
          when "100011"=>
            op_select <= ADD;
          when "101011" =>
            op_select <= ADD;
          when "000100" =>
            op_select <= BEQ; 
          when "000101" =>
            op_select <= BNE;
          when "000110" =>
            op_select <= BLEZ;
          when "000111" =>
            op_select <= BGTZ;
          when "000001" =>
              if(instReg2016 = "00000") then
                op_select <= BLTZ;
              elsif(instReg2016 = "00001") then
                op_select <= BGEZ;
              else 
                null;
              end if;
          when "000010" =>
              op_select <= J;
          when "000011" =>
              op_select <= JAL;
          when others =>
              null;
        end case;
    
    end process;
end BHV;