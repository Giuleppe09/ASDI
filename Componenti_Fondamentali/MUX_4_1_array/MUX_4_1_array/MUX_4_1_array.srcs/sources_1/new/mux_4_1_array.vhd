library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1 is
    port(
        A : in std_logic_vector(3 downto 0); -- Ingressi (4 ingressi: A(0) a A(3))
        S : in std_logic_vector(1 downto 0); -- Selettore (2 bit)
        Y : out std_logic                    -- Uscita
    );
end mux_4_1;

architecture Behavioral of mux_4_1 is
begin
    process(A, S)
    begin
        case S is
            when "00" => 
                Y <= A(0); -- Se S = "00", seleziona A(0)
            when "01" => 
                Y <= A(1); -- Se S = "01", seleziona A(1)
            when "10" => 
                Y <= A(2); -- Se S = "10", seleziona A(2)
            when "11" => 
                Y <= A(3); -- Se S = "11", seleziona A(3)
            when others => 
                Y <= '0'; -- Valore di default per sicurezza
        end case;
    end process;
end Behavioral;
