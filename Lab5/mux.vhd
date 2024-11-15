-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity mux is
  generic (
    width  :     positive:=16);
  port (
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    sel    : in  std_logic;
    output : out std_logic_vector(width-1 downto 0));
end mux;

architecture BHV of mux is
begin
  with sel select
    output <=
    in2 when '0',
    in1 when others;
end BHV;
