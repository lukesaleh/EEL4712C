library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timing_tb is
end timing_tb;


architecture TB of timing_tb is

    constant TEST_WIDTH : positive := 8;

    signal x, y      : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal carry_in  : std_logic;
    signal s         : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal carry_out : std_logic;

begin  -- TB

    UUT : entity work.adder_top
        port map (
            x         => x,
            y         => y,
            carry_in  => carry_in,
            s         => s,
            carry_out => carry_out);

    process
    begin
        x <= (others => '1');
        y <= (others => '0');
        carry_in <= '1';
		wait for 50 ns;
		
        wait;

    end process;
end TB;