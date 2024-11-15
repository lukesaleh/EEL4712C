library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
        clk50MHz : in std_logic;
        switch   : in  std_logic_vector(9 downto 0);
        button_n : in  std_logic_vector(1 downto 0);
        led0     : out std_logic_vector(6 downto 0);
        led0_dp  : out std_logic;
        led1     : out std_logic_vector(6 downto 0);
        led1_dp  : out std_logic;
        led2     : out std_logic_vector(6 downto 0);
        led2_dp  : out std_logic;
        led3     : out std_logic_vector(6 downto 0);
        led3_dp  : out std_logic;
        led4     : out std_logic_vector(6 downto 0);
        led4_dp  : out std_logic;
        led5     : out std_logic_vector(6 downto 0);
        led5_dp  : out std_logic
        );
end top_level;


architecture STR of top_level is

    signal button    : std_logic_vector(button_n'range);
    signal output       : std_logic_vector(7 downto 0);
    signal input1    : std_logic_vector(7 downto 0);
    signal input2    : std_logic_vector(7 downto 0);
    signal done : std_logic;

    constant C0 : std_logic_vector(3 downto 0) := "0000";

begin  -- STR

    -- the buttons are active low
    button <= not button_n;

    -- map adder output to two LEDs
    U_LED5 : entity work.decoder7seg port map (
        input  => output(7 downto 4),
        output => led5);

    U_LED4 : entity work.decoder7seg port map (
        input  => output(3 downto 0),
        output => led4);

    -- all other LEDs should display 0
    U_LED3 : entity work.decoder7seg port map (
        input  => C0,
        output => led3);

    U_LED2 : entity work.decoder7seg port map (
        input  => C0,
        output => led2);

    U_LED1 : entity work.decoder7seg port map (
        input  => C0,
        output => led1);

    U_LED0 : entity work.decoder7seg port map (
        input  => C0,
        output => led0);

    -- Because there are only 10 switches on the board, this code concatenates
    -- 3 zeros to the switch inputs to make the adder inputs eight bits each
    -- An alternative would be to use a 5-bit adder, but one of the
    -- architectures only supports eight bits.
    input1 <= "000" & switch(9 downto 5);
    input2 <= "000" & switch(4 downto 0);

    -- instantiate adder (has to be eight bits for this top-level file)
    -- Change the architecture name here to synthesize a different adder.
    U_GCD : entity work.gcd(FSMD2)
        generic map (
            WIDTH => 8)
        port map (
            clk       => clk50MHz,
            rst       => button(1),
            x         => input1,
            y         => input2,
            go        => button(0),     -- carry_in mapped to bottom button
            output         => output,
            done => done);

    -- show carry out on dp of leftmost LED
    -- should never be asserted due to 5-bit inputs
    led5_dp <= not done;

    -- show 6th sum bit (actual carry out) on led4 dp
    led4_dp <= '1';
    led3_dp <= '1';
    led2_dp <= '1';
    led1_dp <= '1';
    led0_dp <= '1';

end STR;