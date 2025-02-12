library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GenProp is
    generic (N: integer);
    Port ( 
        x, y: in std_logic_vector(N-1 downto 0);
        P: out std_logic_vector(N-1 downto 0);
        G: out std_logic_vector(N-1 downto 0)
    );
end GenProp;

    architecture Behavioral of GenProp is
        begin
            GEN_PROP: for i in 0 to N-1 generate
                P(i) <= x(i) or y(i);
                G(i) <= x(i) and y(i);
            end generate;
        end Behavioral;
        

