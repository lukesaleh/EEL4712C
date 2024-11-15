library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity coladdress is 
    port(
        img_pos     : in std_logic_vector(2 downto 0);
        v_count     : in std_logic_vector(COUNT_WIDTH-1 downto 0);
        enable      : out std_logic;
        address     : out std_logic_vector(6 downto 0)
    );
end coladdress;

architecture BHV of coladdress is 
signal vcount : unsigned(v_count'range);
signal col_start : unsigned (9 downto 0);
signal col_end : unsigned (9 downto 0);
signal addr : unsigned(9 downto 0);
begin
    process(img_pos, v_count)
    begin
        vcount <= unsigned(v_count);
    
        case(img_pos) is 
                when "000" =>
                    col_start <= to_unsigned(CENTERED_Y_START, COUNT_WIDTH);
                    col_end <= to_unsigned(CENTERED_Y_END, COUNT_WIDTH);
                   
                when "001" =>
                    col_start <= to_unsigned(TOP_LEFT_Y_START, COUNT_WIDTH);
                    col_end <= to_unsigned(TOP_LEFT_Y_END, COUNT_WIDTH);
                    
                when "010" =>
                    col_start <= to_unsigned(TOP_RIGHT_Y_START, COUNT_WIDTH);
                    col_end <= to_unsigned(TOP_RIGHT_Y_END, COUNT_WIDTH);
                    
                when "011" =>
                    col_start <= to_unsigned(BOTTOM_LEFT_Y_START, COUNT_WIDTH);
                    col_end <= to_unsigned(BOTTOM_LEFT_Y_END, COUNT_WIDTH);
                    
                when "100" =>
                    col_start <= to_unsigned(BOTTOM_RIGHT_Y_START, COUNT_WIDTH);
                    col_end <= to_unsigned(BOTTOM_RIGHT_Y_END, COUNT_WIDTH);
                when others => 
                    null;
                end case; 
            addr <= (vcount-col_start);
           
               
    end process;
    enable <= '1' when ((vcount <= col_end) and (vcount >= col_start)) else '0';
    address <= std_logic_vector(addr(6 downto 0)) when ((vcount <= col_end) and (vcount >= col_start)) else (others => '0'); 
end BHV;