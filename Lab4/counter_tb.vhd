library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is 
end counter_tb;
architecture TB of counter_tb is
    signal clk      :   std_logic := '0';
    signal rst      :   std_logic;
    signal load_n   :   std_logic;
    signal input    :   std_logic_vector(3 downto 0);
    signal up_n     :   std_logic;
    signal output   :   std_logic_vector(3 downto 0);
begin
    U_COUNTER : entity work.counter_mod
    port map(clk => clk,
        rst => rst,
        up_n => up_n,
        load_n => load_n,
        input => input,
        output => output);
        clk <= not clk after 10 ns;
    process
    begin

    rst <= '1';
    up_n <= '0';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;
    
    rst <= '0';
    up_n <= '0';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    rst <= '1';
    up_n <= '0';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    rst <= '0';
    up_n <= '1';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    rst <= '0';
    up_n <= '1';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    rst <= '1';
    up_n <= '1';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    rst <= '0';
    up_n <= '1';
    load_n <= '0';
    input <= "0100";
    wait for 100 ns;

    rst <= '0';
    up_n <= '1';
    load_n <= '1';
    input <= "0000";
    wait for 100 ns;

    end process;
    end TB;