-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity mux is
  
  port (
    in1    : in  std_logic_vector(31 downto 0);
    in2    : in  std_logic_vector(31 downto 0);
    in3    : in  std_logic_vector(31 downto 0);
    sel    : in  std_logic_vector(1 downto 0);
    output : out std_logic_vector(31 downto 0));

end mux;

architecture BHV of mux is
begin
  with sel select
    output <=
    in1 when "00",
    in2 when "01",
    in3 when "10",
    in1 when others;
end BHV;
