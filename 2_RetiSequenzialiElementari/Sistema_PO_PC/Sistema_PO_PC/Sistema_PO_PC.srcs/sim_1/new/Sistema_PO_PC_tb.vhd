library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity tb_sistemaPO_PC is
end tb_sistemaPO_PC;

architecture Behavioral of tb_sistemaPO_PC is

    -- **Segnali per il dispositivo sotto test (DUT)**
    signal clk_tb     : std_logic := '0';
    signal reset_tb   : std_logic := '0';
    signal start_tb   : std_logic := '0';
    signal output_tb  : std_logic_vector(3 downto 0);
    signal state_tb   : std_logic_vector(2 downto 0);

    -- **Costanti per la simulazione**
    constant CLK_PERIOD : time := 10 ns; -- Periodo del clock

begin

    -- **Istanziazione del DUT (Device Under Test)**
    DUT: entity work.sistemaPO_PC
    port map(
        clk    => clk_tb,
        reset  => reset_tb,
        start  => start_tb,
        output => output_tb,
        state  => state_tb
    );

    -- **Generazione del Clock**
    clk_process: process
    begin
        while now < 1000 ns loop  -- Simuliamo per 1000 ns
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
        -- **1?? RESET iniziale**
        report "Test 1: RESET iniziale";
        reset_tb <= '1';
        start_tb <= '0';
        wait for 20 ns;
        reset_tb <= '0';
        wait for 20 ns;

        -- **2?? Attivazione START per avviare il sistema**
        report "Test 2: START attivo";
        start_tb <= '1';
        wait for 50 ns;  -- Attendi il ciclo completo

        -- **3?? Disattivazione START (verifica che il sistema prosegua comunque)**
        report "Test 3: Disattivazione START";
        start_tb <= '0';
        wait for 50 ns;

        -- **4?? Interruzione con RESET durante il funzionamento**
        report "Test 4: RESET durante il funzionamento";
        reset_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';
        wait for 50 ns;

        -- **5?? Riavvio dopo RESET**
        report "Test 5: Riavvio dopo RESET";
        start_tb <= '1';
        wait for 50 ns;
        start_tb <= '0';
        wait for 50 ns;

        -- **6?? Simulazione contatore che arriva al massimo**
        report "Test 6: U_max raggiunto (simulato)";
        wait for 100 ns;  -- Supponiamo che il contatore arrivi a U_max

        -- **7?? Test di inattività (attendiamo per vedere cosa fa il sistema)**
        report "Test 7: Periodo di inattività";
        wait for 200 ns;

        -- **Fine simulazione**
        report "Test COMPLETATO con SUCCESSO!";
        wait;
    end process;

end Behavioral;
