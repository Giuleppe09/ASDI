library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarryLookAhead is
    generic (N: integer);
    Port ( 
        P, G: in std_logic_vector(N-1 downto 0);
        c_0: in std_logic;
        c: inout std_logic_vector(N downto 0)
    );
end CarryLookAhead;

architecture Behavioral of CarryLookAhead is
begin
               
     c(0) <= c_0;  -- Carry iniziale

    GEN_CARRY: for i in 0 to N-1 generate
        c(i+1) <= G(i) or (P(i) and c(i));
    end generate;

end Behavioral;
