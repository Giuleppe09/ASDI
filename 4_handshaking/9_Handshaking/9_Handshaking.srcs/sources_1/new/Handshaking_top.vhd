library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Module is
    Port (
        CLK   : in  std_logic;
        RST   : in  std_logic;
        START : in  std_logic;
        
        -- Output di debug
        BUS_OUT   : out std_logic_vector(3 downto 0);
        REQ_OUT   : out std_logic;
        ACK_OUT   : out std_logic;
        STATO_A   : out std_logic_vector(2 downto 0);
        STATO_B   : out std_logic_vector(1 downto 0)
    );
end Top_Module;

architecture Structural of Top_Module is
    
    -- Componenti Nodo_A e Nodo_B
    component Nodo_A is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            REQ_out   : out std_logic;
            ACK_in    : in  std_logic;
            BUS_out   : out std_logic_vector(3 downto 0);
            stato     : out std_logic_vector(2 downto 0);
            REQ_debug : out std_logic;
            ACK_debug : out std_logic;
            BUS_debug : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component Nodo_B is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            REQ   : in  std_logic;
            ACK   : out std_logic;
            BUS_in : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0);
            write  : out std_logic;
            stato  : out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Segnali interni
    signal sig_REQ : std_logic;
    signal sig_ACK : std_logic;
    signal sig_BUS : std_logic_vector(3 downto 0);
    signal sig_STATO_A : std_logic_vector(2 downto 0);
    signal sig_STATO_B : std_logic_vector(1 downto 0);
    
begin
    
    -- Instanza di Nodo_A
    U1: Nodo_A port map(
        CLK       => CLK,
        RST       => RST,
        START     => START,
        REQ_out   => sig_REQ,
        ACK_in    => sig_ACK,
        BUS_out   => sig_BUS,
        stato     => sig_STATO_A,
        REQ_debug => open,
        ACK_debug => open,
        BUS_debug => open
    );
    
    -- Instanza di Nodo_B
    U2: Nodo_B port map(
        CLK    => CLK,
        RST    => RST,
        REQ    => sig_REQ,
        ACK    => sig_ACK,
        BUS_in => sig_BUS,
        output => open,
        write  => open,
        stato  => sig_STATO_B
    );
    
    -- Assegnazione segnali di output
    BUS_OUT <= sig_BUS;
    REQ_OUT <= sig_REQ;
    ACK_OUT <= sig_ACK;
    STATO_A <= sig_STATO_A;
    STATO_B <= sig_STATO_B;
    
end Structural;
