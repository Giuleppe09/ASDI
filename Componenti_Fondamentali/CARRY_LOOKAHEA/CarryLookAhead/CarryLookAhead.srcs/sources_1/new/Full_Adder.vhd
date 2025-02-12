library IEEE;
use IEEE.std_logic_1164.ALL;

entity full_adder is 
    port(
        a: in std_logic;
        b: in std_logic;
        c_in: in std_logic;
        c_out,s: out std_logic
    );
end full_adder;

architecture behavioral of full_adder is

    begin 
        s<= a xor b xor c_in;
        c_out<= (a and b) or (c_in and (a or b));
    end behavioral;