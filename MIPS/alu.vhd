library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;
entity alu is 
    port ( 
        shift       :       in std_logic_vector(4 downto 0);
        inputA      :       in std_logic_vector(31 downto 0);
        inputB      :       in std_logic_vector(31 downto 0);
        op_select   :       in ALU_OP_t;
        branch_taken :      out std_logic;
        result      :       out std_logic_vector(31 downto 0);
        result_hi   :       out std_logic_vector(31 downto 0)
    );
    end alu;

architecture BHV of alu is
signal mult_unsigned_temp : unsigned(63 downto 0);
signal mult_signed_temp : signed(63 downto 0);
signal temp_result : std_logic_vector(31 downto 0);
signal temp_result_hi : std_logic_vector(31 downto 0);
signal branch_temp : std_logic;
begin
    process(op_select, inputA, inputB, shift, mult_unsigned_temp, mult_signed_temp) 
        
    begin 
        branch_temp <= '0';
        temp_result <= (others => '0');
        temp_result_hi <= (others => '0');
        mult_unsigned_temp <= (others => '0');
        mult_signed_temp <= (others => '0');
        case(op_select) is 
            when NULLS =>
                branch_temp <= '0';
                temp_result <= (others => '0');
                temp_result_hi <= (others => '0');
                mult_unsigned_temp <= (others => '0');
                mult_signed_temp <= (others => '0');
            when ADD =>
                temp_result <= std_logic_vector(unsigned(inputA) + unsigned(inputB));
            when SUB =>
                temp_result <= std_logic_vector(unsigned(inputA) - unsigned(inputB));
            when MULT_S =>
                mult_signed_temp <= signed(inputA) * signed(inputB);
                temp_result <= std_logic_vector(mult_signed_temp(31 downto 0));
                temp_result_hi <= std_logic_vector(mult_signed_temp(63 downto 32));
            when MULT =>
                mult_unsigned_temp  <= (unsigned(inputA) * unsigned(inputB));
                temp_result <= std_logic_vector(mult_unsigned_temp(31 downto 0));
                temp_result_hi <= std_logic_vector(mult_unsigned_temp(63 downto 32));
            when AND_OP => 
                temp_result <= std_logic_vector(unsigned(inputA) and unsigned(inputB));
            when OR_OP =>
                temp_result <= std_logic_vector(unsigned(inputA) or unsigned(inputB));
            when XOR_OP =>
                temp_result <= std_logic_vector(unsigned(inputA) xor unsigned(inputB));
            when LSR =>
                temp_result <= std_logic_vector(shift_right(unsigned(inputB), to_integer(unsigned(shift))));
            when LSL =>
                
                temp_result <= std_logic_vector(shift_left(unsigned(inputB), to_integer(unsigned(shift))));
            when ASR =>
                temp_result <= std_logic_vector(shift_right(signed(inputB), to_integer(unsigned(shift))));
            when SLTS =>
                if(unsigned(inputA) < unsigned(inputB)) then
                    temp_result <= std_logic_vector(to_unsigned(1, temp_result'length));
                else
                    temp_result <= (others => '0');
                end if;
            when SLTU =>
                if(unsigned(inputA) < unsigned(inputB)) then
                    temp_result <= std_logic_vector(to_unsigned(1, temp_result'length));
                else
                    temp_result <= (others => '0');
                end if;
            when BEQ =>
                if(unsigned(inputA) = unsigned(inputB)) then
                    branch_temp <= '1';
                else
                    branch_temp <= '0';
                end if;
            when BNE =>
                if(unsigned(inputA) /= unsigned(inputB)) then
                    branch_temp <= '1';
                else
                    branch_temp <= '0';
                end if;
            when BLEZ => 
                if(signed(inputA) <= 0) then
                    branch_temp <= '1';
                else
                    branch_temp <= '0';
                end if;
            when BGTZ =>
                if (signed(inputA) > 0) then
                    branch_temp <= '1';
                else
                    branch_temp <= '0';
                end if;
            when BLTZ =>
                if(signed(inputA) < 0) then
                    branch_temp <= '1';
                else
                    branch_temp <= '0';
                end if;
            when BGEZ =>
                if(signed(inputA) >= 0) then
                    branch_temp <= '1';
                else 
                    branch_temp <= '0';
                end if;
            when MFHI =>
                null;
            when MFLO =>
                null;
            when J =>
                null;
            when JAL =>
                null;
        end case;
    end process;
    result <= temp_result;
    result_hi <= temp_result_hi;
    branch_taken <= branch_temp;

end BHV;