library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcd is
    generic (WIDTH : positive := 16);
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        go     : in  std_logic;
        x      : in  std_logic_vector(WIDTH-1 downto 0);
        y      : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0);
		done   : out std_logic
	);
end gcd;

architecture FSMD of gcd is
type state_t is (START, INIT, LOOP_COND, LOOP_BODY, S_DONE, RESTART);
signal state_r : state_t;

signal x_r  :   unsigned(WIDTH-1 downto 0);
signal y_r  :   unsigned(WIDTH-1 downto 0);
signal output_r : unsigned(WIDTH-1 downto 0);
signal done_r   :   std_logic;

begin  -- FSMD
process(clk, rst)
    begin
        if (rst = '1') then
            state_r <= START;
            done_r <= '0';
            x_r <= (others => '0');
            y_r <= (others => '0');
            output_r <= (others => '0');
        elsif(rising_edge(clk)) then
            done_r <= '0';
            case(state_r) is 
                when START =>
                    done_r <= '0';
                    if (go = '1') then
                        state_r <= INIT;
                    end if;

                when INIT =>
                    x_r <= unsigned(x);
                    y_r <= unsigned(y);
                    state_r <= LOOP_COND;
                when LOOP_COND =>
                    if(x_r /= y_r) then
                        state_r <= LOOP_BODY;
                    else
                        state_r <= S_DONE;
                    end if;
                when LOOP_BODY =>
                    if(x_r < y_r) then
                        y_r <= y_r - x_r;
                    else
                        x_r <= x_r - y_r;
                    end if;
                    state_r <= LOOP_COND;
                when S_DONE => 
                   output_r <= x_r;
                   done_r <= '1';
                   state_r <= RESTART; 
                when RESTART =>
                    if (go = '0') then
                        state_r <= START;
                    end if;
            end case;
        end if;
    end process;
    done <= done_r;
    output <= std_logic_vector(output_r);
end FSMD;

architecture FSM_PLUS_D1 of gcd is
signal x_sel, y_sel, x_en, y_en, output_en : std_logic;
signal x_lt_y, x_ne_y : std_logic;
begin  -- FSM_PLUS_D1

U_DATAPATH : entity work.datapath
generic map (width => width)
    port map (clk => clk,
        rst => rst, 
        inputx => x,
        inputy => y,
        x_sel => x_sel,
        y_sel => y_sel,
        y_en => y_en,
        x_en => x_en,
        output_en => output_en,
        x_lt_y => x_lt_y,
        x_ne_y => x_ne_y,
        output => output);
U_CONTROL : entity work.control1
port map(clk => clk,
    rst => rst,
    go => go,
    x_sel => x_sel,
    y_sel => y_sel,
    x_en => x_en,
    y_en => y_en,
    output_en => output_en,
    x_lt_y => x_lt_y,
    x_ne_y => x_ne_y,
    done => done);
end FSM_PLUS_D1;

architecture FSM_PLUS_D2 of gcd is
    signal x_sel, y_sel, x_en, y_en, output_en : std_logic;
    signal x_lt_y, x_ne_y : std_logic;
begin  -- FSM_PLUS_D2

    U_DATAPATH : entity work.datapath2
generic map (width => width)
    port map (clk => clk,
        rst => rst, 
        inputx => x,
        inputy => y,
        x_sel => x_sel,
        y_sel => y_sel,
        y_en => y_en,
        x_en => x_en,
        output_en => output_en,
        x_lt_y => x_lt_y,
        x_ne_y => x_ne_y,
        output => output);
U_CONTROL : entity work.control2
port map(clk => clk,
    rst => rst,
    go => go,
    x_sel => x_sel,
    y_sel => y_sel,
    x_en => x_en,
    y_en => y_en,
    output_en => output_en,
    x_lt_y => x_lt_y,
    x_ne_y => x_ne_y,
    done => done);


end FSM_PLUS_D2;


-- EXTRA CREDIT
architecture FSMD2 of gcd is
    type state_t is (START, INIT, LOOP_COND, LOOP_BODY, S_DONE, RESTART);
    signal state_r, next_state : state_t;
    signal x_r, y_r : unsigned(WIDTH-1 downto 0);
    signal x_next, y_next : unsigned(WIDTH-1 downto 0);
    
    begin  -- FSMD2
        process(clk, rst)
            begin
                if (rst = '1') then
                    state_r <= START;
                    x_r <= (others => '0');
                    y_r <= (others => '0');
                elsif(rising_edge(clk)) then
                    state_r <= next_state;
                    x_r <= x_next;
                    y_r <= y_next;
                end if;
            end process;
        process(state_r, go, x_r, y_r, x, y)
            
        begin 
            next_state <= state_r;
            x_next <= x_r;
            y_next <= y_r;
            done <= '0';
            output <= (others => '0'); 
                case(state_r) is 
                    when START =>
                        done <= '0';
                        x_next <= (others => '0');
                        y_next <= (others => '0');
                        if (go = '1') then
                            next_state <= INIT;
                        end if;
                    when INIT =>
                        x_next <= unsigned(x);
                        y_next <= unsigned(y);
                        next_state <= LOOP_COND;
                    when LOOP_COND =>
                        
                        if(x_r /= y_r) then
                            next_state <= LOOP_BODY;
                        else
                           
                            next_state <= S_DONE;
                        end if;
                    when LOOP_BODY =>
                        
                        if(x_r < y_r) then
                            y_next <= y_r - x_r;
                        else
                            x_next <= x_r - y_r;
                            
                        end if;
                        next_state <= LOOP_COND;
                    when S_DONE => 
                   
                       output <= std_logic_vector(x_r);
                       
                       next_state <= RESTART; 
                    when RESTART =>
                    
                        output <= std_logic_vector(x_r);
                       
                        done <= '1';
                        if (go = '0') then
                            next_state <= START;
                        end if;
                end case;
            end process;
    end FSMD2;