library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control1 is
  port (
    clk, rst, go    : in  std_logic;
    x_sel, y_sel, x_en, y_en, output_en : out std_logic;
    x_lt_y, x_ne_y  : in std_logic;
    done : out std_logic);
end control1;

architecture BHV of control1 is 
    type state_t is (START, LOOP_COND, LOOP_BODY, S_DONE); 
    signal state, next_state : state_t;
begin
    process(clk, rst) 
    begin
        if(rst = '1') then
            state <= START;
        elsif(rising_edge(clk)) then
            state <= next_state;
        end if;
    end process;
    process(state, go, x_lt_y, x_ne_y)
    begin
        next_state <= state;
        done <= '0';
        x_sel <= '0';
        y_sel <= '0';
        x_en <= '0';
        y_en <= '0';
        output_en <= '0';
        case(state) is
            when START =>
                done <= '0';
                x_sel <= '1';
                y_sel <= '1';
                x_en <= '1';
                y_en <= '1';
                output_en <= '0';
                if(go = '1') then
                    next_state <= LOOP_COND;
                end if;
            when LOOP_COND =>
                if(x_ne_y = '1') then
                    next_state <= LOOP_BODY;
                else
                    output_en <= '1';
                    next_state <= S_DONE;
                end if;
            when LOOP_BODY =>
                if(x_lt_y = '1') then
                    y_sel <= '0';
                    y_en <= '1';
                    x_sel <= '0';
                    x_en <= '0';
                else
                    y_sel <= '0';
                    y_en <= '0';
                    x_sel <= '0';
                    x_en <= '1';
                end if;
                next_state <= LOOP_COND;
            when S_DONE =>
                done <= '1';
                if (go = '0') then
                    next_state <= START;
                end if;
        end case;
    end process;
end BHV;
