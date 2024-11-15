-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb_individual is
end adder_tb_individual;


architecture TB of adder_tb_individual is

    constant TEST_WIDTH : positive := 8;

    signal x, y      : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal carry_in  : std_logic;
    signal s         : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal carry_out : std_logic;

begin  -- TB

    -- TODO: Change the architecture name to test different architectures.
    UUT : entity work.adder(CARRY_LOOKAHEAD)
        generic map (
            WIDTH => TEST_WIDTH)
        port map (
            x         => x,
            y         => y,
            carry_in  => carry_in,
            s         => s,
            carry_out => carry_out);

    process
        variable errors          : integer;
        variable result_tmp        : unsigned(TEST_WIDTH downto 0);
        variable correct_result    : std_logic_vector(TEST_WIDTH-1 downto 0);
        variable correct_carry_out : std_logic;

    begin

        errors := 0;

        for i in 0 to 2**TEST_WIDTH-1 loop

            x <= std_logic_vector(to_unsigned(i, TEST_WIDTH));

            for j in 0 to 2**TEST_WIDTH-1 loop

                y <= std_logic_vector(to_unsigned(j, TEST_WIDTH));

                for k in 0 to 1 loop

                    carry_in <= std_logic(to_unsigned(k, 1)(0));

                    wait for 10 ns;

                    result_tmp        := unsigned("0"&x) + unsigned("0"&y) + to_unsigned(k, 1);
                    correct_result    := std_logic_vector(result_tmp(TEST_WIDTH-1 downto 0));
                    correct_carry_out := std_logic(result_tmp(TEST_WIDTH));

                    if (s /= correct_result) then
                        errors := errors + 1;
                        report "Error : " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s))) severity warning;
                    end if;
                    if (carry_out /= correct_carry_out) then
                        errors := errors + 1;
                        report "Error : Carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(carry_out) severity warning;
                    end if;

                end loop;  -- k
            end loop;  -- j      
        end loop;  -- i


        report "Total errors : " & integer'image(errors);
        wait;
    end process;
end TB;