library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        milliseconds : positive);
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic);
end clk_gen;

architecture BHV of clk_gen is
    signal clk_1KHz : std_logic;
    signal counter : integer;
    signal tmp_sclk : std_logic;
begin
    CLK_DIV : entity work.clk_div
    generic map (clk_in_freq=> 50000000, 
        clk_out_freq=>1000) 
        port map(
        clk_in => clk50MHz,
        rst => rst,
        clk_out => clk_1KHz
    );
    process(clk_1KHz, rst)
    begin 
        if (rst = '1') then
            counter <= 0;
            tmp_sclk <= '0';
        elsif(rising_edge(clk_1KHz)) then
            if(button_n = '0') then
                counter <= counter + 1;
                if(counter = milliseconds) then
                    counter<=0;
                    tmp_sclk <= '1';
                    
                end if;
            else
                counter <= 0;
                tmp_sclk <= '0';
            end if;
         end if;
    end process; 
    clk_out<= tmp_sclk;
end BHV;