library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_ns_tb is
end alu_ns_tb;

architecture TB of alu_ns_tb is

    constant WIDTH  : positive                           := 8;
    signal input1   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sel      : std_logic_vector(3 downto 0)       := (others => '0');
    signal output   : std_logic_vector(WIDTH-1 downto 0);
    signal overflow : std_logic;

begin  -- TB

    UUT : entity work.alu_ns
        generic map (WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            sel      => sel,
            output   => output,
            overflow => overflow);

    process
    begin

        -- test 2+6 (no overflow)
        sel    <= "0000";
        input1 <= std_logic_vector(to_unsigned(2, input1'length));
        input2 <= std_logic_vector(to_unsigned(6, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(8, output'length))) report "Error : 2+6 = " & integer'image(to_integer(unsigned(output))) & " instead of 8" severity warning;
        assert(overflow = '0') report "Error                                   : overflow incorrect for 2+8" severity warning;

        -- test 250+50 (with overflow)
        sel    <= "0000";
        input1 <= std_logic_vector(to_unsigned(250, input1'length));
        input2 <= std_logic_vector(to_unsigned(50, input2'length));
        wait for 40 ns;
		-- Truncated output for 300 is 44.
		-- You can put 300 in the to_unsigned call, but you will receive a simulation warning about a truncated value.
        assert(output = std_logic_vector(to_unsigned(44, output'length))) report "Error : 250+50 = " & integer'image(to_integer(unsigned(output))) & " instead of 44" severity warning;
        assert(overflow = '1') report "Error                                     : overflow incorrect for 250+50" severity warning;

        -- test 5*6
        sel    <= "0010";
        input1 <= std_logic_vector(to_unsigned(5, input1'length));
        input2 <= std_logic_vector(to_unsigned(6, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(30, output'length))) report "Error : 5*6 = " & integer'image(to_integer(unsigned(output))) & " instead of 30" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5*6" severity warning;

        -- test 64*64
        sel    <= "0010";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(64, input2'length));
        wait for 40 ns;
		-- Truncated output for 4096 is 0.
		-- You can put 4096 in the to_unsigned call, but you will receive a simulation warning about a truncated value.
        assert(output = std_logic_vector(to_unsigned(0, output'length))) report "Error : 64*64 = " & integer'image(to_integer(unsigned(output))) & " instead of 0" severity warning;
        assert(overflow = '1') report "Error                                      : overflow incorrect for 64*64" severity warning;


        -- add many more tests
 	sel    <= "0001";
        input1 <= std_logic_vector(to_unsigned(34, input1'length));
        input2 <= std_logic_vector(to_unsigned(30, input2'length));
        wait for 40 ns;
		
        assert(output = std_logic_vector(to_unsigned(4, output'length))) report "Error : 34-30 = " & integer'image(to_integer(unsigned(output))) & " instead of 4" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 34-30" severity warning;


	sel    <= "0011";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(64, output'length))) report "Error : 64AND65 = " & integer'image(to_integer(unsigned(output))) & " instead of 64" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64AND65" severity warning;

	sel    <= "0100";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(65, output'length))) report "Error : 64OR65 = " & integer'image(to_integer(unsigned(output))) & " instead of 65" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64OR65" severity warning;


	sel    <= "0101";
        input1 <= std_logic_vector(to_unsigned(65, input1'length));
        input2 <= std_logic_vector(to_unsigned(33, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(96, output'length))) report "Error : 65XOR33 = " & integer'image(to_integer(unsigned(output))) & " instead of 96" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 65XOR33" severity warning;


	sel    <= "0110";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(190, output'length))) report "Error : 64NOR65 = " & integer'image(to_integer(unsigned(output))) & " instead of 190" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64NOR65" severity warning;

	sel    <= "0111";
        input1 <= std_logic_vector(to_unsigned(128, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(127, output'length))) report "Error : NOT64 = " & integer'image(to_integer(unsigned(output))) & " instead of 127" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64NOR65" severity warning;



	sel    <= "1000";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(128, output'length))) report "Error : 64 left shifted = " & integer'image(to_integer(unsigned(output))) & " instead of 128" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64 left shifted" severity warning;

        sel    <= "1000";
        input1 <= std_logic_vector(to_unsigned(128, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(0, output'length))) report "Error : 128 left shifted = " & integer'image(to_integer(unsigned(output))) & " instead of 0" severity warning;
        assert(overflow = '1') report "Error                                      : overflow incorrect for 128 left shifted" severity warning;

	sel    <= "1001";
        input1 <= std_logic_vector(to_unsigned(64, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(32, output'length))) report "Error : 64 right shifted = " & integer'image(to_integer(unsigned(output))) & " instead of 32" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 64 right shifted" severity warning;

	sel    <= "1010";
        input1 <= std_logic_vector(to_unsigned(66, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(36, output'length))) report "Error : 66 half swapped = " & integer'image(to_integer(unsigned(output))) & " instead of 36" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 66 half swapped" severity warning;

	sel    <= "1011";
        input1 <= std_logic_vector(to_unsigned(128, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(1, output'length))) report "Error : 128 reversed = " & integer'image(to_integer(unsigned(output))) & " instead of 1" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect for 36 reversed" severity warning;

	sel    <= "1100";
        input1 <= std_logic_vector(to_unsigned(66, input1'length));
        input2 <= std_logic_vector(to_unsigned(128, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(16, output'length))) report "Error : output = " & integer'image(to_integer(unsigned(output))) & " instead of 16" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect" severity warning;

	sel    <= "1101";
        input1 <= std_logic_vector(to_unsigned(66, input1'length));
        input2 <= std_logic_vector(to_unsigned(16, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(0, output'length))) report "Error : output = " & integer'image(to_integer(unsigned(output))) & " instead of 64" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect" severity warning;

	sel    <= "1110";
        input1 <= std_logic_vector(to_unsigned(66, input1'length));
        input2 <= std_logic_vector(to_unsigned(65, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(65, output'length))) report "Error : output = " & integer'image(to_integer(unsigned(output))) & " instead of 65" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect" severity warning;

	sel    <= "1110";
        input1 <= std_logic_vector(to_unsigned(68, input1'length));
        input2 <= std_logic_vector(to_unsigned(70, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(68, output'length))) report "Error : output = " & integer'image(to_integer(unsigned(output))) & " instead of 68" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect" severity warning;

	
	sel    <= "1110";
        input1 <= std_logic_vector(to_unsigned(66, input1'length));
        input2 <= std_logic_vector(to_unsigned(66, input2'length));
        wait for 40 ns;
        assert(output = std_logic_vector(to_unsigned(66, output'length))) report "Error : output = " & integer'image(to_integer(unsigned(output))) & " instead of 66" severity warning;
        assert(overflow = '0') report "Error                                      : overflow incorrect" severity warning;

	wait;

    end process;



end TB;
