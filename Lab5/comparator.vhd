library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
  generic (
    width :     positive := 16);
  port (
    in1   : in  std_logic_vector(width-1 downto 0);
    in2   : in  std_logic_vector(width-1 downto 0);
    lt    : out std_logic;
    ne    : out std_logic);
end comparator;

architecture BHV of comparator is
begin
  lt <= '1' when unsigned(in1) < unsigned(in2) else '0';
  ne <= '1' when unsigned(in1) /= unsigned(in2) else '0';
end BHV;