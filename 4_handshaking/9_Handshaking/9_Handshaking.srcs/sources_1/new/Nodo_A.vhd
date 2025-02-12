library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo_A is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        START : in  std_logic; -- esterno
        
        --Per HandShaking       
        REQ_in: in std_logic;
        REQ_out   : out std_logic;
        ACK_out: out std_logic;
        ACK_in  : in  std_logic;
        
        BUS_out: out std_logic_vector(7 downto 0)  := (others => '0') ;
        -- Per Debug
        stato: out std_logic_vector(2 downto 0);
        read: out std_logic
    );
end Nodo_A;


architecture Structural of Nodo_A is
    component cu_A is 
     Port ( 
        
        start: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        
        ris: in std_logic; --Uscita comparatore
        
        
        --Segnali Per Handshaking completo
        REQ_out: out std_logic;
        REQ_in: in std_logic;
        ACK_in: in std_logic;
        ACK_out: out std_logic; 
        
        
        --Segnali interni all'entità 
        count_in: in std_logic_vector(2 downto 0); -- Deve entrare nel counter (sistema disegno)
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        read: out std_logic; --Da dare alla ROM
        
        --Segnali per debug
        stato: out std_logic_vector(2 downto 0)
       
        
    );
    end component;
    
    component cont_mod8 is Port(
        clock, reset: in std_logic;
	      count_in: in std_logic; --Magari cambiamo nome
		  count: out std_logic_vector(2 downto 0)
		  --Conteggio fino a 8 si codifica con 3 bit
    );
    end component;
    
    component ROM is Port(
          CLK: in std_logic;                                                      
          read : in std_logic; --Read Sincrona                            
          ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere a 8 locazioni
                                                  
          DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit 
    );
    end component;
    
    signal temp_count_in: std_logic_vector(2 downto 0);
    signal temp_rst_count: std_logic;
    signal temp_en_count: std_logic;
    signal temp_read: std_logic;
    
  
begin

    
    
    read <= temp_read;
    
    ControlUnit_A: cu_A port map(
        start => start,
        CLK => CLK,
        RST => RST,
        REQ_out=> REQ,
        ACK_in=> ACK,
        
        count_in => temp_count_in,
        rst_count => temp_rst_count, --Uscita da dare al contatore (sistemare disegno)
        en_count => temp_en_count, 
        read => temp_read,
        stato => stato
    );
    
    Counter: cont_mod8 port map(
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