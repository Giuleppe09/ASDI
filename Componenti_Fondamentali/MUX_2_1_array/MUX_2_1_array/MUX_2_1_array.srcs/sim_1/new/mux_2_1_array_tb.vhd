library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1_tb is
end mux_2_1_tb;

architecture tb of mux_2_1_tb is

    -- Dichiarazione del componente
    component mux_2_1
        port(
            A : in std_logic_vector(1 downto 0); -- Ingressi del mux
            S : in std_logic;                    -- Selettore
            Y : out std_logic                    -- Uscita del mux
        );
    end component;

    -- Segnali di test
    signal A_tb : std_logic_vector(1 downto 0) := (others => '0'); -- Ingressi
    signal S_tb : std_logic := '0';                                -- Selettore
    signal Y_tb : std_logic;                                       -- Uscita

begin

    -- Istanziazione del multiplexer 2 a 1
    uut: mux_2_1
        port map(
            A => A_tb, -- Connessione agli ingressi di test
            S => S_tb, -- Connessione al selettore di test
            Y => Y_tb  -- Connessione all'uscita osservabile
        );

    -- Processo di generazione degli stimoli
    stimuli: process
    begin
        -- Caso 1: S = 0, seleziona A(0)
        A_tb <= "10"; -- A(0) = '1', A(1) = '0'
        S_tb <= '0';  -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=0 non seleziona correttamente A(0)"
        severity failure;

        -- Caso 2: S = 1, seleziona A(1)
        S_tb <= '1';  -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=1 non seleziona correttamente A(1)"
        severity failure;

        -- Caso 3: Cambia ingressi e verifica nuovamente
        A_tb <= "01"; -- A(0) = '0', A(1) = '1'
        S_tb <= '0';  -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=0 non seleziona correttamente A(0) con nuovi ingressi"
        severity failure;

        S_tb <= '1';  -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=1 non seleziona correttamente A(1) con nuovi ingressi"
        severity failure;

        -- Caso 4: Entrambi gli ingressi a 0
        A_tb <= "00"; -- A(0) = '0', A(1) = '0'
        S_tb <= '0';  -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=0 non seleziona correttamente A(0) quando entrambi sono 0"
        severity failure;

        S_tb <= '1';  -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=1 non seleziona correttamente A(1) quando entrambi sono 0"
        severity failure;

        -- Caso 5: Entrambi gli ingressi a 1
        A_tb <= "11"; -- A(0) = '1', A(1) = '1'
        S_tb <= '0';  -- Seleziona A(0)
        wait for 10 ns;
        assert Y_tb = A_tb(0)
        report "Errore: S=0 non seleziona correttamente A(0) quando entrambi sono 1"
        severity failure;

        S_tb <= '1';  -- Seleziona A(1)
        wait for 10 ns;
        assert Y_tb = A_tb(1)
        report "Errore: S=1 non seleziona correttamente A(1) quando entrambi sono 1"
        severity failure;

        -- Fine della simulazione
        wait;
    end process;

end tb;
