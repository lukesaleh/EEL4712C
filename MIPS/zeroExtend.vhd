library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zeroextend is
  generic (
    width  :     positive := 32);
  port (
    input    : in  std_logic_vector(8 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end zeroextend;

architecture BHV of zeroExtend is
begin
  output <= std_logic_vector(resize(unsigned(input), width));
end BHV;