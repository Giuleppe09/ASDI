library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        load: in std_logic;
        load_sec: out std_logic; --manda un segnale per dire che sono secondi
        load_min: out std_logic; --manda un segnale per dire che sono minuti
        load_ore: out std_logic; --manda un segnale per dire che sono ore
        state: out std_logic_vector(2 downto 0)
    );
end Control_unit;

architecture Behavioral of Control_unit is

type stato is (idle, load_S, load_M, load_O);
signal stato_corrente: stato := idle; 
signal stato_prossimo : stato;        -- Prossimo stato

begin

    proc: process(CLK)
    begin
        case stato_corrente is
            when idle =>
                --uscite
                load_sec <= '0';
                load_min <= '0';
                load_ore <= '0';
                -- verifica load
                if load = '1' then
                    stato_prossimo <= load_S;
                else
                    stato_prossimo <= idle;
                end if;
                
            when load_S =>
                --uscite
                load_sec <= '1';
                load_min <= '0';
                load_ore <= '0';
                -- verifica load
                if load = '1' then
                    stato_prossimo <= load_M;
                else
                    stato_prossimo <= load_S;
                end if;
                
            when load_M =>
                --uscite
                load_sec <= '0';
                load_min <= '1';
                load_ore <= '0';
                -- verifica load
                if load = '1' then
                    stato_prossimo <= load_O;
                else
                    stato_prossimo <= load_M;
                end if;
                
            when load_O =>
                --uscite
                load_sec <= '0';
                load_min <= '0';
                load_ore <= '1';
                -- verifica load
                if load = '1' then
                    stato_prossimo <= load_S;
                else
                    stato_prossimo <= load_O;
                end if;
                
            when others =>
                stato_prossimo <= idle;   
                  
        end case;
    end process;
    
    stato_memoria: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                stato_corrente <= idle;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;
    
    -- Codifica dello stato corrente per debug (opzionale)
    with stato_corrente select 
        state <= "000" when idle, 
                "001" when load_S, 
                "010" when load_M, 
                "011" when load_O, 
                "111" when others;
end Behavioral;
