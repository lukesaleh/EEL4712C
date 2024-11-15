library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
  generic (
    width  :     positive := 32);
  port (
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    in3    : in  std_logic_vector(width-1 downto 0);
    in4    : in  std_logic_vector(width-1 downto 0);
    sel    : in  std_logic_vector(1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end mux4x1;

architecture BHV of mux4x1 is
begin
    output <=
        in4 when sel = "11" else
        in3 when sel = "10" else
        in2 when sel = "01" else
        in1;
end BHV;
