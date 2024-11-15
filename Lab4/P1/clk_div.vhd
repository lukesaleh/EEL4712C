library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(clk_in_freq  : natural;  -- Input clock frequency
            clk_out_freq : natural); -- Output clock frequency
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic);
end clk_div;

architecture BHV of clk_div is
        signal tmp_sclk : std_logic;
        signal counter : integer;
        
begin
        process(clk_in, rst)      
        begin
                if(rst = '1') then
                        tmp_sclk <= '0';
                        counter <= 0;
                elsif(rising_edge(clk_in)) then
                        if(counter >= ((clk_in_freq/clk_out_freq)-1)/2) then
                                tmp_sclk <= not tmp_sclk;
                                counter <= 0;
                        else
                                counter <= counter+1;
                        end if;
                end if;
        end process;
        clk_out <= tmp_sclk;
end BHV;