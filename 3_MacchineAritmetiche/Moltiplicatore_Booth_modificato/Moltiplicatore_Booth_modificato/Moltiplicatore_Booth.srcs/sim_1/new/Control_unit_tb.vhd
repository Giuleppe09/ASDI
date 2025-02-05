library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_unita_controllo is
end tb_unita_controllo;

architecture testbench of tb_unita_controllo is
    -- Component declaration
    component unita_controllo
        port (
            clock, reset, start : in std_logic;
            Q : in std_logic_vector(1 downto 0);
            count_in : in std_logic_vector(2 downto 0);
            loadM, en_count, loadAQ, en_shift : out std_logic;
            selAQ, subtract, stop_cu : out std_logic
        );
    end component;

    -- Signal declarations
    signal clock_tb, reset_tb, start_tb : std_logic := '0';
    signal Q_tb : std_logic_vector(1 downto 0) := "00";
    signal count_in_tb : std_logic_vector(2 downto 0) := "000";
    signal loadM_tb, en_count_tb, loadAQ_tb, en_shift_tb : std_logic;
    signal selAQ_tb, subtract_tb, stop_cu_tb : std_logic;

    -- Clock period definition
    constant CLOCK_PERIOD : time := 10 ns;

begin
    -- Instantiate the unit under test (UUT)
    uut: unita_controllo 
    port map (
        clock => clock_tb,
        reset => reset_tb,
        start => start_tb,
        Q => Q_tb,
        count_in => count_in_tb,
        loadM => loadM_tb,
        en_count => en_count_tb,
        loadAQ => loadAQ_tb,
        en_shift => en_shift_tb,
        selAQ => selAQ_tb,
        subtract => subtract_tb,
        stop_cu => stop_cu_tb
    );

    -- Clock process
    clk_process: process
    begin
        while now < 500 ns loop
            clock_tb <= '0';
            wait for CLOCK_PERIOD / 2;
            clock_tb <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Initialize signals
        reset_tb <= '1';  
        start_tb <= '0';
        Q_tb <= "00";
        count_in_tb <= "000";
        wait for 20 ns;
        
        -- Release reset and start operation
        reset_tb <= '0';
        wait for 10 ns;

        -- Test Case 1: Start transition to caricamento
        start_tb <= '1';
        wait for 10 ns;
        start_tb <= '0';
        wait for 20 ns;

        -- Test Case 2: Checking scan state transitions
        Q_tb <= "00"; -- Should go to avvia_shift
        wait for 10 ns;
        Q_tb <= "01"; -- Should go to avvia_somma
        wait for 10 ns;
        Q_tb <= "10"; -- Should go to avvia_sottrazione
        wait for 10 ns;
        Q_tb <= "11"; -- Should go to avvia_shift
        wait for 10 ns;

        -- Test Case 3: Increment count and check stop condition
        count_in_tb <= "110";
        wait for 10 ns;
        count_in_tb <= "111"; -- Should trigger stop_cu
        wait for 20 ns;

        -- End simulation
        wait;
    end process;
    
end testbench;
