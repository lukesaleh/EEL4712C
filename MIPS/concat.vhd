library ieee;
use ieee.std_logic_1164.all;

entity concat is
  generic (
    width  :     positive := 32);
  port (
    in1    : in  std_logic_vector(3 downto 0);
    in2      : in std_logic_vector(width-5 downto 0);
    output : out std_logic_vector((width-1) downto 0));
end concat;

architecture BHV of concat is
begin
  output <= in1 & in2;
end BHV;