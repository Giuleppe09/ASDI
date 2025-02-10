library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_sistemaPO_PC is
end tb_sistemaPO_PC;

architecture Behavioral of tb_sistemaPO_PC is

    -- **Segnali per il DUT**
    signal clk_tb       : std_logic := '0';
    signal reset_tb     : std_logic := '0';
    signal start_tb     : std_logic := '0';
    signal output_tb    : std_logic_vector(3 downto 0);
    signal state_tb     : std_logic_vector(2 downto 0);
    signal reset_count_tb : std_logic;
    signal read_tb      : std_logic;
    signal write_tb     : std_logic;
    signal en_cont_tb   : std_logic;
    signal count_tb     : std_logic_vector(3 downto 0) := (others => '0');

    -- **Costanti per la simulazione**
    constant CLK_PERIOD : time := 10 ns;  -- Periodo del clock (100 MHz)
    constant MAX_TIME   : time := 10 us;  -- Tempo massimo per completare il ciclo (10 µs)
    constant MAX_COUNT  : integer := 16;  -- Numero massimo di iterazioni (4 bit -> 16 locazioni)

begin

    -- **Istanziazione del DUT (Device Under Test)**
    DUT: entity work.sistemaPO_PC
    port map(
        clk      => clk_tb,
        reset    => reset_tb,
        start    => start_tb,
        output   => output_tb,
        state    => state_tb,
        rst_cont => reset_count_tb,   -- Reset contatore
        read     => read_tb,          -- Segnale di lettura
        write    => write_tb          -- Segnale di scrittura
    );

    -- **Generazione del Clock**
    clk_process: process
    begin
        while now < MAX_TIME loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;  -- Fine simulazione
    end process;

    -- **Stimoli di test**
    stimulus_process: process
    begin
        -- **1. RESET iniziale**
        report "Test 1: RESET iniziale";
        reset_tb <= '1';
        start_tb <= '0';
        wait for 20 ns;
        reset_tb <= '0';
        wait for 20 ns;
        assert (state_tb = "000") report "Errore: Stato non IDLE dopo reset" severity error;

        -- **2. Attivazione START con cadenza corretta**
        report "Test 2: Attivazione START";
        for i in 0 to MAX_COUNT - 1 loop
            start_tb <= '1';
            wait for 10 ns;  -- Tempo necessario per elaborare una locazione di memoria
            start_tb <= '0';
            wait for 50 ns;  -- Tempo per attraversare READ -> OK_READ -> WRITE -> COUNT
        end loop;

        -- **3. Verifica transizione fino a STOP**
        wait for CLK_PERIOD;
        assert (state_tb = "100") report "Errore: Stato non STOP dopo massimo conteggio" severity error;

        -- **4. Test dello stato STOP e transizione a COUNT_STATE**
        report "Test 4: Stato STOP e attivazione START";
        wait for 30 ns;
        start_tb <= '1';  -- Riavvio del sistema
        wait for 10 ns;
        start_tb <= '0';
        wait for 10 ns;
        assert (state_tb = "101") report "Errore: Stato non COUNT_STATE dopo riavvio da STOP" severity error;

        -- **5. Controllo del comportamento della memoria MEM**
        report "Test 5: Controllo dati scritti in MEM";
        wait for 100 ns;

        -- **6. Reset durante il funzionamento**
        report "Test 6: RESET durante il funzionamento";
        start_tb <= '1';
        wait for 30 ns;
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        wait for 20 ns;
        assert (state_tb = "000") report "Errore: Stato non IDLE dopo reset" severity error;

        -- **Fine simulazione**
        report "Test COMPLETATO con SUCCESSO!";
        wait;
    end process;

end Behavioral;
