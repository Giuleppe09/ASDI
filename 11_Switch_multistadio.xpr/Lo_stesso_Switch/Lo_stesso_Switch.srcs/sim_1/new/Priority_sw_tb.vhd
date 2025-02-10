library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Priority_sw is
-- Testbench has no ports
end tb_Priority_sw;

architecture behavior of tb_Priority_sw is

    -- Component declaration for the Unit Under Test (UUT)
    component Priority_sw is
        Port ( 
            mex_A    : in  std_logic_vector(3 downto 0);
            mex_B    : in  std_logic_vector(3 downto 0);
            mex_C    : in  std_logic_vector(3 downto 0);
            mex_D    : in  std_logic_vector(3 downto 0);     

            req_A    : in  std_logic;
            req_B    : in  std_logic;
            req_C    : in  std_logic;
            req_D    : in  std_logic;
            
            Y_deb    : out std_logic_vector(7 downto 0);
            X_deb    : out std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(1 downto 0);
            S_mux,
            S_demux: out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Signals to connect to UUT inputs/outputs
    signal mex_A    : std_logic_vector(3 downto 0) := (others => '0');
    signal mex_B    : std_logic_vector(3 downto 0) := (others => '0');
    signal mex_C    : std_logic_vector(3 downto 0) := (others => '0');
    signal mex_D    : std_logic_vector(3 downto 0) := (others => '0');
    
    signal req_A    : std_logic := '0';
    signal req_B    : std_logic := '0';
    signal req_C    : std_logic := '0';
    signal req_D    : std_logic := '0';
    
    signal Y_deb    : std_logic_vector(7 downto 0);
    signal X_deb    : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(1 downto 0);
    signal S_mux,
           S_demux: std_logic_vector(1 downto 0);
           
begin

    -- Instantiate the Unit Under Test (Priority_sw)
    uut: Priority_sw
        port map (
            mex_A    => mex_A,
            mex_B    => mex_B,
            mex_C    => mex_C,
            mex_D    => mex_D,
            req_A    => req_A,
            req_B    => req_B,
            req_C    => req_C,
            req_D    => req_D,
            Y_deb    => Y_deb,
            X_deb    => X_deb,
            data_out => data_out,
            S_mux    => S_mux,
            S_demux  => S_demux
        );

    -- Stimulus process: apply test vectors to the UUT
    stim_proc: process
    begin
        ------------------------------------------------------------------------------
        -- Test Vector 1: No request active (all req = '0')
        ------------------------------------------------------------------------------
        mex_A <= "1010";  -- arbitrary test data for node A (e.g., [data, destination])
        mex_B <= "1100";  -- test data for node B
        mex_C <= "0110";  -- test data for node C
        mex_D <= "0011";  -- test data for node D
        
        req_A <= '0';
        req_B <= '0';
        req_C <= '0';
        req_D <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- Test Vector 2: Only A active (highest priority)
        ------------------------------------------------------------------------------
        req_A <= '1';
        req_B <= '0';
        req_C <= '0';
        req_D <= '0';
        wait for 10 ns;
        req_A <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- Test Vector 3: Only B active
        ------------------------------------------------------------------------------
        req_B <= '1';
        wait for 10 ns;
        req_B <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- Test Vector 4: Only C active
        ------------------------------------------------------------------------------
        req_C <= '1';
        wait for 10 ns;
        req_C <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- Test Vector 5: Only D active
        ------------------------------------------------------------------------------
        req_D <= '1';
        wait for 10 ns;
        req_D <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- Test Vector 6: Multiple requests active 
        -- Expected behavior: Priority A > B > C > D.
        ------------------------------------------------------------------------------
        req_A <= '1';  -- highest priority active
        req_B <= '1';
        req_C <= '1';
        req_D <= '1';
        wait for 10 ns;
        
        -- Remove A, so B should be chosen next
        req_A <= '0';
        wait for 10 ns;
        
        -- Remove B, so C should take priority
        req_B <= '0';
        wait for 10 ns;
        
        -- Remove C, so D is the only one active now
        req_C <= '0';
        wait for 10 ns;
        
        -- Finally, clear D
        req_D <= '0';
        wait for 10 ns;
        
        ------------------------------------------------------------------------------
        -- End simulation
        ------------------------------------------------------------------------------
        wait;
    end process;
    
end behavior;
