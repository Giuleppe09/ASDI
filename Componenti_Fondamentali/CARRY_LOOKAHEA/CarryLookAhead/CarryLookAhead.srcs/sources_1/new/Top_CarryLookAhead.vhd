library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_CarryLookAhead is
    generic (N: integer);
    Port(
        x,y: in std_logic_vector(N-1 downto 0);
        c_in: in std_logic; --Eventuale riporto entrante
        S: out std_logic_vector(N-1 downto 0);
        c_out: out std_logic --eventuale riporto extra
    );
end Top_CarryLookAhead;

architecture Structural of Top_CarryLookAhead is

signal temp_P,temp_G: std_logic_vector(N-1 downto 0);
signal temp_c:  std_logic_vector(N downto 0);
signal FA_c: std_logic_vector(N-1 downto 0);  --Vettore per i riporti interni
--che non ci servirà ma ci serve per appoggiarci dentro i riporti uscenti dai FA finali
begin
    G_P: entity work.GenProp 
    generic map (N=>N)
    port map(
        x => x,
        y => y,
        P => temp_P,
        G => temp_G
    );
    
    CLA : entity work.CarryLookAhead
        generic map(N=>N)
        port map(    
            P => temp_P,
            G => temp_G,
            c_0 => c_in,
            c => temp_c
    );
    
    --Ultimo stadio --> N full-adder
    FA_SUM: for i in 0 to N-1 generate
        --collegamento dei FA per ogni bit
        FA: entity work.full_adder
            port map(
                a=> x(i),
                b=> y(i),
                c_in=> temp_c(i),
                c_out => FA_c(i),
                s=> S(i)
            );
            
     end generate FA_SUM;
     
     --Riporto finale
     --Manca l'ultimo riporto.
     c_out <= temp_c(N); --Sarebbe l'ultimo riporto uscente dal CLA
end Structural;
