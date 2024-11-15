library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity fa is
generic (
        WIDTH : positive := 8);
  port (
    input1    : in  std_logic;
    input2    : in  std_logic;
    carry_in  : in  std_logic;
    sum       : out std_logic;
    carry_out : out std_logic);
end fa;

-- DEFINE THE FULL ADDER HERE

architecture BHV of fa is
begin 
  sum <= input1 XOR input2 XOR carry_in;
  carry_out <= (input1 AND input2) OR (carry_in AND input2) OR (input1 AND carry_in);
end BHV;
