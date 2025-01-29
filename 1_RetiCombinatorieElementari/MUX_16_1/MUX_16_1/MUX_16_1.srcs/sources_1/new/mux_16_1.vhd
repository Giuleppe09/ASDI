library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1 is
    port(
        C : in std_logic_vector(15 downto 0);
        S : in std_logic_vector(3 downto 0);
        Y : out std_logic
    );
end mux_16_1;

architecture Structural of mux_16_1 is
  
  signal U: std_logic_vector(3 downto 0);    
 -- segnali tra il 1° e il 2° livello di mux
  
    
    
    component mux_4_1 is 
        port(
            B : in std_logic_vector(3 downto 0);
            S_int : in std_logic_vector(1 downto 0);
            Y_int : out std_logic
            );
    end component;
            
    begin
        mux_liv_1: FOR i IN 0 TO 3 GENERATE
            mux_4_1_gen : mux_4_1
                port map(
                    B=> C(i*4+3 downto i*4),
                    S_int(1 downto 0) => S(1 downto 0),
                    Y_int => U(i)
                    );
         end generate mux_liv_1;
         
         mux_liv_2: mux_4_1
            port map(
                    B=> U, --Ogni filo di ingresso prende l'uscita di un mux del primo livello.
                    S_int(1 downto 0) => S(3 downto 2),
                    Y_int => Y --Porto all'esterno l'uscita del mux del 2° livello
                    );
    
end Structural;
