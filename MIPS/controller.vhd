library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
port(
clk, rst    :   in std_logic;
ireg_out    :   in std_logic_vector(5 downto 0);
PCWriteCond, PCWrite, IorD, memRead, memWrite, memToReg, IRWrite  :   out std_logic;  
jumpAndLink, isSigned, ALUSrcA, RegWrite, RegDst : out std_logic;
ALUSrcB, PCsource : out std_logic_vector(1 downto 0);
ALUOP       : out std_logic_vector(5 downto 0);

ireg_out_low5 : in std_logic_vector(5 downto 0)
);
end controller;

architecture BHV of controller is
type state_t is (START, FETCH, INSTRUCTIONDECODE, MEMORYCOMPUTATION, MEMORYACCESSREAD, MEMORYACCESSWRITE, MEMORYREAD, MEMORYREAD2, EXECUTION, EXECUTIONI, BRANCH, BRANCHEND ,JUMP, JUMPR, JAL1, JAL2, RTYPE, ITYPE, HALT, BLANK);
signal state, next_state    : state_t;

begin
process(clk, rst)
begin
    if(rst = '1') then
        state <= START;
    elsif(rising_edge(clk)) then
        state <= next_state;
    end if;
end process;
process(state, ireg_out, ireg_out_low5)
begin 
    
    PCWriteCond <= '0';
            PCWrite <= '0';
            IorD <= '0';
            memRead <= '0';
            memWrite <= '0';
            memToReg <= '1';
            IRWrite <= '0';
            jumpAndLink <= '0';
            isSigned <= '0';
            ALUSrcA <= '0';
            RegWrite <= '0';
            RegDst <= '0';
            ALUOP <= "000000";
            ALUSrcB <= "00";
            PCsource <= "00";
            next_state <= state;
    case(state) is 
        when START =>
            
            next_state <= state;
            PCWriteCond <= '0';
            PCWrite <= '0';
            IorD <= '0';
            memRead <= '0';
            memWrite <= '0';
            memToReg <= '1';
            IRWrite <= '0';
            jumpAndLink <= '0';
            isSigned <= '0';
            ALUSrcA <= '0';
            RegWrite <= '0';
            RegDst <= '0';
            ALUOP <= "001001";
            ALUSrcB <= "00";
            PCsource <= "00";
            next_state <= FETCH;
        when FETCH =>
            memRead <= '1';
            ALUSrcA <= '0';
            IorD <= '0';
            IRWrite <= '1';
            ALUSrcB <= "01";
            ALUOP <= "001001";
            PCWrite <= '1';
            PCSource <= "00";
            next_state <= INSTRUCTIONDECODE;
        when INSTRUCTIONDECODE =>
            ALUSrcA <= '0';
            ALUSrcB <= "11";
            if ((ireg_out = "100011") or (ireg_out = "101011")) then
                ALUOP <= "000000";
                next_state <= MEMORYCOMPUTATION;
            elsif(ireg_out = "000000") then
                ALUOP <= "000000";
                next_state <= EXECUTION;
            elsif(ireg_out = "001001") then
                ALUOP <= "001001";
                next_state <= EXECUTIONI;
            elsif(ireg_out = "010000") then
                ALUOP <= "010000";
                next_state <= EXECUTIONI;
            elsif(ireg_out = "001100") then
                ALUOP <= "001100";
                next_state <= EXECUTIONI;
            elsif (ireg_out = "001101") then
                ALUOP <= "001101";
                next_state <= EXECUTIONI;
            elsif (ireg_out = "001110") then
                ALUOP <= "001110";
                next_state <= EXECUTIONI;
            elsif(ireg_out = "001011") then
                ALUOP <= "001011";
                next_state <= EXECUTIONI;
            elsif(ireg_out = "001010") then
                ALUOP <= "001010";
                next_state <= EXECUTIONI;
            elsif(ireg_out = "111111") then 
                next_state <= HALT;
            elsif(ireg_out = "000100") then
                ALUOP <= "000100";
                next_state <= BRANCH;
            elsif(ireg_out = "000101") then
                ALUOP <= "000101"; 
                next_state <= BRANCH;
            elsif(ireg_out = "000110") then
                ALUOP <= "000110";
                next_state <= BRANCH;
            elsif(ireg_out = "000111") then
                ALUOP <= "000111";
                next_state <= BRANCH;
            elsif(ireg_out = "000001") then
                ALUOP <= "000001";
                next_state <= BRANCH;
            elsif(ireg_out = "000010") then
                ALUOP <= "000010";
                next_state <= JUMP;
            elsif(ireg_out = "000011") then
                ALUOP <= "000011";
                next_state <= JAL1;
            else
                next_state <= INSTRUCTIONDECODE;
            end if;
        when MEMORYCOMPUTATION =>
            ALUSrcA <= '1';
            ALUSrcB <= "10";
            ALUOP <= "001001";
            if(ireg_out <= "100011") then
                next_state <= MEMORYACCESSREAD;
            elsif(ireg_out <= "101011") then
                next_state <= MEMORYACCESSWRITE;
            else
                next_state <= MEMORYCOMPUTATION;
            end if;
        when MEMORYACCESSREAD =>
            memRead <= '1';
            IorD <= '1';
            next_state <= MEMORYREAD;
        when MEMORYACCESSWRITE =>
            memWrite <= '1';
            IorD <= '1';
            next_state <= BLANK;
        when BLANK =>
            ALUOP <= "100000";
            next_state <= FETCH;
        when MEMORYREAD =>
            next_state <= MEMORYREAD2;
        when MEMORYREAD2 =>
            RegDst <= '0';
            RegWrite <= '1';
            memToReg <= '1';
            next_state <= FETCH;
        when EXECUTION =>
            ALUSrcA <= '1';
            ALUSrcB <= "00";
            ALUOP <= "000000";
            if ((ireg_out_low5 = "011000") or (ireg_out_low5 = "011001")) then
                next_state <= FETCH;
            else
                next_state <= RTYPE;
            end if;
        when EXECUTIONI =>
            ALUSrcA <= '1';
            ALUSrcB <= "10";
            if(ireg_out = "001001") then
                ALUOP <= "001001";
                
            elsif(ireg_out = "010000") then
                ALUOP <= "010000";
                
            elsif(ireg_out = "001100") then
                ALUOP <= "001100";
                
            elsif (ireg_out = "001101") then
                ALUOP <= "001101";
                
            elsif (ireg_out = "001110") then
                ALUOP <= "001110";
            
            elsif(ireg_out = "001011") then
                ALUOP <= "001011";
                
            elsif(ireg_out = "001010") then
                ALUOP <= "001010";
            end if;
            next_state <= ITYPE;
        when RTYPE =>
            RegDst <= '1';
            RegWrite <= '1';
            memToReg <= '0';
            if (ireg_out_low5 = "001000") then
                next_state <= JUMPR;
            else 
                next_state <= FETCH;
            end if;
        when ITYPE =>
            RegDst <= '0';
            RegWrite <= '1';
            memToReg <= '0';
            next_state <= FETCH;
        when BRANCH =>
            ALUSrca <= '0';
            ALUSrcB <= "11";
            
            ALUOP <= "001001";
            
            if((ireg_out = "000100") or (ireg_out = "000101")) then
                isSigned <= '0';
            else
                isSigned <= '1';
            end if;
            next_state <= BRANCHEND;
        when BRANCHEND =>
            ALUOP <= ireg_out;
            PCWriteCond <= '1';
            PCsource <= "01";
            ALUSrcA <= '1';
            ALUSrcB <= "00";
            next_state <= BLANK;
        when JUMP =>
            ALUOP <= ireg_out;
            PCWrite <= '1';
            PCsource <= "10";
            IorD <= '0';
            next_state <= BLANK;
        when JAL1 =>
            ALUOP <= "000011";
            ALUSrca <= '0';
            ALUSrcB <= "01";
            PCWrite <= '1';
            PCSource <= "10";
            next_state <= JAL2;
        when JAL2 =>
            memToReg <= '0';
            ALUOP <= "000011";
            jumpAndLink <= '1';
            regWrite <= '1';
            next_state <= FETCH;
        when JUMPR =>
            ALUOP <= "001001";
            ALUSrcA <= '1';
            PCSource <= "00";
            PCWrite <= '1';
            next_state <= BLANK;
        when HALT =>
            null;
    end case;

end process;

end BHV;
