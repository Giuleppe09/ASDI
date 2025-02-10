library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_Nodo_B is
end TB_Nodo_B;

architecture Behavioral of TB_Nodo_B is

    -- Component declaration for the DUT
    component Nodo_B
        Port (
            CLK   : in  std_logic;
            RST   : in  std_logic;
            REQ   : in std_logic;
            ACK   : out  std_logic;
            BUS_in: in std_logic_vector(3 downto 0);
            output: out std_logic_vector(3 downto 0);
            write: out std_logic;
            stato: out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Signals
    signal CLK   : std_logic := '0';
    signal RST   : std_logic := '0';
    signal REQ   : std_logic := '0';
    signal ACK   : std_logic;
    signal BUS_in: std_logic_vector(3 downto 0) := (others => '0');
    signal output: std_logic_vector(3 downto 0);
    signal write : std_logic;
    signal stato : std_logic_vector(1 downto 0);
    
    -- Clock process
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Instantiate the DUT
    UUT: Nodo_B port map (
        CLK   => CLK,
        RST   => RST,
        REQ   => REQ,
        ACK   => ACK,
        BUS_in => BUS_in,
        output => output,
        write => write,
        stato => stato
    );
    
    -- Clock process
    CLK_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;
    
    -- Stimulus process
    Stimulus: process
    begin
        -- Reset the system
        RST <= '1';
        wait for 2 * CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;
        
        -- Send first request
        BUS_in <= "0001";
        REQ <= '1';
        wait for CLK_PERIOD;
        REQ <= '0';
        wait for 5 * CLK_PERIOD;
        
        -- Send another request with a different value
        BUS_in <= "0010";
        REQ <= '1';
        wait for CLK_PERIOD;
        REQ <= '0';
        wait for 5 * CLK_PERIOD;
        
        -- Finish simulation
        wait for 10 * CLK_PERIOD;
        report "Simulation finished" severity note;
        wait;
    end process;
    
end Behavioral;
