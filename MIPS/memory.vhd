library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is 
    port (
        inport_en                       :   in std_logic;
        memread, memwrite               :   in std_logic;
        clk, rst                        :   in std_logic;
        inport                          :   in std_logic_vector(31 downto 0);
        switch10                        :   in std_logic;
        input                           :   in std_logic_vector(31 downto 0);
        address                         :   in std_logic_vector(31 downto 0);
        outPort                         :   out std_logic_vector(31 downto 0);
        outdata                          :   out std_logic_vector(31 downto 0)
    );
end memory;

architecture BHV of memory is
signal sel      :   std_logic_vector(1 downto 0); 
signal ram_out  :   std_logic_vector(31 downto 0);
signal port1_r_temp  :   std_logic_vector(31 downto 0);
signal port0_r_temp  :   std_logic_vector(31 downto 0);
signal port1_r  :   std_logic_vector(31 downto 0);
signal port0_r  :   std_logic_vector(31 downto 0);
signal mux1out  :   std_logic_vector(31 downto 0);
signal mux2in   :   std_logic_vector(31 downto 0);
signal mux2sel  :   std_logic;
signal w_en, out_en, r_en   :   std_logic;
signal enable_inport0 : std_logic;
signal enable_inport1 : std_logic;
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            port1_r <= (others => '0');
            port0_r <= (others => '0');
            mux2sel <= '0';
        elsif(rising_edge(clk)) then
            port1_r <= port1_r_temp;
            port0_r <= port0_r_temp;
            if((address = x"0000FFF8") or (address = x"0000FFFC")) then 
                mux2sel <= '1';
            else
                mux2sel <= '0';
            end if; 
        end if;
    end process;
    enable_inport0 <= inport_en and not(switch10);
    enable_inport1 <= inport_en and switch10;
    sel <= "00" when (address <= x"00002000")
                else "01" when address = x"0000FFF8"
                else "10" when address = x"0000FFFC"
                else "00";
    out_en <= '1' when (memwrite = '1' and address = x"0000FFFC" )
                else '0';
    w_en <= '1' when (memwrite = '1' and (address <= x"00002000") and memread = '0')
                else '0';
    
                
    SRAM : entity work.sram
    port map (
        address => address(9 downto 2),
        wren => w_en,
        data => input,
        clock => clk,
        q => ram_out
    );
    REG_IN_0 : entity work.reg_en
    generic map(WIDTH => 32)
    port map (
        clk => clk,
        rst => rst,
        enable => enable_inport0,
        input => inport,
        output => port0_r_temp
        );
    

    REG_IN_1 : entity work.reg_en
        generic map(WIDTH => 32)
        port map (
            clk => clk,
            rst => rst,
            enable => enable_inport1,
            input => inport,
            output => port1_r_temp
            );
    REG_OUT : entity work.reg_en
    generic map(WIDTH => 32)
        port map (
            clk => clk,
            rst => rst,
            enable => out_en,
            input => input,
            output => outPort
            );
    MUX : entity work.mux
    port map (
        in1 => ram_out,
        in2 => port0_r,
        in3 => port1_r,
        sel => sel,
        output => mux1out
    );
    REG_OUT_OUT : entity work.reg_en
        generic map (WIDTH => 32)
        port map (clk => clk,
        rst => rst,
        enable => '1',
        input => mux1out,
        output => mux2in
        );
    MUX_OUT : entity work.mux2x1
    port map (
        in1 => mux1out,
        in2 => mux2in,
        sel => mux2sel,
        output => outdata
    );
            
end BHV;