library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Nodo_B_tb is
end Nodo_B_tb;

architecture testbench of Nodo_B_tb is

    -- Dichiarazione dei segnali di test
    signal CLK_tb   : std_logic := '0';
    signal RST_tb   : std_logic := '0';
    signal REQ_tb   : std_logic := '0';
    signal ACK_tb   : std_logic;
    signal BUS_in_tb: std_logic_vector(3 downto 0);
    signal output_tb: std_logic_vector(3 downto 0);
    
    -- Segnali di debug
    signal read_tb  : std_logic;
    signal write_tb : std_logic;
    signal stato_tb : std_logic_vector(2 downto 0);

    -- Clock process (50 MHz -> periodo 20 ns)
    constant CLK_PERIOD : time := 20 ns;
    begin
        CLK_process : process
        begin
            while now < 1000 ns loop  -- Simulazione per 1 us
                CLK_tb <= '0';
                wait for CLK_PERIOD / 2;
                CLK_tb <= '1';
                wait for CLK_PERIOD / 2;
            end loop;
            wait;
        end process;

    -- Istanziazione del Nodo_B
    UUT: entity work.Nodo_B
    port map (
        CLK    => CLK_tb,
        RST    => RST_tb,
        REQ    => REQ_tb,
        ACK    => ACK_tb,
        BUS_in => BUS_in_tb,
        read   => read_tb,
        write  => write_tb,
        stato  => stato_tb,
        output => output_tb
    );

    -- Stimoli di test
    process
    begin
        -- Reset iniziale
        RST_tb <= '1';
        wait for 40 ns;
        RST_tb <= '0';
        wait for 20 ns;

        -- Simuliamo la trasmissione di 4 stringhe (handshaking)
        for i in 0 to 3 loop
            -- Nodo A invia una richiesta con un dato casuale
            BUS_in_tb <= std_logic_vector(conv_unsigned(i+1, 4)); -- Simuliamo valori X(i)
            REQ_tb <= '1';
            wait for CLK_PERIOD; -- Aspettiamo il ciclo di clock
            
            -- Attesa ACK dal Nodo B
            wait until ACK_tb = '1';
            wait for CLK_PERIOD;

            -- Nodo A abbassa il REQ
            REQ_tb <= '0';
            wait for CLK_PERIOD;
            
            -- Attesa che il Nodo B abbassi ACK
            wait until ACK_tb = '0';
            wait for CLK_PERIOD;
        end loop;

        -- Fine della simulazione
        wait for 100 ns;
        report "Test completato" severity note;
        wait;
    end process;

end testbench;
