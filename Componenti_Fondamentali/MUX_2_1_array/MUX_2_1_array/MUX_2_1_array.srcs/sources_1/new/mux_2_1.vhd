library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1 is
    port(
        A : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        S : in std_logic;                    -- Selettore
        Y : out std_logic                    -- Uscita
    );
end mux_2_1;

architecture Behavioral of mux_2_1 is
begin
    process(A, S)
    begin
        if S = '0' then
            Y <= A(0); -- Se S � '0', seleziona A(0)
        else
            Y <= A(1); -- Se S � '1', seleziona A(1)
        end if;
    end process;
end Behavioral;
