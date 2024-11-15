library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signExtend is
  generic (
    width  :     positive := 32);
  port (
    input    : in  std_logic_vector((width/2 -1) downto 0);
    isSigned : in std_logic;
    output : out std_logic_vector(width-1 downto 0));
end signExtend;

architecture sign of signExtend is
begin
  
  process(input, isSigned)
  begin
      if(isSigned = '1') then
        output <= std_logic_vector(resize(signed(input), 32));
      else
          output <= std_logic_vector(resize(unsigned(input), 32));
      end if;
  end process;

end sign;