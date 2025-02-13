library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RICONOSCITORE_DI_SEQ is
    port(
        i: in std_logic; -- ingresso
        i_read: in std_logic; -- permesso di leggere l'ingresso
        RST: in std_logic; -- reset asincrono
        M: in std_logic; -- modo
        m_read: in std_logic; -- permesso di leggere il modo
        Y: out std_logic; -- uscita
        state: out std_logic_vector(3 downto 0)
    );
end RICONOSCITORE_DI_SEQ;

architecture Behavioral of RICONOSCITORE_DI_SEQ is

    -- Definizione degli stati
    type stato is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
    signal stato_corrente : stato := S0;  -- Stato attuale
    signal temp_Y: std_logic;

begin
    -- Processo combinatorio: determinazione del prossimo stato e delle uscite
    process(stato_corrente, i, M, RST, i_read, m_read)
    begin
        if RST = '1' then
            stato_corrente <= S0;
            temp_Y <= '0';
        else
            case stato_corrente is
                when S0 =>
                    temp_Y <= '0';
                    if m_read = '1' then
                        if M = '0' then
                            stato_corrente <= S1;
                        else
                            stato_corrente <= S6;
                        end if;
                    end if;
                
                when S1 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        if i = '1' then
                            stato_corrente <= S2;
                        else
                            stato_corrente <= S4;
                        end if;
                    end if;
                
                when S2 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        if i = '0' then
                            stato_corrente <= S3;
                        else
                            stato_corrente <= S5;
                        end if;
                    end if;
                
                when S3 =>
                    if i_read = '1' then
                        stato_corrente <= S1;
                        if i = '1' then
                            temp_Y <= '1';
                        else
                            temp_Y <= '0';
                        end if;
                    end if;
                
                when S4 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        stato_corrente <= S5;
                    end if;
                
                when S5 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        stato_corrente <= S1;
                    end if;
                
                when S6 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        if i = '1' then
                            stato_corrente <= S7;
                        else
                            stato_corrente <= S6;
                        end if;
                    end if;
                
                when S7 =>
                    temp_Y <= '0';
                    if i_read = '1' then
                        if i = '0' then
                            stato_corrente <= S8;
                        else
                            stato_corrente <= S7;
                        end if;
                    end if;
                
                when S8 =>
                    if i_read = '1' then
                        if i = '1' then
                            temp_Y <= '1';
                        else
                            temp_Y <= '0';
                        end if;
                        stato_corrente <= S6;
                    end if;
                
                when others =>
                    stato_corrente <= S0;
                    temp_Y <= '0';
            end case;
        end if;
    end process;

    -- Assegnazione delle uscite
    Y <= temp_Y;
    
    -- Codifica dello stato corrente per debug
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