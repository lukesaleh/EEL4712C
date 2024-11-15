library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity rowaddress is 
    port(
        img_pos     : in std_logic_vector(2 downto 0);
        h_count     : in std_logic_vector(COUNT_WIDTH-1 downto 0);
        enable      : out std_logic;
        address     : out std_logic_vector(6 downto 0)
    );
end rowaddress;

architecture BHV of rowaddress is 
signal hcount : unsigned(h_count'range);
signal row_start : unsigned (9 downto 0);
signal row_end : unsigned (9 downto 0);
signal addr : unsigned(9 downto 0);
begin
    process(img_pos, h_count)
    begin
        hcount <= unsigned(h_count);
        case(img_pos) is 
                when "000" =>
                    row_start <= to_unsigned(CENTERED_X_START, COUNT_WIDTH);
                    row_end <= to_unsigned(CENTERED_X_END, COUNT_WIDTH);
                   
                when "001" =>
                    row_start <= to_unsigned(TOP_LEFT_X_START, COUNT_WIDTH);
                    row_end <= to_unsigned(TOP_LEFT_X_END, COUNT_WIDTH);
                    
                when "010" =>
                    row_start <= to_unsigned(TOP_RIGHT_X_START, COUNT_WIDTH);
                    row_end <= to_unsigned(TOP_RIGHT_X_END, COUNT_WIDTH);
                    
                when "011" =>
                    row_start <= to_unsigned(BOTTOM_LEFT_X_START, COUNT_WIDTH);
                    row_end <= to_unsigned(BOTTOM_LEFT_X_END, COUNT_WIDTH);
                    
                when "100" =>
                    row_start <= to_unsigned(BOTTOM_RIGHT_X_START, COUNT_WIDTH);
                    row_end <= to_unsigned(BOTTOM_RIGHT_X_END, COUNT_WIDTH);
                when others => 
                    null;
                end case; 
            
            addr <= (hcount-row_start);
               
    end process;

    enable <= '1' when ((hcount <= row_end) and (hcount >= row_start)) else '0';
    
    address <= std_logic_vector(addr(6 downto 0)) when ((hcount <= row_end) and (hcount >= row_start)) else (others => '0'); 
end BHV;