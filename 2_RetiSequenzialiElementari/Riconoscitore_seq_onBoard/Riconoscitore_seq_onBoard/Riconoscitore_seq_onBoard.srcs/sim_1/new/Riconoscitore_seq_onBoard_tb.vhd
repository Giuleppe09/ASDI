library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_Riconoscitore_onBoard is
end TB_Riconoscitore_onBoard;

architecture testbench of TB_Riconoscitore_onBoard is
    -- Component under test (CUT)
    component Riconoscitore_onBoard
        port(
            RST: in std_logic;
            CLK: in std_logic;
            i: in std_logic;
            i_read_in: in std_logic;
            M: in std_logic;
            m_read_in: in std_logic;
            LED: out std_logic;
            state: out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali di test
    signal RST: std_logic;
    signal CLK: std_logic;
    signal i: std_logic;
    signal i_read_in: std_logic;
    signal M: std_logic;
    signal m_read_in: std_logic;
    signal LED: std_logic;
    signal state: std_logic_vector(3 downto 0);

    -- Parametri temporali
    constant CLK_period: time := 10 ns;  -- Periodo del clock

begin
    -- Istanziazione del modulo sotto test
    UUT: Riconoscitore_onBoard
        port map(
            RST => RST,
            CLK => CLK,
            i => i,
            i_read_in => i_read_in,
            M => M,
            m_read_in => m_read_in,
            LED => LED,
            state => state
        );

    -- Generazione del clock
    process
    begin
        while now < 1000 ns loop
            CLK <= '0';
            wait for CLK_period / 2;
            CLK <= '1';
            wait for CLK_period / 2;
        end loop;
        wait;
    end process;

    -- Stimoli di test
    process
    begin
        -- Inizializzazione
        RST <= '1';  -- Attiviamo il reset
        wait for 20 ns;
        RST <= '0';  -- Disattiviamo il reset

        -- Prima sequenza di test
        i <= '1';
        i_read_in <= '1';
        wait for 15 ns;
        i_read_in <= '0';

        M <= '1';
        m_read_in <= '1';
        wait for 15 ns;
        m_read_in <= '0';

        wait for 50 ns;

        -- Seconda sequenza di test
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';

        M <= '0';
        wait for 10 ns;
        M <= '1';

        wait for 100 ns;

        -- Simulazione terminata
        wait;
    end process;

end testbench;
