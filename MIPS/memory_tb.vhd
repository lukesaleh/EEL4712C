library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_tb is 

end memory_tb;

architecture TB of memory_tb is 
signal inport_en    :   std_logic;
signal memread      :   std_logic;
signal memwrite     :   std_logic;
signal clk,rst      :   std_logic;
signal inport       :   std_logic_vector(31 downto 0);
signal input        :   std_logic_vector(31 downto 0);
signal outport      :   std_logic_vector(31 downto 0);
signal outdata      :   std_logic_vector(31 downto 0);
signal address       :   std_logic_vector(31 downto 0);
signal switch10     :   std_logic;
begin 
    UUT : entity work.memory
    port map(inport_en => inport_en,
        address => address,
        memread => memread,
        memwrite => memwrite,
        clk => clk,
        rst => rst,
        switch10 => switch10,
        inport => inport,
        input => input,
        outport => outport,
        outdata => outdata);
    process 
    begin
        rst <= '1';
        inport_en <= '0';
        wait for 10 ns;
        rst <= '0';
        memwrite <= '1';
        memread <= '0';
        address <= x"00000000";
        input <= x"0A0A0A0A";
        wait for 100 ns;

        address <= x"00000004";
        input <= x"F0F0F0F0";
        wait for 100 ns;

        memwrite <= '0';
        memread <= '1';
        address <= x"00000000";
        wait for 100 ns;

        address <= x"00000001";
        wait for 100 ns;

        address <= x"00000004";
        wait for 100 ns;

        address <= x"00000005";
        wait for 100 ns;

        memwrite <= '1';
        memread <= '0';
        address <= x"0000FFFC";
        input <= x"00001111";
        wait for 100 ns;

        inport_en <= '1';
        switch10 <= '0';
        inport <= x"00010000";
        wait for 100 ns;

        inport_en <= '1';
        switch10 <= '1';
        inport <= x"00000001";
        wait for 100 ns;

        switch10 <= '0';
        address <= x"0000FFF8";
        wait for 100 ns;

        address <= x"0000FFFC";
        wait for 100 ns;
    end process;
end TB;