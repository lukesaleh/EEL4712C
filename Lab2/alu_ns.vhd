library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity alu_ns is 
	generic ( 
		WIDTH : positive := 16 
	); 
	port (

		input1 : in std_logic_vector(WIDTH-1 downto 0);

		input2 : in std_logic_vector(WIDTH-1 downto 0);

		sel : in std_logic_vector(3 downto 0); 
		output : out std_logic_vector(WIDTH-1 downto 0); 
		overflow : out std_logic 
	); 
end alu_ns;

architecture Behavior of alu_ns is
begin
	process(sel, input1, input2)
		variable reverse:std_logic_vector(WIDTH-1 downto 0);
		variable mult:std_logic_vector((WIDTH*2)-1 downto 0);
	begin
	case(sel) is
		when "0000" =>
			if (std_logic_vector(unsigned(input1) +unsigned(input2)) < input1) then
				overflow <= '1';
			elsif (std_logic_vector(unsigned(input1) +unsigned(input2)) < input2) then
				overflow <= '1';
			else
				overflow <= '0';
			end if;
			output <= std_logic_vector(unsigned(input1)+unsigned(input2));
			
		when "0001" =>
			output <= std_logic_vector(unsigned(input1) - unsigned(input2));
			overflow <= '0';
		when "0010" =>
			mult := std_logic_vector(unsigned(input1)*unsigned(input2));
			if (mult(WIDTH-1 downto 0) < input1) then
				overflow <= '1';
			elsif (mult(WIDTH-1 downto 0) <input2) then
				overflow <= '1';
			else 
				overflow <= '0';
			end if;
			output <= mult(WIDTH-1 downto 0);
		when "0011" =>
			output <= input1 AND input2;
			overflow <= '0';
		when "0100" =>
			output <= input1 OR input2;
			overflow <= '0';
		when "0101" =>
			output <= input1 XOR input2;
			overflow <= '0';
		when "0110" =>
			output <= input1 NOR input2;
			overflow <= '0';
		when "0111" => 
			output <= not input1;
			overflow <= '0';
		when "1000" => 
			output <= input1(WIDTH-2 downto 0) & '0';
			overflow <= input1(WIDTH-1);
		when "1001" =>
			output <='0' & input1(WIDTH-1 downto 1);
			overflow <= '0';
		when "1011" =>
			for i in 0 to WIDTH-1 loop
				reverse(i) := input1(WIDTH-1-i);
			end loop;
			output <= reverse;
			overflow <= '0';
		when "1010" =>
			output <= input1((WIDTH-1)/2 downto 0) & input1(WIDTH-1 downto ((WIDTH-1)/2)+1);
			overflow <= '0';
		when "1100" =>
			output <= "000" & input2(WIDTH-1 downto 3);
			overflow <= '0';
		when "1101" =>
			output <= input2(WIDTH-5 downto 0) & "0000";
			 overflow <= '0';
		when "1110" =>
			if (input1 < input2) then
				output <= input1;
			elsif (input2 < input1) then
				output <= input2;
			elsif (input1 = input2) then
				output <= input1;
			end if;
			overflow <= '0';
		when others =>
			output <= (WIDTH-1 downto 0 => '0');
			overflow <= '0';
	end case;
	end process;
end Behavior;
			
			
				