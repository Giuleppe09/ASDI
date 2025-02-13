library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo_A is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        START : in  std_logic; -- esterno
        
        -- Per HandShaking       
        REQ_out   : out std_logic;
        ACK_in    : in  std_logic;
        
        -- Bus dati
        BUS_out   : out std_logic_vector(3 downto 0)  := (others => '0');
        
        -- Per Debug
        stato     : out std_logic_vector(2 downto 0);
      
    );
end Nodo_A;

architecture Structural of Nodo_A is
    component cu_A is 
        Port ( 
            start     : in  std_logic;
            CLK       : in  std_logic;
            RST       : in  std_logic;
        
            -- Segnali Per Handshaking 
            REQ_out   : out std_logic;
            ACK_in    : in  std_logic;
        
            -- Segnali interni all'entità 
            count_in  : in  std_logic_vector(2 downto 0);
            rst_count : out std_logic;
            en_count  : out std_logic;
            read      : out std_logic;
        
            -- Segnali per debug
            stato     : out std_logic_vector(2 downto 0)
            
        );
    end component;
    
    component cont_mod8 is 
        Port(
            clock    : in  std_logic;
            reset    : in  std_logic;
            count_in : in  std_logic;
            count    : out std_logic_vector(2 downto 0)
        );
    end component;
    
    component ROM is 
        Port(
            CLK   : in  std_logic;                                                      
            read  : in  std_logic; -- Read Sincrona                            
            ADDR  : in  std_logic_vector(2 downto 0); -- 3 bit di indirizzo
            DATA  : out std_logic_vector(3 downto 0) -- Dato su 4 bit 
        );
    end component;
    
    -- Segnali interni
    signal temp_count_in  : std_logic_vector(2 downto 0);
    signal temp_rst_count : std_logic;
    signal temp_en_count  : std_logic;
    signal temp_read      : std_logic;
    signal temp_REQ       : std_logic;
    signal temp_ACK       : std_logic;
    signal temp_BUS       : std_logic_vector(3 downto 0);
  
begin
    -- Instanza della Control Unit
    ControlUnit_A: cu_A port map(
        start     => START,
        CLK       => CLK,
        RST       => RST,
        REQ_out   => REQ_out,
        ACK_in    => ACK_in,
        
        count_in  => temp_count_in,
        rst_count => temp_rst_count,
        en_count  => temp_en_count,
        read      => temp_read,
        stato     => stato,
        REQ       => temp_REQ,
        ACK       => temp_ACK
    );
    
    -- Instanza del Contatore Modulo 8
    Counter: cont_mod8 port map(
        clock    => CLK,
        reset    => temp_rst_count,
        count_in => temp_en_count,
        count    => temp_count_in 
    );
    
    -- Instanza della ROM
    ROM_A: ROM port map(
        CLK   => CLK,
        read  => temp_read,
        ADDR  => temp_count_in,
        DATA  => temp_BUS
    );

    -- Assegnazione dei segnali di debug
    REQ_debug <= temp_REQ;
    ACK_debug <= temp_ACK;
    BUS_out   <= temp_BUS;
    BUS_debug <= temp_BUS;

end Structural;
