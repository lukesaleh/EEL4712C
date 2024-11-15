library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity vga is
    port (clk              : in  std_logic;
          rst              : in  std_logic;
          img_pos          : in  std_logic_vector(2 downto 0);
          red, green, blue : out std_logic_vector(3 downto 0);
          h_sync, v_sync   : out std_logic;
          video_on         : out std_logic);
end vga;

architecture default_arch of vga is
    signal v_on : std_logic;
    signal hsync, vsync : std_logic;
    signal hcount, vcount : std_logic_vector(COUNT_RANGE);
    signal clk_25 : std_logic;
    signal column : std_logic_vector(6 downto 0);
    signal row : std_logic_vector(6 downto 0);
    signal address : std_logic_vector(13 downto 0);
    signal q : std_logic_vector(11 downto 0);
    
    signal row_en : std_logic;
    signal column_en : std_logic;
    signal en_condition : std_logic;
begin  -- STR
U_VGA_SYNC_GEN : entity work.vga_sync_gen
port map (clk => clk,
    rst => rst,
    h_count => hcount,
    v_count => vcount,
    h_sync => hsync,
    v_sync => vsync,
    video_on => v_on);
U_ROM : entity work.vga_rom port map (
    clock => clk,
    address => address,
    q => q
);
U_ROW_LOGIC : entity work.rowaddress
port map (
    img_pos => img_pos,
    h_count => hcount,
    enable => row_en,
    address => row
);

U_COL_LOGIC : entity work.coladdress
port map (
    img_pos => img_pos,
    v_count => vcount,
    enable => column_en,
    address => column
);

address <= column & row;
en_condition <= row_en and column_en and v_on;
red <= q(11 downto 8) when (en_condition = '1') else (others => '0');
green <= q(7 downto 4) when (en_condition = '1') else (others => '0');
blue <= q(3 downto 0) when (en_condition = '1') else (others => '0');
h_sync <= hsync;
v_sync <= vsync;
video_on <= v_on;

end default_arch;
