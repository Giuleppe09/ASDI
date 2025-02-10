library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Handshaking_TB is
end Handshaking_TB;

architecture TB of Handshaking_TB is
    
    -- Component to be tested
    component Handshaking
        Port (
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            output: out std_logic_vector(3 downto 0);
            ACK   : out std_logic;
            REQ   : out std_logic;
            BUS_dato: out std_logic_vector(3 downto 0);
            stato_A: out std_logic_vector(2 downto 0);
            stato_B: out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Testbench signals
    signal CLK   : std_logic := '0';
    signal RST   : std_logic := '1';
    signal START : std_logic := '0';
    signal output_tb : std_logic_vector(3 downto 0);
    signal ACK_tb   : std_logic;
    signal REQ_tb   : std_logic;
    signal BUS_dato_tb: std_logic_vector(3 downto 0);
    signal stato_A_tb: std_logic_vector(2 downto 0);
    signal stato_B_tb: std_logic_vector(1 downto 0);
    
    -- Clock process (50 MHz -> periodo 20ns)
    constant CLK_period : time := 20 ns;
    
    begin
    
    -- Instantiate DUT (Device Under Test)
    UUT: Handshaking
        port map (
            CLK   => CLK,
            RST   => RST,
            START => START,
            output => output_tb,
            ACK   => ACK_tb,
            REQ   => REQ_tb,
            BUS_dato => BUS_dato_tb,
            stato_A => stato_A_tb,
            stato_B => stato_B_tb
        );

    -- Clock generation
    CLK_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_period/2;
            CLK <= '1';
            wait for CLK_period/2;
        end loop;
    end process;
    
    -- Stimulus process
    Stimulus: process
    begin
        -- Reset the system
        RST <= '1';
        START <= '0';
        wait for 40 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- First transaction
        START <= '1';
        wait for 40 ns;
        START <= '0';
        wait for 100 ns;
        
        -- Second transaction
        START <= '1';
        wait for 40 ns;
        START <= '0';
        wait for 200 ns;
        
        -- Finish simulation
        wait;
    end process;
    
end TB;
