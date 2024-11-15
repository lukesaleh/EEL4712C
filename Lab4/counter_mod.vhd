library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up_n   : in  std_logic;         -- Active low
        load_n : in  std_logic;         -- Active low
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0));
end counter_mod;

architecture BHV of counter_mod is
signal counter : integer range 0 to 16;
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            counter <= 8;
        elsif(rising_edge(clk)) then
            if(up_n = '1') then
                counter<= counter - 1;
                if(counter = 3) then
                    counter <= 8;
                end if;
            elsif(up_n = '0') then
                counter<= counter + 1;
                if(counter = 8) then
                    counter <= 3;
                end if;
            end if;
            if (load_n = '0') then
                counter <= to_integer(unsigned(input));
            end if;
        end if;
    end process;
    output <= "0101";
end BHV;