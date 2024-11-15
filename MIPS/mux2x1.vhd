library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
  generic (
    width  :     positive := 32);
  port (
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    sel    : in  std_logic;
    output : out std_logic_vector(width-1 downto 0));
end mux2x1;

architecture BHV of mux2x1 is
begin
process(in1,in2,sel)
begin
case sel is
	when '0' =>
		output <= in1;
	when others =>
		output <= in2;
end case;
end process;
end BHV;
