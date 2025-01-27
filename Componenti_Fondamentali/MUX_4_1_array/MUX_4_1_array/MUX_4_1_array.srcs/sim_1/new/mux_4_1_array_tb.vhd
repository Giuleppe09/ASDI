library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1_tb is
end mux_4_1_tb;

architecture tb of mux_4_1_tb is

    -- Dichiarazione del componente
    component mux_4_1
        port(
            A : in std_logic_vector(3 downto 0); -- Ingressi del mux
            S : in std_logic_vector(1 downto 0); -- Selettore a 2 bit
            Y : out std_logic                    -- Uscita del mux
        );
    end component;

    -- Segnali di test
    signal A_tb : std_logic_vector(3 downto 0) := (others => '0'); -- Ingressi
    signal S_tb : std_logic_vector(1 downto 0) := "00";           -- Selettore
    signal Y_tb : std_logic;                                      -- Uscita

begin

    -- Istanziazione del multiplexer 4 a 1
    uut: mux_4_1
        port map(
            A => A_tb, -- Connessione agli ingressi di test
            S => S_tb, -- Connessione al selettore di test
            Y => Y_tb  -- Connessione all'uscita osservabile
        );

    -- Processo di generazione degli stimoli
    stimuli: process
    begin
        -- Caso 1: Seleziona A(0)
        A_tb <= "1000"; -- A(0) = '1', A(1) = '0', A(2) = '0', A(3) = '0'
        S_tb <= "00";   -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=00 non seleziona correttamente A(0)"
        severity failure;

        -- Caso 2: Seleziona A(1)
        S_tb <= "01";   -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=01 non seleziona correttamente A(1)"
        severity failure;

        -- Caso 3: Seleziona A(2)
        S_tb <= "10";   -- Seleziona A(2)
        wait for 10 ns;
        assert Y_tb = A_tb(2)
        report "Errore: S=10 non seleziona correttamente A(2)"
        severity failure;

        -- Caso 4: Seleziona A(3)
        S_tb <= "11";   -- Seleziona A(3)
        wait for 10 ns;
        assert Y_tb = A_tb(3)
        report "Errore: S=11 non seleziona correttamente A(3)"
        severity failure;

        -- Cambia ingressi e verifica nuovamente
        -- Caso 5: Nuova configurazione ingressi
        A_tb <= "0110"; -- A(0) = '0', A(1) = '1', A(2) = '1', A(3) = '0'
        S_tb <= "00";   -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=00 non seleziona correttamente A(0) con nuovi ingressi"
        severity failure;

        S_tb <= "01";   -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=01 non seleziona correttamente A(1) con nuovi ingressi"
        severity failure;

        S_tb <= "10";   -- Seleziona A(2)
        wait for 10 ns;
        assert Y_tb = A_tb(2)
        report "Errore: S=10 non seleziona correttamente A(2) con nuovi ingressi"
        severity failure;

        S_tb <= "11";   -- Seleziona A(3)
        wait for 10 ns;
        assert Y_tb = A_tb(3)
        report "Errore: S=11 non seleziona correttamente A(3) con nuovi ingressi"
        severity failure;

        -- Caso 6: Tutti gli ingressi a '0'
        A_tb <= "0000"; -- A(0) = '0', A(1) = '0', A(2) = '0', A(3) = '0'
        S_tb <= "00";   -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=00 non seleziona correttamente A(0) con ingressi tutti 0"
        severity failure;

        S_tb <= "01";   -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=01 non seleziona correttamente A(1) con ingressi tutti 0"
        severity failure;

        S_tb <= "10";   -- Seleziona A(2)
        wait for 10 ns;
        assert Y_tb = A_tb(2)
        report "Errore: S=10 non seleziona correttamente A(2) con ingressi tutti 0"
        severity failure;

        S_tb <= "11";   -- Seleziona A(3)
        wait for 10 ns;
        assert Y_tb = A_tb(3)
        report "Errore: S=11 non seleziona correttamente A(3) con ingressi tutti 0"
        severity failure;

        -- Caso 7: Tutti gli ingressi a '1'
        A_tb <= "1111"; -- A(0) = '1', A(1) = '1', A(2) = '1', A(3) = '1'
        S_tb <= "00";   -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=00 non seleziona correttamente A(0) con ingressi tutti 1"
        severity failure;

        S_tb <= "01";   -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=01 non seleziona correttamente A(1) con ingressi tutti 1"
        severity failure;

        S_tb <= "10";   -- Seleziona A(2)
        wait for 10 ns;
        assert Y_tb = A_tb(2)
        report "Errore: S=10 non seleziona correttamente A(2) con ingressi tutti 1"
        severity failure;

        S_tb <= "11";   -- Seleziona A(3)
        wait for 10 ns;
        assert Y_tb = A_tb(3)
        report "Errore: S=11 non seleziona correttamente A(3) con ingressi tutti 1"
        severity failure;

        -- Fine della simulazione
        wait;
    end process;

end tb;
