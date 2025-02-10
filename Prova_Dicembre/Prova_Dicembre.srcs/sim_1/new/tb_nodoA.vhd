LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_Nodo_A IS
END tb_Nodo_A;

ARCHITECTURE behavior OF tb_Nodo_A IS 
    
    -- Component declaration for the tested unit
    COMPONENT Nodo_A
    PORT(
        CLK   : IN  std_logic;
        RST   : IN  std_logic;
        START : IN  std_logic;
        ACK   : IN  std_logic;
        REQ   : OUT std_logic;
        BUS_out : OUT std_logic_vector(3 downto 0);
        stato  : OUT std_logic_vector(2 downto 0);
        read   : OUT std_logic
    );
    END COMPONENT;
    
    -- Signals to connect to the DUT
    SIGNAL CLK   : std_logic := '0';
    SIGNAL RST   : std_logic := '0';
    SIGNAL START : std_logic := '0';
    SIGNAL ACK   : std_logic := '0';
    SIGNAL REQ   : std_logic;
    SIGNAL BUS_out : std_logic_vector(3 downto 0);
    SIGNAL stato  : std_logic_vector(2 downto 0);
    SIGNAL read   : std_logic;
    
    -- Clock period definition
    CONSTANT clk_period : time := 10 ns;
    
BEGIN
    
    -- Instantiate the Unit Under Test (UUT)
    uut: Nodo_A PORT MAP (
          CLK   => CLK,
          RST   => RST,
          START => START,
          ACK   => ACK,
          REQ   => REQ,
          BUS_out => BUS_out,
          stato  => stato,
          read   => read
    );
    
    -- Clock process definition
    clk_process :process
    begin
        while now < 2000 ns loop  -- Limit simulation time
            CLK <= '0';
            wait for clk_period/2;
            CLK <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin		
        -- Reset phase
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- Start operation
        START <= '1';
        wait for 10 ns;
        START <= '0';
        
        -- Simulate ACK responses from node B
        wait for 30 ns;
        ACK <= '1';
        wait for 10 ns;
        ACK <= '0';
        
        wait for 40 ns;
        ACK <= '1';
        wait for 10 ns;
        ACK <= '0';
        
        -- Continue simulation for multiple handshaking cycles
        for i in 1 to 7 loop
            wait for 50 ns;
            ACK <= '1';
            wait for 10 ns;
            ACK <= '0';
        end loop;
        
        -- End simulation
        wait for 200 ns;
        report "Simulation completed" severity note;
        wait;
    end process;
    
END behavior;
