library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;
entity controller_tb is 

end controller_tb;

architecture TB of controller_tb is 
signal clk     : std_logic := '0';
signal rst     : std_logic;
signal ireg_out     : std_logic_vector(5 downto 0);
signal PCWriteCond, PCWrite, IorD, memRead, memWrite, memToReg, IRWrite, jumpAndLink, isSigned, ALUSrcA, RegWrite, RegDst : std_logic;

signal ALUSrcB, PCSource : std_logic_vector(1 downto 0);
signal ALUOP : std_logic_vector(5 downto 0);
signal button : std_logic;
signal switches : std_logic_vector(9 downto 0);
signal LEDs     : std_logic_vector(31 downto 0);
signal branchTaken : std_logic;
signal instRegLow5 : std_logic_vector(5 downto 0);
begin
    process 
    begin
    rst <= '1'; 
    wait for 15 ns;
    rst <= '0';
    button <= '1';
    switches <= "0111111111";
    wait for 10 ns;
    wait;
    end process;
    clk <= not clk after 5 ns;
    
    
    U_DATAPATH: entity work.datapath
    generic map ( width => 32)
    port map (
        clk => clk,
        rst => rst,
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
        inport_en => button, 
        switches => switches,
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
        clk => clk,
        rst => rst,
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
end TB;