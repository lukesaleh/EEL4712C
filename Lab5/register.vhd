-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity reg_en is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    enable   : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end reg_en;


architecture BHV of reg_en is
begin
  process(clk, rst)
  begin
    if (rst = '1') then
      output   <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (enable = '1') then
        output <= input;
      end if;
    end if;
  end process;
end BHV;
