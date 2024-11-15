library ieee;
use ieee.std_logic_1164.all;

entity adder_top is
    generic (
        WIDTH : positive := 8);
    port (
        x, y      : in  std_logic_vector(WIDTH-1 downto 0);
        carry_in  : in  std_logic;
        s         : out std_logic_vector(WIDTH-1 downto 0);
        carry_out : out std_logic);
end adder_top;

architecture STR of adder_top is
begin

    -- TODO: Update the architecture name in parentheses to synthesize a
    -- different architecture.
    U_ADDER : entity work.adder(CARRY_LOOKAHEAD)
        generic map (
            WIDTH => WIDTH)
        port map (
            x         => x,
            y         => y,
            carry_in  => carry_in,
            s         => s,
            carry_out => carry_out);

end STR;