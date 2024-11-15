library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up_n   : in  std_logic;         -- Active low
        load_n : in  std_logic;         -- Active low
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0));
end counter;

architecture BHV of counter is
signal counter : std_logic_vector(3 downto 0);
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            counter <= "0000";
        elsif(rising_edge(clk)) then
            if (load_n = '0') then
                counter <= input;
            end if;
            if(up_n = '1') then
                if(counter = "0000") then
                    counter <= "1111";
                else
                    counter<= std_logic_vector(unsigned(counter) - 1);
                end if;
            elsif(up_n = '0') then
                if(counter = "1111") then
                    counter <= "0000";
                else
                    counter<= std_logic_vector(unsigned(counter) + 1);
                end if;
            end if;
        end if;
    end process;
    output <= counter;
end BHV;