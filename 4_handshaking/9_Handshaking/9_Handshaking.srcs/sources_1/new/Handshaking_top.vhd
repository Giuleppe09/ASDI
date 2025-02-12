library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Handshaking is
    Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            INVIO : in  std_logic;
            
            output  : out std_logic_vector(3 downto 0);
            -- per debug
            ACK_A   : out std_logic;
            REQ_A   : out std_logic;
            REQ_B   : out std_logic;
            ACK_B   : out std_logic;
            BUS_dato: out std_logic_vector(3 downto 0);
            stato_A : out std_logic_vector(2 downto 0);
            stato_B : out std_logic_vector(1 downto 0)
        );
end Handshaking;

architecture Structural of Handshaking is

    component Nodo_A is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            
            -- Per handshaking
            ACK_in  : in  std_logic;
            REQ_out : out std_logic;
            ACK_out : out std_logic;
            REQ_in  : in  std_logic;
            BUS_out : out std_logic_vector(3 downto 0);
            BUS_in  : in  std_logic_vector(3 downto 0);
            
            -- per debug
            stato  : out std_logic_vector(2 downto 0);
            write  : out std_logic;
            output : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component Nodo_B is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            INVIO : in  std_logic;
           
            -- Per handshaking
            ACK_in  : in  std_logic;
            REQ_out : out std_logic;
            ACK_out : out std_logic;
            REQ_in  : in  std_logic;
            BUS_out : out std_logic_vector(3 downto 0);
            BUS_in  : in  std_logic_vector(3 downto 0);
            
            -- Per debug
            stato  : out std_logic_vector(1 downto 0);
            write_B: out std_logic;
            read_B : out std_logic
        );
    end component;
    
    -- Segnali interni per il protocollo handshaking
    signal temp_REQ_AtoB: std_logic;
    signal temp_ACK_BtoA: std_logic;
    signal temp_REQ_BtoA: std_logic;
    signal temp_ACK_AtoB: std_logic;
    signal temp_BUS_AtoB: std_logic_vector(3 downto 0);
    signal temp_BUS_BtoA: std_logic_vector(3 downto 0);
    -- Segnali di debug
    signal temp_write_A: std_logic;
    signal temp_read_B : std_logic;
    signal temp_write_B: std_logic;
    
begin

    A: Nodo_A port map(  
            CLK   => CLK,
            RST   => RST,
            START => START,
            
            -- Per handshaking
            ACK_in  => temp_ACK_BtoA,
            REQ_out => temp_REQ_AtoB,
            ACK_out => temp_ACK_AtoB,
            REQ_in  => temp_REQ_BtoA,
            BUS_out => temp_BUS_AtoB,
            BUS_in  => temp_BUS_BtoA,
            
            -- Per debug
            stato  => stato_A,
            output => output
        );
    
    B: Nodo_B port map(  
            CLK   => CLK,
            RST   => RST,
            INVIO => INVIO,
           
            -- Per handshaking
            ACK_in  => temp_ACK_AtoB,
            REQ_out => temp_REQ_BtoA,
            ACK_out => temp_ACK_BtoA,
            REQ_in  => temp_REQ_AtoB,
            BUS_out => temp_BUS_BtoA,
            BUS_in  => temp_BUS_AtoB,
            
            -- Per debug
            stato   => stato_B,
            write_B => temp_write_B,
            read_B  => temp_read_B
        );
    
    -- Collegamento segnali di debug
    BUS_dato <= temp_BUS_AtoB; 
    ACK_A    <= temp_ACK_AtoB;
    REQ_A    <= temp_REQ_AtoB;
    ACK_B    <= temp_ACK_BtoA;
    REQ_B    <= temp_REQ_BtoA;
    
end Structural;
