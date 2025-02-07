library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Nodo_A is
end tb_Nodo_A;

architecture behavior of tb_Nodo_A is 
    
    -- Component under test (CUT)
    component Nodo_A
        Port (
            CLK     : in  std_logic;
            RST     : in  std_logic;
            START   : in  std_logic;
            ACK     : in  std_logic;
            REQ     : out std_logic;
            BUS_out : out std_logic_vector(3 downto 0);
            stato   : out std_logic_vector(2 downto 0);
            read : out std_logic
        );
    end component;
    
    -- Signals
    signal CLK     : std_logic := '0';
    signal RST     : std_logic := '0';
    signal START   : std_logic := '0';
    signal ACK     : std_logic := '0';
    signal REQ     : std_logic;
    signal BUS_out : std_logic_vector(3 downto 0);
    signal stato   : std_logic_vector(2 downto 0);
    signal read: std_logic;
    
    -- Clock period
    constant CLK_PERIOD : time := 10 ns;
    
begin
    
    -- Instantiate the CUT
    UUT: Nodo_A port map (
        CLK     => CLK,
        RST     => RST,
        START   => START,
        ACK     => ACK,
        REQ     => REQ,
        BUS_out => BUS_out,
        stato   => stato,
        read => read
    );
    
    -- Clock process
    CLK_process : process
    begin
        while now < 500 ns loop  -- Estensione della simulazione
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin    
        -- Reset iniziale
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        
        -- Avvio START
        START <= '1';
        wait for CLK_PERIOD;
        START <= '0';
        
        -- Simulazione del protocollo di handshaking per più stringhe
        for i in 0 to 3 loop  -- Simuliamo la trasmissione di 4 dati
            wait for 30 ns;
            ACK <= '1';
            wait for 10 ns;
            ACK <= '0';
            wait for 40 ns;
        end loop;
        
        -- Attendere alcuni cicli per osservare le uscite
        wait for 100 ns;
        
        -- Fine test
        wait;
    end process;
    
end behavior;