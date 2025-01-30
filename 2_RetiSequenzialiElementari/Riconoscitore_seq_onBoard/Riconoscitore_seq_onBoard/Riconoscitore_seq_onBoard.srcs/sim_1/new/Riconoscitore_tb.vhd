library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RICONOSCITORE_DI_SEQ_tb is
end RICONOSCITORE_DI_SEQ_tb;

architecture Behavioral of RICONOSCITORE_DI_SEQ_tb is
    -- Component Declaration
    component RICONOSCITORE_DI_SEQ
        port(
            i: in std_logic;
            i_read: in std_logic;
            RST,CLK: in std_logic;
            M: in std_logic;
            m_read: in std_logic;
            Y: out std_logic;
            state: out std_logic_vector(3 downto 0)
        );
    end component;
    
    -- Signal Declaration
    signal i, i_read, RST, CLK, M, m_read, Y : std_logic := '0';
    signal state : std_logic_vector(3 downto 0);
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: RICONOSCITORE_DI_SEQ port map (
        i => i,
        i_read => i_read,
        RST => RST,
        CLK => CLK,
        M => M,
        m_read => m_read,
        Y => Y,
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
        -- Initialize
        RST <= '1';
        i <= '0';
        i_read <= '0';
        M <= '0';  -- Start with M=0 mode (looking for "101")
        m_read <= '0';
        wait for CLK_PERIOD*2;
        
        -- Release reset
        RST <= '0';
        wait for CLK_PERIOD;
        
        -- Set M=0 and enable m_read
        M <= '0';
        m_read <= '1';
        wait for CLK_PERIOD;
        m_read <= '0';
        
        -- Test Case 1: Successfully detect "101" sequence
        i_read <= '1';
        i <= '1';  -- First bit
        wait for CLK_PERIOD;
        i <= '0';  -- Second bit
        wait for CLK_PERIOD;
        i <= '1';  -- Third bit (should detect sequence)
        wait for CLK_PERIOD*2;
        
        -- Test Case 2: Partial sequence "10" (without last bit)
        i <= '1';  -- First bit
        wait for CLK_PERIOD;
        i <= '0';  -- Second bit
        wait for CLK_PERIOD*2;
        
        -- Reset the system
        RST <= '1';
        wait for CLK_PERIOD*2;
        RST <= '0';
        
        -- Change to M=1 mode (looking for "11")
        M <= '1';
        m_read <= '1';
        wait for CLK_PERIOD;
        m_read <= '0';
        
        -- Test Case 3: Two overlapping successful "11" sequences
        i_read <= '1';
        i <= '1';  -- First '1'
        wait for CLK_PERIOD;
        i <= '1';  -- Second '1' (first sequence detected) and first '1' of second sequence
        wait for CLK_PERIOD;
        i <= '1';  -- Second '1' of second sequence
        wait for CLK_PERIOD;
        i <= '0';  -- Reset sequence
        wait for CLK_PERIOD*2;
        
        -- End simulation
        wait for CLK_PERIOD*5;
        wait;
    end process;
end Behavioral;