
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath2 is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    inputx  : in  std_logic_vector(width-1 downto 0);
    inputy  : in std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0);

    -- signals to/from controller

    x_sel  : in  std_logic;
    y_sel  : in  std_logic;
    x_en   : in  std_logic;
    y_en  : in  std_logic;
    output_en    : in  std_logic;
    x_lt_y  :   out std_logic;
    x_ne_y  :   out std_logic
    );
end datapath2;

architecture BHV of datapath2 is

  signal mux_x_out   : std_logic_vector(width-1 downto 0);
  signal sub_out  : std_logic_vector(width-1 downto 0);
  signal mux_y_out      : std_logic_vector(width-1 downto 0);
  signal reg_x_out  : std_logic_vector(width-1 downto 0);
  signal reg_y_out  : std_logic_vector(width-1 downto 0);
  signal mux_1_out : std_logic_vector(width-1 downto 0);
  signal mux_0_out : std_logic_vector(width-1 downto 0);
  signal lt     : std_logic;
  signal ne     : std_logic;

begin

  U_MUX_X : entity work.mux
    generic map (
      width  => width)
    port map (
      in1    => inputx,
      in2    => sub_out,
      sel    => x_sel,
      output => mux_x_out);

    U_MUX_Y : entity work.mux
      generic map (
        width  => width)
      port map (
        in1    => inputy,
        in2    => sub_out,
        sel    => y_sel,
        output => mux_y_out);

  U_REG_X : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk    => clk,
      rst    => rst,
      enable   => x_en,
      input  => mux_x_out,
      output => reg_x_out);
    
    U_REG_Y : entity work.reg_en
    generic map (
      width  => width)
      port map (
        clk    => clk,
        rst    => rst,
        enable   => y_en,
        input  => mux_y_out,
        output => reg_y_out);
    
    U_MUX_1 : entity work.mux
    generic map (
        width  => width)
      port map (
        in1    => reg_y_out,
        in2    => reg_x_out,
        sel    => lt,
        output => mux_1_out);
    U_MUX_0 : entity work.mux
    generic map (
            width  => width)
          port map (
            in1    => reg_x_out,
            in2    => reg_y_out,
            sel    => lt,
            output => mux_0_out);
    U_SUB : entity work.subtractor
    generic map (
        width  => width)
        port map (
            in1    => mux_1_out,
            in2    => mux_0_out,
            output => sub_out);
      
   
    U_REG_OUTPUT : entity work.reg_en
        generic map (
            width => width
        )
        port map (
            clk => clk,
            rst => rst,
            enable => output_en,
            input => reg_x_out,
            output => output
        );
    U_COMP  :   entity work.comparator
            generic map (
                width => width
            )
            port map (
                in1 => reg_x_out,
                in2 => reg_y_out,
                lt => lt,
                ne => ne
            );
    x_lt_y <= lt;
    x_ne_y <= ne;
end BHV;
