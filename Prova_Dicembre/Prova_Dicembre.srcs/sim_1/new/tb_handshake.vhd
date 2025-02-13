library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top_Module_tb is
end Top_Module_tb;

architecture behavior of Top_Module_tb is

    -- Dichiarazione dei segnali per il testbench
    signal CLK      : std_logic := '0';
    signal RST      : std_logic := '0';
    signal START    : std_logic := '0';
    signal BUS_OUT  : std_logic_vector(3 downto 0);
    signal REQ_OUT  : std_logic;
    signal ACK_OUT  : std_logic;
    signal STATO_A  : std_logic_vector(2 downto 0);
    signal STATO_B  : std_logic_vector(1 downto 0);

    -- Instanza del Top_Module
    component Top_Module is
        Port (
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            BUS_OUT   : out std_logic_vector(3 downto 0);
            REQ_OUT   : out std_logic;
            ACK_OUT   : out std_logic;
            STATO_A   : out std_logic_vector(2 downto 0);
            STATO_B   : out std_logic_vector(1 downto 0)
        );
    end component;

begin

    -- Istanza del Top_Module
    uut: Top_Module port map (
        CLK     => CLK,
        RST     => RST,
        START   => START,
        BUS_OUT => BUS_OUT,
        REQ_OUT => REQ_OUT,
        ACK_OUT => ACK_OUT,
        STATO_A => STATO_A,
        STATO_B => STATO_B
    );

    -- Generazione del clock
    CLK_process : process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;

    -- Stimoli per il test
    stimulus_process : process
    begin
        -- Inizializzazione
        RST <= '1'; 
        START <= '0'; 
        wait for 20 ns;
        
        -- Reset del sistema
        RST <= '0'; 
        wait for 20 ns;

        -- Applicazione dello start
        START <= '1';
        wait for 20 ns;
        START <= '0';
        wait for 20 ns;

        -- Verifica dell'uscita
        assert (BUS_OUT = "0000") report "Errore: BUS_OUT non è corretto" severity error;
        assert (REQ_OUT = '0') report "Errore: REQ_OUT non è corretto" severity error;
        assert (ACK_OUT = '0') report "Errore: ACK_OUT non è corretto" severity error;
        assert (STATO_A = "000") report "Errore: STATO_A non è corretto" severity error;
        assert (STATO_B = "00") report "Errore: STATO_B non è corretto" severity error;

        -- Test di comportamento
        wait for 20 ns;
        -- Altri stimoli possono essere aggiunti per testare diversi comportamenti

        -- Terminazione della simulazione
        wait for 100 ns;
        assert false report "Fine simulazione" severity failure;

    end process;

end behavior;
