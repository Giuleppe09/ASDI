library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Riconoscitore_onBoard_tb is
end Riconoscitore_onBoard_tb;

architecture Behavioral of Riconoscitore_onBoard_tb is
    -- Component Declaration for UUT
    component Riconoscitore_onBoard is
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

    -- Component Declaration for ButtonDebouncer (needed to override generic)
    component ButtonDebouncer is
        generic(
            CLK_period: integer := 10;
            btn_noise_time: integer := 100000
        );
        port(
            RST: in std_logic;
            CLK: in std_logic;
            BTN: in std_logic;
            CLEARED_BTN: out std_logic
        );
    end component;
    
    -- Signal Declaration
    signal RST, CLK, i, i_read_in, M, m_read_in, LED : std_logic := '0';
    signal state : std_logic_vector(3 downto 0);
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate UUT with modified ButtonDebouncer generic
    uut: entity work.Riconoscitore_onBoard 
    port map (
        RST => RST,
        CLK => CLK,
        i => i,
        i_read_in => i_read_in,
        M => M,
        m_read_in => m_read_in,
        LED => LED,
        state => state
    );
    
    -- Clock Process
    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus Process
    stim_proc: process
    begin
        -- Initial Reset
        RST <= '1';
        i <= '0';
        i_read_in <= '0';
        M <= '0';
        m_read_in <= '0';
        wait for CLK_PERIOD*5;
        
        -- Release reset
        RST <= '0';
        wait for CLK_PERIOD*5;
        
        -- Set M=0 mode and wait for debouncer
        M <= '0';
        m_read_in <= '1';
        wait for CLK_PERIOD*20;  -- Aumentato il tempo di attesa per il debouncer
        m_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        -- Test sequence 101
        i <= '1';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        i <= '0';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        i <= '1';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        -- Reset
        RST <= '1';
        wait for CLK_PERIOD*5;
        RST <= '0';
        wait for CLK_PERIOD*5;
        
        -- Change to M=1 mode
        M <= '1';
        m_read_in <= '1';
        wait for CLK_PERIOD*20;
        m_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        -- Test sequence 111 (overlapping 11)
        i <= '1';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        i <= '1';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        i <= '1';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        i <= '0';
        i_read_in <= '1';
        wait for CLK_PERIOD*20;
        i_read_in <= '0';
        wait for CLK_PERIOD*20;
        
        wait for CLK_PERIOD*50;
        wait;
    end process;

end Behavioral;