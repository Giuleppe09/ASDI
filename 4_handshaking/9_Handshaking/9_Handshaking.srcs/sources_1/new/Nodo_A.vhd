library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo_A is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        START : in  std_logic;
        ACK   : in  std_logic;
        REQ   : out std_logic;
        BUS_out: out std_logic_vector(3 downto 0)  := (others => '0') ;
        stato: out std_logic_vector(2 downto 0);
        read: out std_logic
    );
end Nodo_A;


architecture Structural of Nodo_A is
    component cu_A is 
     Port ( 
        --Segnali esterni.
        start: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        
        --Segnali Per Handshaking completo
        REQ_out: out std_logic;
        ACK_in: in std_logic; 
        
        --Segnali interni all'entit? A
        count_in: in std_logic_vector(1 downto 0);
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        read: out std_logic; --Da dare alla ROM
        
        --Segnali per debug
        stato: out std_logic_vector(2 downto 0)
       
        
    );
    end component;
    
    component cont_mod4 is Port(
        clock, reset: in std_logic;
	      count_in: in std_logic; --Magari cambiamo nome
		  count: out std_logic_vector(1 downto 0)
		  --Conteggio fino a 4 si codifica con 2 bit
    );
    end component;
    
    component ROM is Port(
          CLK: in std_logic;                                                      
          read : in std_logic; --segnale di lettura                               
          ADDR : in std_logic_vector(1 downto 0); --2 bit di indirizzo per acceder
                                                  --sono inseriti tramite gli swit
          DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit letto dalla ROM
    );
    end component;
    
    signal temp_count_in: std_logic_vector(1 downto 0);
    signal temp_rst_count: std_logic;
    signal temp_en_count: std_logic;
    signal temp_read: std_logic;
    
  
begin

    
    --temp_count_in <= count_in;
    read <= temp_read;
    
    ControlUnit_A: cu_A port map(
        start => start,
        CLK => CLK,
        RST => RST,
        REQ_out=> REQ,
        ACK_in=> ACK,
        
        count_in => temp_count_in,
        rst_count => temp_rst_count,
        en_count => temp_en_count,
        read => temp_read,
        stato => stato
    );
    
    Counter: cont_mod4 port map(
        clock=>CLK,
        reset=> temp_rst_count,
        count_in => temp_en_count,
        count => temp_count_in --uscita del contatore va in ingresso all'unit? di controllo.
    );
    
    ROM_A: ROM port map(
        CLK => CLK,
        read => temp_read,
        ADDR => temp_count_in, --Per poter variare l'indirizzo.
        DATA => BUS_out
    );

end Structural;