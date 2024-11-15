library ieee; 
use ieee.std_logic_1164.all; 
entity cla4 is 
    port ( 
        x, y      : in  std_logic_vector(3 downto 0); 
        carry_in  : in  std_logic; 
        s         : out std_logic_vector(3 downto 0); 
        carry_out : out std_logic; 
        bg, bp    : out std_logic); 
end cla4; 

architecture structural of cla4 is
	component cla2
	port(
		x, y : in std_logic_vector (1 downto 0);
		carry_in : in std_logic;
		s: out std_logic_vector(1 downto 0);
		carry_out : out std_logic;
		bg, bp : out std_logic);
	end component;
		
	component cgen2
	port(
		c_in, bg_in1, bp_in1, bg_in2, bp_in2 : in  std_logic; 
        	c_out1, c_out2, bg_out, bp_out       : out std_logic); 
	end component;

signal carry_out1 : std_logic;
signal bg1, bp1, bg2, bp2 : std_logic;
begin
	
	cla2_1 : cla2 port map(
			 x => x(1 downto 0),
			  y => y(1 downto 0),
			carry_in => carry_in,
			s => s(1 downto 0),
			carry_out => open,
			bg => bg1,
			bp => bp1);
	cla2_2 : cla2 port map(
			 x => x(3 downto 2),
			y => y(3 downto 2),
			carry_in => carry_out1,
			s => s(3 downto 2),
			carry_out => open,
			bg => bg2,
			bp => bp2);
	cgen : cgen2 port map(
			c_in => carry_in,
			bg_in1 => bg1,
			bp_in1 => bp1,
			bg_in2 => bg2,
			bp_in2 => bp2,
			c_out1 => carry_out1,
			c_out2 => carry_out,
			bg_out => bg,
			bp_out => bp);
	
end structural; 