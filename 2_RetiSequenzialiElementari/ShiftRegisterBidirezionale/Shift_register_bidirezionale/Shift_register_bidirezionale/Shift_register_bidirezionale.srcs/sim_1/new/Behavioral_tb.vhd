library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Behavioral_tb is
end Behavioral_tb;

architecture tb of Behavioral_tb is

    -- Dichiarazione del componente da testare
    component Behavioral
        generic(
            N: integer := 8 -- Numero di bit
        );
        Port (
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            load : in STD_LOGIC;
            sel : in STD_LOGIC_VECTOR (1 downto 0); -- Selezione del tipo di shift
            data_in : in STD_LOGIC_VECTOR (N-1 downto 0);
            data_out : out STD_LOGIC_VECTOR (N-1 downto 0)
        );
    end component;

    -- Segnali di test
    signal clk_tb : STD_LOGIC := '0';
    signal rst_tb : STD_LOGIC := '0';
    signal load_tb : STD_LOGIC := '0';
    signal sel_tb : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal data_in_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- 8 bit
    signal data_out_tb : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 20 ns; -- Periodo del clock

begin
    -- Istanziazione del modulo sotto test
    uut : Behavioral
        generic map (
            N => 8 -- Specifica che il registro è a 8 bit
        )
        port map (
            CLK => clk_tb,
            RST => rst_tb,
            load => load_tb,
            sel => sel_tb,
            data_in => data_in_tb,
            data_out => data_out_tb
        );

    -- Generazione del clock
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Processo di generazione degli stimoli
    stimuli : process
    begin
        -- 1. Reset globale
        rst_tb <= '1'; -- Attiva il reset
        wait for 2 * clk_period; -- Attendi due cicli di clock
        rst_tb <= '0'; -- Disattiva il reset
        wait for clk_period;

        -- 2. Caricamento dei dati in parallelo
        load_tb <= '1'; -- Abilita il caricamento
        data_in_tb <= "10101010"; -- Dati da caricare
        wait for clk_period;
        load_tb <= '0'; -- Disabilita il caricamento
        wait for clk_period;

        -- 3. Shift a sinistra di 1
        sel_tb <= "00"; -- Seleziona lo shift a sinistra di 1
        wait for clk_period;

        -- 4. Shift a destra di 1
        sel_tb <= "01"; -- Seleziona lo shift a destra di 1
        wait for clk_period;

        -- 5. Shift a sinistra di 2
        sel_tb <= "10"; -- Seleziona lo shift a sinistra di 2
        wait for clk_period;

        -- 6. Shift a destra di 2
        sel_tb <= "11"; -- Seleziona lo shift a destra di 2
        wait for clk_period;

        -- 7. Test fine simulazione
        wait for 5 * clk_period; -- Attendi altri 5 cicli di clock

        -- Termina la simulazione
        wait;
    end process;

end tb;
