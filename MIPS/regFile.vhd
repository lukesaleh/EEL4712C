library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regFile is
    generic (
    width  :     positive := 32);
    port(
        clk : in std_logic;
        rst : in std_logic;
        rd_addr0 : in std_logic_vector(4 downto 0);
        rd_addr1 : in std_logic_vector(4 downto 0);
        wr_addr : in std_logic_vector(4 downto 0);
        regWrite : in std_logic;
        jumpAndLink : in std_logic;                
        wr_data : in std_logic_vector(width-1 downto 0);
        rd_data0 : out std_logic_vector(width-1 downto 0);
        rd_data1 : out std_logic_vector(width-1 downto 0)
        );
end regFile;

architecture BHV of regFile is    
    type reg_array is array(0 to 31) of std_logic_vector(width-1 downto 0);
    signal registers : reg_array;                   
begin
    process(clk, rst) is 
    begin
        if(rst = '1') then
            for i in registers'range loop
                registers(i) <= (others => '0');
            end loop; 
        elsif(rising_edge(clk)) then
            if(regWrite = '1') then
                if(jumpAndLink = '1') then 
                    registers(31) <= wr_data;
                elsif(unsigned(wr_addr) /= 0) then
                    registers(to_integer(unsigned(wr_addr))) <= wr_data;
                end if;
            end if;
        end if;
    end process;
    rd_data0 <= registers(to_integer(unsigned(rd_addr0)));
    rd_data1 <= registers(to_integer(unsigned(rd_addr1)));

end BHV;

