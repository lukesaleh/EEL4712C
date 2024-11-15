library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;
entity datapath is
    generic(
        WIDTH : positive := 32);
    port(
        clk           : in  std_logic;
        rst           : in  std_logic;
        IorD, PCWriteCond, memWrite, memToReg, IRWrite, memRead, PCWrite  : in std_logic;
        
        RegDst, RegWrite, ALUSrcA, isSigned, jumpAndLink  : in std_logic;
        inport_en       : in  std_logic;
        switches      : in  std_logic_vector(9 downto 0);
        LEDs          : out std_logic_vector(width-1 downto 0);
	    ALUSrcB, PCsource : in std_logic_vector(1 downto 0);
        branchTaken   : out std_logic;
        ALUOP         : in std_logic_vector(5 downto 0);
        instReg       : out std_logic_vector(5 downto 0);
        instRegLow5   : out std_logic_vector(5 downto 0)
        );
end datapath;

architecture BHV of datapath is
    signal PC_out, ALU_out, muxpc_out, mux3_out, rd_data0, rd_data1, A_out, B_out, signExt_out, ALU_res, shifted_out : std_logic_vector(width-1 downto 0);
    signal inport, mdata, mreg_out, mux_out, ireg_out, mem_out, muxA_out, muxB_out, concat_out : std_logic_vector(width-1 downto 0);
    signal branch_Taken : std_logic;
    signal PCWrite_en : std_logic;
    signal reg_en, LO_en, HI_en: std_logic;       
    signal shift28_out: std_logic_vector(width-1-4 downto 0);
    signal res_hi, low_out, hi_out : std_logic_vector(width-1 downto 0);
    signal ALU_LO_HI: std_logic_vector(1 downto 0);
    signal op_select: ALU_OP_t;
    signal reg_ALU_en : std_logic;
	 signal iregmux_out: std_logic_vector(4 downto 0);
begin
  PCwrite_en <= (PCWriteCond and branch_Taken) or PCWrite;
  reg_en <= '1';
  reg_ALU_en <= '0' when ((op_select = NULLS) or (op_select = JAL)) 
  else  '1';
  shift28_out <= std_logic_vector(shift_left(resize(unsigned(ireg_out(25 downto 0)), 28), 2));
  instReg <= ireg_out(31 downto 26);
  instRegLow5 <= ireg_out(5 downto 0);
  branchTaken <= branch_Taken;
    U_ALU: entity work.alu
        port map(
        inputA => muxA_out, 
        inputB  => muxB_out,    
        shift => ireg_out(10 downto 6),    
        op_select => op_select,
        branch_taken => branch_Taken,
        result => ALU_res, 
        result_hi => res_hi
            );
        U_ALUCONTROL: entity work.ALUcontrol
        port map(
        instReg => ireg_out(5 downto 0), 
        instReg2016 => ireg_out(20 downto 16),
        ALUop  => ALUop,    
        ALU_LO_HI => ALU_LO_HI,
        LO_en => LO_en,     
        HI_en => HI_en,     
        op_select => op_select
        );
    U_MEM: entity work.memory
    port map(
        address => muxpc_out,
        input => B_out,
        inport => inPort,
        clk => clk,
        rst => rst,	
        switch10 => switches(9),
        memwrite => memWrite,
        memread => memRead,
        inport_en => inport_en,
        outport => LEDs,
        outdata => mem_out
    );
    U_REG_MEMDATA : entity work.reg_en
    generic map (
        width  => width)
    port map (
        clk   => clk,
        rst   => rst,
        input => mem_out,
        enable    => reg_en,
        output => mdata);

    U_REG_PC : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,
      input    => mux3_out,
      enable    => PCWrite_en,
      output => PC_out);
    
    U_MUX_PC: entity work.mux2x1
    generic map (
      width  => width)
    port map (
      in1    => PC_out,
      in2    => ALU_out,
      sel    => IorD,
      output => muxpc_out);

    U_ZERO_EXTEND: entity work.zeroextend
    generic map (
      width  => width)
    port map(
        input => switches(8 downto 0),
        output => inPort);
    
    U_REG_INSTRUCTION_REGISTER : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,
      input    => mem_out,
      enable    => IRWrite,
      output => ireg_out);

    U_MUX_MEM_REG: entity work.mux2x1
    generic map (
      width  => width)
    port map (
      in1    => mux_out,
      in2    => mdata,
      sel    => memToReg,
      output => mreg_out);

    U_MUX_INSTRUCT_REG: entity work.mux2x1
    generic map (
      width  => 5)
    port map (
      in1    => ireg_out(20 downto 16),
      in2    => ireg_out(15 downto 11),
      sel    => RegDst,
      output => iregmux_out);


    U_REG_FILE: entity work.regFile
    generic map(
      width => width)
    port map(
        clk => clk,
        rst => rst,
        rd_addr0 => ireg_out(25 downto 21),
        rd_addr1 => ireg_out(20 downto 16),
        wr_addr => iregmux_out,
        regWrite => regWrite,
        jumpAndLink => jumpAndLink, 
        wr_data => mreg_out,
        rd_data0 => rd_data0,
        rd_data1 => rd_data1
      );

    U_SIGNEXT: entity work.signExtend
    generic map (
      width  => width)
    port map(
        input => ireg_out(15 downto 0),
        isSigned => isSigned,
        output => signExt_out
        );
    
    U_REG_A : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,      
      input    => rd_data0,
      enable    => reg_en,
      output => A_out);

    U_REG_B : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,      
      input    => rd_data1,
      enable    => reg_en,
      output => B_out);


    U_SHIFT2: entity work.shiftLeft2
    generic map (
      width  => width)
    port map(
        input => signExt_out,
        output => shifted_out
        );

    U_MUX_ALU_A: entity work.mux2x1
    generic map (
      width  => width)
    port map (
      in1    => PC_out,
      in2    => A_out,
      sel    => ALUSrcA,
      output => muxA_out
      );

    U_MUX_ALU_B: entity work.mux4x1
    generic map (
      width  => width)
    port map (
      in1    => B_out,
      in2    => (2 => '1', others => '0'),   
      in3    =>  signExt_out,
      in4    => shifted_out,
      sel    => ALUSrcB,
      output => muxB_out
      );


    U_REG_LO : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,
      input    => ALU_res,
      enable    => LO_en,
      output => low_out);

    U_REG_HI : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,
      input    => res_hi,
      enable    => HI_en,
      output => hi_out);

    U_REG_ALUOUT : entity work.reg_en
    generic map (
      width  => width)
    port map (
      clk   => clk,
      rst   => rst,
      input    => ALU_res,
      enable    => reg_ALU_en,
      output => ALU_out);

    U_MUX_OUT: entity work.mux
    port map (
      in1    => ALU_out,
      in2    => low_out,
      in3    => hi_out,
      sel    => ALU_LO_HI,
      output => mux_out);

    U_CONCAT: entity work.concat
    generic map(
      width => width
    )
    port map(
      in1 => PC_out(31 downto 28),
      in2 => shift28_out,
      output => concat_out
    );

    U_MUX3: entity work.mux
    port map (
      in1    => ALU_res,
      in2    => ALU_out,
      in3    => concat_out,
      sel    => PCsource,
      output => mux3_out);
end BHV;