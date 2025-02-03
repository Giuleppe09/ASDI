library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Control_unit is
end entity tb_Control_unit;

architecture testbench of tb_Control_unit is
    -- Dichiarazione della componente da testare
    component Control_unit
        port(
            clk     : in std_logic;
            reset   : in std_logic;
            start   : in std_logic;
            U_max   : in std_logic;
            en_cont : out std_logic;
            rst_cont: out std_logic;
            read    : out std_logic;
            write   : out std_logic;
            state   : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Segnali di test
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal start    : std_logic := '0';
    signal U_max    : std_logic := '0';
    signal en_cont  : std_logic;
    signal rst_cont : std_logic;
    signal read     : std_logic;
    signal write    : std_logic;
    signal state    : std_logic_vector(2 downto 0);

    -- Definizione del periodo di clock
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Istanziazione del DUT (Device Under Test)
    uut: Control_unit
        port map(
            clk     => clk,
            reset   => reset,
            start   => start,
            U_max   => U_max,
            en_cont => en_cont,
            rst_cont=> rst_cont,
            read    => read,
            write   => write,
            state   => state
        );

    -- Processo per generare il clock
    process
    begin
        while now < 200 ns loop  -- Limitiamo il tempo totale della simulazione
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Processo di stimolo
    process
    begin
        -- **Caso 1: Reset iniziale**
        reset <= '1'; 
        wait for CLK_PERIOD;
        reset <= '0'; 
        wait for CLK_PERIOD;
        
        -- Verifica dello stato iniziale (IDLE)
        assert state = "000" report "Errore: Stato iniziale non è IDLE" severity error;
        
        -- **Caso 2: Avvio della macchina a stati**
        start <= '1';
        wait for CLK_PERIOD;

        -- Verifica transizione a READ_STATE
        assert state = "001" report "Errore: Stato non è READ_STATE dopo start=1" severity error;

        -- **Caso 3: Transizione da READ_STATE a WRITE_STATE**
        wait for CLK_PERIOD;
        assert state = "010" report "Errore: Stato non è WRITE_STATE" severity error;

        -- **Caso 4: Transizione da WRITE_STATE a COUNT_STATE**
        wait for CLK_PERIOD;
        assert state = "011" report "Errore: Stato non è COUNT_STATE" severity error;

        -- **Caso 5: U_max = 0, ritorno a READ_STATE**
        U_max <= '0';
        wait for CLK_PERIOD;
        assert state = "001" report "Errore: Stato non è READ_STATE dopo COUNT_STATE" severity error;

        -- **Caso 6: U_max = 1, ritorno a IDLE**
        U_max <= '1';
        wait for CLK_PERIOD;
        assert state = "000" report "Errore: Stato non è IDLE dopo U_max=1" severity error;

        -- **Caso 7: Test del reset durante il funzionamento**
        start <= '1';  
        wait for CLK_PERIOD;  -- Stato dovrebbe essere READ_STATE
        reset <= '1';  
        wait for CLK_PERIOD;
        reset <= '0';  
        wait for CLK_PERIOD;
        assert state = "000" report "Errore: Reset non ha riportato a IDLE" severity error;

        -- **Caso 8: Controllo delle uscite durante ogni stato**
        start <= '1';
        wait for CLK_PERIOD;  -- Stato -> READ_STATE
        assert read = '1' and write = '0' and en_cont = '0' and rst_cont = '0'
            report "Errore: Uscite errate in READ_STATE" severity error;

        wait for CLK_PERIOD;  -- Stato -> WRITE_STATE
        assert read = '0' and write = '1' and en_cont = '0' and rst_cont = '0'
            report "Errore: Uscite errate in WRITE_STATE" severity error;

        wait for CLK_PERIOD;  -- Stato -> COUNT_STATE
        assert read = '0' and write = '0' and en_cont = '1' and rst_cont = '0'
            report "Errore: Uscite errate in COUNT_STATE" severity error;

        wait for CLK_PERIOD;  -- Stato -> READ_STATE (se U_max=0)
        assert read = '1' and write = '0' and en_cont = '0' and rst_cont = '0'
            report "Errore: Uscite errate in ritorno a READ_STATE" severity error;

        -- **Caso 9: Verifica di U_max=1 (fine conteggio)**
        U_max <= '1';
        wait for CLK_PERIOD;
        assert state = "000" report "Errore: Stato non è tornato in IDLE con U_max=1" severity error;

        -- Fine test
        report "Test completato con successo!";
        wait;
    end process;

end architecture testbench;
