library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_tb is 

end alu_tb;

architecture TB of alu_tb is 
    signal shift    :   std_logic_vector(4 downto 0);
    signal inputA   :   std_logic_vector(31 downto 0);
    signal inputB   :   std_logic_vector(31 downto 0);
    signal op_select :  ALU_OP_t;
    signal branch_taken : std_logic;
    signal result   :   std_logic_vector(31 downto 0);
    signal result_hi :  std_logic_vector (31 downto 0);
begin
    UUT : entity work.alu 
        port map(shift => shift,
            inputA => inputA,
            inputB => inputB,
            op_select => op_select,
            branch_taken => branch_taken,
            result => result,
            result_hi => result_hi);
    process 
    begin
        op_select <= ADD;
        inputA <= (others => '0');
        inputB <= (others => '0');
        wait for 1 ns;
        shift <= "00000";
        op_select <= ADD;
        inputA <= std_logic_vector(to_unsigned(10, inputA'length));
        inputB <= std_logic_vector(to_unsigned(15, inputA'length));
        wait for 100 ns;

        op_select <= SUB;
        inputA <= std_logic_vector(to_unsigned(25, inputA'length));
        inputB <= std_logic_vector(to_unsigned(10, inputA'length));
        wait for 100 ns;

        op_select <= MULT_S;
        inputA <= std_logic_vector(to_signed(10, inputA'length));
        inputB <= std_logic_vector(to_signed(-4, inputA'length));
        wait for 100 ns;

        op_select <= MULT;
        inputA <= std_logic_vector(to_unsigned(65536, inputA'length));
        inputB <= std_logic_vector(to_unsigned(131072, inputA'length));
        wait for 100 ns;

        op_select <= AND_OP;
        inputA <= x"0000FFFF";
        inputB <= x"FFFF1234";
        wait for 100 ns;

        op_select <= LSR;
        shift <= "00100";
        inputB <= x"0000000F";
        wait for 100 ns;

        op_select <= ASR;
        shift <= "00001";
        inputB <= x"F0000008";
        wait for 100 ns;

        op_select <= ASR;
        shift <= "00001";
        inputB <= x"00000008";
        wait for 100 ns;

        op_select <= SLTU;
        inputA <= std_logic_vector(to_unsigned(10, inputA'length));
        inputB <= std_logic_vector(to_unsigned(15, inputB'length));
        wait for 100 ns;

        op_select <= SLTU;
        inputA <= std_logic_vector(to_unsigned(15, inputA'length));
        inputB <= std_logic_vector(to_unsigned(10, inputB'length));
        wait for 100 ns;

        op_select <= BLEZ;
        inputA <= std_logic_vector(to_unsigned(5, inputA'length));
        wait for 100 ns;

        op_select <=BGTZ;
        inputA <= std_logic_vector(to_unsigned(5, inputA'length));
        wait for 100 ns;
    end process;
end TB;