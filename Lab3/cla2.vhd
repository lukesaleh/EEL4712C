library ieee; 
use ieee.std_logic_1164.all; 
entity cla2 is 
    port ( 
        x, y      : in  std_logic_vector(1 downto 0); 
        carry_in  : in  std_logic; 
        s         : out std_logic_vector(1 downto 0); 
        carry_out : out std_logic; 
        bg, bp    : out std_logic); 
end cla2; 


architecture behavior of cla2 is
begin
process(x, y, carry_in)
variable g0, p0, g1, p1, carry : std_logic;

begin
	g0 := x(0) and y(0);
	g1 := x(1) and y(1);
	p0 := x(0) or y(0);
	p1 := x(1) or y(1);
	carry:= g0 or (p0 and carry_in);
	s(0) <= x(0) xor y(0) xor carry_in;
	s(1) <= x(1) xor y(1) xor carry;
	bg <= g1 or (g0 and p1);
	bp <= p1 and p0 and carry_in;
	carry_out <= g1 or (p1 and g0) or (p1 and p0 and carry_in);
end process;
end behavior;