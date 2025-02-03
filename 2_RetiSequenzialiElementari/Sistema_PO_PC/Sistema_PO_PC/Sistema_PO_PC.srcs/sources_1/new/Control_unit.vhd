library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;        --avvio trasferimento
        U_max: in std_logic;        --U_max del contatore (fine conteggio)
        
        en_cont: out std_logic;     --enable contatore
        rst_cont: out std_logic;    --reset contatore
        read: out std_logic;        --comandi
        write: out std_logic;
        state: out std_logic_vector(2 downto 0)
    );
end Control_unit;

architecture Behavioral of Control_unit is

type stato is (IDLE,READ_STATE,WRITE_STATE,COUNT_STATE);

signal stato_corrente: stato:=IDLE;
signal stato_prossimo: stato:=IDLE;


begin

funzione_Stato_uscita: process(stato_corrente, start)
begin

case stato_corrente is
    when IDLE=>
        --uscite
        read <= '0';
        write <= '0';
        en_cont <= '0';
        rst_cont <= '1';  -- Mantiene il contatore in reset finché è in IDLE
        --stato
        if start = '0' then
            stato_prossimo<=IDLE;
        else
            stato_prossimo<=READ_STATE;
        end if;
        
    when READ_STATE=>
        --uscite
        read<='1';
        write <= '0';
        en_cont <= '0';
        rst_cont <= '0';
        --stato
        stato_prossimo<=WRITE_STATE;
        
    when WRITE_STATE=>
        --uscite
        read <= '0';
        write<='1';
        en_cont <= '0';
        rst_cont <= '0';
        --stato
        stato_prossimo<=COUNT_STATE;
        
    when COUNT_STATE=>
        --uscite
        read <= '0';
        write <= '0';
        en_cont<='1';
        rst_cont <= '0';
        --stato
        if U_max = '1' then
            stato_prossimo<=IDLE;
        else
            stato_prossimo<=READ_STATE;
        end if;
        
    when others=>
        stato_prossimo<=IDLE;
        
    end case;
end process;

mem: process(clk)
    begin
        if rising_edge(clk) then
            --gestione del reset
            if reset = '1' then
                stato_corrente <= IDLE;
             else
                stato_corrente <= stato_prossimo;
             end if;
        end if;
    end process;

    -- Codifica dello stato corrente per debug (opzionale)
    with stato_corrente select 
        state <= "000" when IDLE, 
                "001" when READ_STATE, 
                "010" when WRITE_STATE, 
                "011" when COUNT_STATE, 
                "100"  when others;


end Behavioral;