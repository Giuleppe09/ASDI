library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Handshaking_tb is
end Handshaking_tb;

architecture testbench of Handshaking_tb is

    -- Dichiarazione segnali di test
    signal CLK_tb   : std_logic := '0';
    signal RST_tb   : std_logic := '0';
    signal START_tb : std_logic := '0';
    
    signal output_tb : std_logic_vector(3 downto 0);
    signal ACK_tb    : std_logic;
    signal REQ_tb    : std_logic;
    signal BUS_tb    : std_logic_vector(3 downto 0);
    signal stato_A_tb: std_logic_vector(2 downto 0);
    signal stato_B_tb: std_logic_vector(2 downto 0);

    -- Clock process (50 MHz -> periodo 20 ns)
    constant CLK_PERIOD : time := 20 ns;

    begin
        -- Generazione del clock
        CLK_process : process
        begin
            while now < 2000 ns loop  -- Simulazione per 2 us
                CLK_tb <= '0';
                wait for CLK_PERIOD / 2;
                CLK_tb <= '1';
                wait for CLK_PERIOD / 2;
            end loop;
            wait;
        end process;

    -- Istanziazione del modulo Handshaking
    UUT: entity work.Handshaking
    port map (
        CLK       => CLK_tb,
        RST       => RST_tb,
        START     => START_tb,
        output    => output_tb,
        ACK       => ACK_tb,
        REQ       => REQ_tb,
        BUS_dato  => BUS_tb,
        stato_A   => stato_A_tb,
        stato_B   => stato_B_tb
    );

    -- Stimoli di test
    process
    begin
        -- Reset iniziale
        RST_tb <= '1';
        wait for 40 ns;
        RST_tb <= '0';
        wait for 20 ns;

        -- Inizio trasmissione con START
        START_tb <= '1';
        wait for CLK_PERIOD;
        START_tb <= '0';

        -- Attendere la trasmissione dei 4 dati
        wait for 500 ns; -- Aspettiamo che avvenga il ciclo di trasmissione

        -- Controllo finale
        report "Test completato, verifica dei segnali" severity note;

        wait;
    end process;

end testbench;
