library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftLeft2 is
  generic (
    width  :     positive := 32);
  port (
    input    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end shiftLeft2;

architecture BHV of shiftLeft2 is
	signal temp : unsigned(width-1 downto 0);
begin
	temp <= unsigned(input);
	output <= std_logic_vector(shift_left(temp, natural(2)));
end BHV;