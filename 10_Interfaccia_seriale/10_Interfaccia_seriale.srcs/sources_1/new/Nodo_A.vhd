library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo_A is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        START : in  std_logic;
        RXD   : in  std_logic;
        TXD   : out std_logic;
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
        
         --Segnali per comunicazione con la UART
        WR: out std_logic; --Da dare alla UART
        TBE : in std_logic; -- Da leggere dalla UART
        
        --Segnali interni all'entit�
        count_in: in std_logic_vector(1 downto 0);
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        
        --Segnali per debug
        stato: out std_logic_vector(2 downto 0)
       
        
    );
    end component;
    
    component cont_mod8 is Port(
        clock, reset: in std_logic;
	      count_in: in std_logic; --Magari cambiamo nome
		  count: out std_logic_vector(2 downto 0)
		  --Conteggio fino a 8 si codifica con 4 bit
    );
    end component;
    
    component ROM is Port(
          CLK: in std_logic;                                                      
          read : in std_logic; --segnale di lettura                               
          ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per acceder
                                                  --sono inseriti tramite gli swit
          DATA : out std_logic_vector(7 downto 0) -- dato su 8 bit letto dalla ROM
    );
    end component;
    
    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;					--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
            RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
            WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0');			--Master Reset
    end component;
    
    
    signal temp_WR: std_logic;
    signal temp_TBE: std_logic;
    signal temp_DBOUT : std_logic_vector (7 downto 0);
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
        
        WR=>temp_WR, --Da dare alla UART
        TBE=>temp_TBE, -- Da leggere dalla UART
        
        count_in => temp_count_in,
        rst_count => temp_rst_count,
        en_count => temp_en_count,
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
        DATA => temp_DBOUT
    );
    
    USART_A: Rs232RefComp port map(
        TXD =>TXD,
        RXD =>RXD,
        CLK => CLK,
        DBIN => "00000000",
        DBOUT => temp_DBOUT,
        TBE	=> temp_TBE,
        RD => '0',
        WR=> temp_WR,
        RST => RST
    );

end Structural;