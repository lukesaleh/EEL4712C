library ieee;
use ieee.std_logic_1164.all;

entity gray1 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end gray1;

architecture BHV of gray1 is
    type state_t (STATE_0, STATE_1, STATE_2, STATE_3, STATE_4, STATE_5, STATE_6, STATE_7, STATE_8, STATE_9, STATE_10, STATE_11, STATE_12, STATE_13, STATE_14, STATE_15);
    signal state_r : state_t;
begin
    process(clk, rst)
    begin
        if(rst = '1') then 
            state_r <= STATE_0;
            output <= "0000";
        elsif (rising_edge(clk)) then
            case (state_r) is 
                when STATE_0 =>
                    output <= "0000";
                when STATE_1 =>
                    output <= "0001";
                when STATE_2 =>
                    output <= "0011";
                when STATE_3 =>
                    output <= "0010";
                when STATE_4 =>
                    output <= "0110";
                when STATE_5 =>
                    output <= "0111";
                when STATE_6 =>
                    output <= "0101";
                when STATE_7 =>
                    output <= "0100";
                when STATE_8 =>
                    output <= "1100";
                when STATE_9 => 
                    output <= "1101";
                when STATE_10 =>
                    output <= "1111";
                when STATE_11 =>
                    output <= "1110";
                when STATE_12 =>
                    output <= "1010";
                when STATE_13 =>
                    output <= "1011";
                when STATE_14 =>
                    output <= "1001";
                when STATE_15 =>
                    output <= "1000";
            end case;
        end if;
    end process;

end BHV;