library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    generic(
        modulo: integer := 16;
        n: integer := 4
    );
    port(
        CLK: in std_logic;
        RST: in std_logic;
        EN: in std_logic;
        y: out std_logic_vector(n-1 downto 0);
        U_Max: out std_logic
    );
end counter;

architecture Behavioral of counter is

    signal temp_y: std_logic_vector(n-1 downto 0) := (others => '0');
    signal temp_UMax: std_logic := '0';

begin
    
    y <= temp_y;
    
    logica_conteggio: process(CLK)
    begin
        if falling_edge(CLK) then
            if (RST = '1') then
                temp_y <= (others => '0');
            elsif (EN = '1') then
                --verifica countMax(modulo-1)
                if (temp_y = std_logic_vector(TO_UNSIGNED(modulo-1,n))) then --cast per type mismatch
                    temp_y <= (others => '0'); --resetto quando arrivo al conteggio massimo
                else
                    temp_y <= std_logic_vector(unsigned(temp_y) + 1); --cast per fare la somma e poi riconverto
                end if;
            end if;
       end if;
     end process;
     
     proc_count_max: process(CLK)
     begin
        if rising_edge(CLK) then --lo attivo sul rising edge in modo da essere sicura di leggere il valore corrente e non del ciclo precedente
            if (RST = '1') then
                temp_UMax <= '0'; --reset del segnale
            elsif (temp_y = std_logic_vector(TO_UNSIGNED(modulo-1,n))) then --cast per type mismatch
                temp_UMax <= '1'; --attivo quando raggiungo il massimo
            else
                temp_UMax <= '0'; --se no rimane basso
            end if;
        end if;
     end process;
     
     U_Max <= temp_UMax;

end Behavioral;