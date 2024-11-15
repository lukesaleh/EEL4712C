library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity vga_sync_gen is
    port (clk                      : in  std_logic;
          rst                      : in  std_logic;
          h_count, v_count         : out std_logic_vector(COUNT_RANGE);
          h_sync, v_sync, video_on : out std_logic);
end vga_sync_gen;

architecture BHV of vga_sync_gen is
    signal h_count_r : unsigned(h_count'range); 
    signal v_count_r : unsigned(v_count'range);
begin
    
    process (clk,rst)
    begin             
    if(rst = '1') then
        h_count_r <= (others => '0');
        v_count_r <= (others => '0');
        video_on <= '0';
        h_sync <= '0';
        v_sync <= '0';
    elsif(rising_edge(clk)) then
        h_count_r <= h_count_r + 1;
       
        if (h_count_r = to_unsigned(H_MAX,COUNT_WIDTH)) then
            h_count_r <= (others => '0');
        end if;
        if(h_count_r = to_unsigned(H_VERT_INC,COUNT_WIDTH)) then
            v_count_r <= v_count_r +1;
        end if;
        if (v_count_r = to_unsigned(V_MAX,COUNT_WIDTH)) then
            v_count_r <= (others => '0');
        end if;
        if((h_count_r <= to_unsigned(HSYNC_END, COUNT_WIDTH)) and (h_count_r >= to_unsigned(HSYNC_BEGIN,COUNT_WIDTH))) then
            h_sync <= '0';
        else 
            h_sync <= '1';
        end if;
        if((v_count_r <= to_unsigned(VSYNC_END, COUNT_WIDTH)) and (v_count_r >= to_unsigned(VSYNC_BEGIN, COUNT_WIDTH))) then
            v_sync <= '0';
        else 
            v_sync <= '1';
        end if;
        if((v_count_r <= to_unsigned(V_DISPLAY_END, COUNT_WIDTH)) and (h_count_r <= to_unsigned(H_DISPLAY_END, COUNT_WIDTH))) then
            video_on <= '1';
        else
            video_on <= '0';
        end if;
    end if;
    end process;
    h_count <= std_logic_vector(h_count_r);
    v_count <= std_logic_vector(v_count_r);
end BHV;
