library ieee;
use ieee.std_logic_1164.all;

entity gray_tb is 
end gray_tb;

architecture tb of gray_tb is
signal  clk  :   std_logic := '0';
signal  rst  :   std_logic;
signal  output1  :   std_logic_vector(3 downto 0);
signal output2   :   std_logic_vector(3 downto 0);
begin
    U_GRAY1 : entity work.gray1
    port map(clk => clk,
        rst => rst,
        output => output1);
    U_GRAY2 : entity work.gray2
        port map(clk => clk,
            rst => rst,
            output => output2);
    
    clk <= not clk after 10 ns;
    process
    begin
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        wait for 200 ns;
    end process;
end tb;