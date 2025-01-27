library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
    Port (
        CLK : in STD_LOGIC;       -- Segnale di clock
        RST : in STD_LOGIC;       -- Segnale di reset sincrono
        d   : in STD_LOGIC;       -- Ingresso D
        y   : out STD_LOGIC       -- Uscita Q
    );
end FF_D;

architecture Behavioral of FF_D is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then    -- Trigger sul fronte di salita del clock
            if RST = '1' then       -- Reset sincrono
                y <= '0';           -- Azzeramento dell'uscita
            else
                y <= d;             -- L'uscita segue l'ingresso D
            end if;
        end if;
    end process;
end Behavioral;
