library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;        --avvio trasferimento
        count: in std_logic_vector(3 downto 0); --conteggio
        en_cont: out std_logic;     --enable contatore
        rst_cont: out std_logic;    --reset contatore
        read: out std_logic;        --comandi
        write: out std_logic;
        state: out std_logic_vector(2 downto 0)
    );
end Control_unit;

architecture Behavioral of Control_unit is

type stato is (IDLE,READ_STATE,OK_READ,WRITE_STATE,STOP,COUNT_STATE);

signal stato_corrente: stato:=IDLE;
signal stato_prossimo: stato:=IDLE;


begin

funzione_Stato_uscita: process(stato_corrente, start)
begin

        read <= '0';
        write <= '0';
        en_cont <= '0';
        rst_cont <= '0';

case stato_corrente is
    when IDLE=>
         --uscite
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
        --stato
        stato_prossimo<=OK_READ;
        
    when OK_READ=>
        --stato
        stato_prossimo<=WRITE_STATE;
        
    when WRITE_STATE=>
        --uscite
        write<='1';
        --stato
        stato_prossimo<=STOP;
    
    when STOP =>
        if start = '0' then
            stato_prossimo<=STOP;
        else
            stato_prossimo<=COUNT_STATE;
        end if;
        
    when COUNT_STATE=>
        --uscite
        en_cont<='1';
        --stato
        if count = "1111" then
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
        state <="000" when IDLE, 
                "001" when READ_STATE, 
                "010" when OK_READ, 
                "011" when WRITE_STATE,
                "100" when STOP,
                "101" when COUNT_STATE,
                "110" when others;


end Behavioral;