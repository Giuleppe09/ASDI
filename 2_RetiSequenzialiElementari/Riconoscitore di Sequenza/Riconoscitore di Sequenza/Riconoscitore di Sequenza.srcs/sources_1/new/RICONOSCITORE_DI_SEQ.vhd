----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2024 09:06:09
-- Design Name: 
-- Module Name: RICONOSCITORE_DI_SEQ - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RICONOSCITORE_DI_SEQ is
    port(
        i: in std_logic;
        RST,CLK: in std_logic;
        M: in std_logic;
        Y: out std_logic;
        state: out std_logic_vector(3 downto 0)
    );
end RICONOSCITORE_DI_SEQ;

architecture Behavioral of RICONOSCITORE_DI_SEQ is

    -- Definizione degli stati
    type stato is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
    signal stato_corrente : stato := S0;  -- Stato attuale
    signal stato_prossimo : stato;        -- Prossimo stato
    signal temp_Y: std_logic;              -- Segnale temporaneo (se necessario)

begin

    -- Processo combinatorio: determinazione del prossimo stato e delle uscite
    stato_uscita: process(stato_corrente, i, M) --il modo può cambiare durante l'esecuzione ma lo valuto solo in S0
    begin
        case stato_corrente is
            when S0 =>
                temp_Y <= '0';
                if M = '0' then
                    stato_prossimo <= S1;
                else
                    stato_prossimo <= S6;
                end if;

            when S1 =>
                temp_Y <= '0';
                if i = '1' then
                    stato_prossimo <= S2;
                else
                    stato_prossimo <= S4;
                end if;

            when S2 =>
                temp_Y <= '0';
                if i = '0' then
                    stato_prossimo <= S3;
                else
                    stato_prossimo <= S5;
                end if;

            when S3 =>
                stato_prossimo <= S1;  -- Il reset sarà gestito nel processo sequenziale
                -- a seconda di i ci andrà con un'uscita diversa
                if i = '1' then
                    temp_Y <= '1';
                else
                    temp_Y <= '0';
                end if;

            when S4 =>
                temp_Y <= '0';
                stato_prossimo <= S5;

            when S5 =>
                temp_Y <= '0';  -- Anche qui il reset sarà gestito nel processo sequenziale
                stato_prossimo <= S1;

            when S6 =>
                temp_Y <= '0';
                if i = '1' then
                    stato_prossimo <= S7;
                else
                    stato_prossimo <= S6;
                end if;

            when S7 =>
                temp_Y <= '0';
                if i = '0' then
                    stato_prossimo <= S8;
                else
                    stato_prossimo <= S7;
                end if;

            when S8 =>
                if i = '1' then
                    temp_Y <= '1';
                else
                    temp_Y <= '0';
                end if;
                stato_prossimo <= S6;

            when others =>
                stato_prossimo <= S0;
                temp_Y <= '0';
        end case;
    end process;
    

    -- Processo sequenziale: gestione del reset e aggiornamento dello stato corrente
    stato_memoria: process(CLK)
    begin
        if rising_edge(CLK) then
            if (RST = '1') then
                -- Se RST è alto, reset immediato allo stato iniziale
                stato_corrente <= S0;
                Y <= '0';
            else
                -- Controllo specifico del reset in base a M e allo stato corrente
                if M = '0' then
                    -- Analizzo RST solo negli stati S3 e S5
                    if stato_corrente = S3 or stato_corrente = S5 then
                        if RST = '1' then
                            stato_corrente <= S0;  -- Reset allo stato iniziale
                            Y <= '0';
                        else
                            stato_corrente <= stato_prossimo;
                            Y <= temp_Y;
                        end if;
                    else
                        stato_corrente <= stato_prossimo;
                        Y <= temp_Y;
                    end if;
                else
                    -- Per M=1, nessun controllo aggiuntivo, passo direttamente al prossimo stato
                    stato_corrente <= stato_prossimo;
                    Y <= temp_Y;
                end if;
            end if;
        end if;
    end process;

    -- Codifica dello stato corrente per debug (opzionale)
    with stato_corrente select 
        state <= x"0" when S0, 
                x"1" when S1, 
                x"2" when S2, 
                x"3" when S3, 
                x"4" when S4, 
                x"5" when S5, 
                x"6" when S6, 
                x"7" when S7, 
                x"8" when S8, 
                x"9" when others;

end Behavioral;

