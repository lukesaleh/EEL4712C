
library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
        clk50MHz         : in  std_logic;
        switch           : in  std_logic_vector(9 downto 0);
        button_n         : in  std_logic_vector(1 downto 0);
        led0             : out std_logic_vector(6 downto 0);
        led0_dp          : out std_logic;
        led1             : out std_logic_vector(6 downto 0);
        led1_dp          : out std_logic;
        led2             : out std_logic_vector(6 downto 0);
        led2_dp          : out std_logic;
        led3             : out std_logic_vector(6 downto 0);
        led3_dp          : out std_logic;
        led4             : out std_logic_vector(6 downto 0);
        led4_dp          : out std_logic;
        led5             : out std_logic_vector(6 downto 0);
        led5_dp          : out std_logic
        );
end top_level;

architecture STR of top_level is
    signal ireg_out     : std_logic_vector(5 downto 0);
    signal PCWriteCond, PCWrite, IorD, memRead, memWrite, memToReg, IRWrite, jumpAndLink, isSigned, ALUSrcA, RegWrite, RegDst : std_logic;
    signal LEDs     : std_logic_vector(31 downto 0);
    signal branchTaken : std_logic;
    signal rst : std_logic;
    signal ALUOP : std_logic_vector(5 downto 0);

    signal ALUSrcB, PCSource : std_logic_vector(1 downto 0);
    signal instRegLow5 : std_logic_vector(5 downto 0);
begin  -- STR

    
   U_DATAPATH : entity work.datapath generic map ( width => 32)
    port map (
        clk => clk50MHz,
        rst => not(button_n(1)),
        IorD => IorD,
        PCWriteCond => PCWriteCond,
        PCWrite => PCWrite,
        memWrite => memWrite,
        memRead => memRead,
        RegDst => RegDst,
        IRWrite => IRWrite, 
        RegWrite => RegWrite,
        ALUSrcA => ALUSrcA, 
        isSigned => isSigned,
        jumpAndLink => jumpAndLink,
        inport_en => not(button_n(0)), 
        switches => switch,
        LEDs => LEDs,
        ALUSrcB => ALUSrcB,
        PCSource => PCSource,
        branchTaken => branchTaken,
        ALUOP => ALUOP,
        memToReg => memToReg,
        instReg => ireg_out,
        instRegLow5 => instRegLow5
    );
    U_CONTROLLER: entity work.controller 
    port map (
        clk => clk50MHz,
        rst => not(button_n(1)),
        ireg_out => ireg_out,
        PCWriteCond => PCWriteCond,
        PCWrite => PCWrite,
        IorD => IorD,
        memRead => memRead,
        memWrite => memWrite,
        memToReg => memToReg,
        IRWrite => IRWrite,
        jumpAndLink => jumpAndLink,
        isSigned => isSigned,
        ALUSrcA => ALUSrcA,
        RegWrite => RegWrite,
        RegDst => RegDst,
        ALUSrcB => ALUSrcB, 
        PCSource => PCSource,
        ALUOP => ALUOP,
        ireg_out_low5 => instRegLow5
        );

    U_LED5 : entity work.decoder7seg port map (
        input  => LEDs(23 downto 20),
        output => led5);

    U_LED4 : entity work.decoder7seg port map (
        input  => LEDs(19 downto 16),
        output => led4);

    U_LED3 : entity work.decoder7seg port map (
        input  => LEDs(15 downto 12),
        output => led3);

    U_LED2 : entity work.decoder7seg port map (
        input  => LEDs(11 downto 8),
        output => led2);

    U_LED1 : entity work.decoder7seg port map (
        input  => LEDS(7 downto 4),
        output => led1);

    U_LED0 : entity work.decoder7seg port map (
        input  => LEDS(3 downto 0),
        output => led0);

    led5_dp <= '1';
    led4_dp <= '1';
    led3_dp <= '1';
    led2_dp <= '1';
    led1_dp <= '1';
    led0_dp <= '1';

end STR;
