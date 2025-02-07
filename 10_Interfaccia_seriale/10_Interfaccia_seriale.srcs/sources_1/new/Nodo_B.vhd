
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Nodo_B is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        RDA   : in std_logic;
        output: out std_logic_vector(7 downto 0);
        RXD : in std_logic;
        --per debug
        write: out std_logic;
        stato: out std_logic_vector(2 downto 0)
    );
end Nodo_B;

architecture Structural of Nodo_B is

    component cu_B is
        Port ( 
            --Segnali esterni.
            CLK: in std_logic;
            RST: in std_logic;
            
            --Segnali per la comunicazione con la UART
            RDA: in std_logic; --Potrebbe anche esserci il problema di mapping per cui la pongo inout e via
            RD: out std_logic;
            --Segnali interni all'entità B
            count_in: in std_logic_vector(2 downto 0);
            rst_count: out std_logic; --Da dare al contatore.std_logic
            en_count: out std_logic; --Da dare al end
            
            write: out std_logic; --Da dare alla MEM
            --per debug
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
    
    component mem_out is
        port(
            CLK: in std_logic;
            RST: in std_logic;
            write: in std_logic; -- Segnale di scrittura
            ADDR : in std_logic_vector(2 downto 0);
            data_in: in std_logic_vector(7 downto 0);
            data_out: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;					--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(1 quando il dato Ã¨ disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare Ã¨ stato caricato nello shift register)
            RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
            WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0');			--Master Reset
    end component;
	
	
	signal temp_write: std_logic; -- da cu verso mem
	
	--per counter
	signal temp_rst_count: std_logic;
	signal temp_en_count: std_logic;
	signal temp_count_in: std_logic_vector(2 downto 0);
	
	--per UART
	signal temp_DBOUT : std_logic_vector (7 downto 0);
	signal TXD_n : std_logic; --Che non serve ma devo pur mappare sta uart.
	signal temp_RDA: std_logic; --che viene mandato alla CU
	signal temp_RD: std_logic; --DA CU verso UART
begin

    Control_unit_B:cu_B port map(
        --Segnali esterni.
        CLK => CLK,
        RST => RST,
        
        --Segnali Per Handshaking completo
        RDA => temp_RDA,
        RD => temp_RD,
        
        --Segnali interni all'entità A
        count_in => temp_count_in,
        rst_count => temp_rst_count,
        en_count => temp_en_count,
        write => temp_write,
        --per debug
        stato => stato
    );
    
    MEM: mem_out port map(
        CLK => CLK,
        RST => RST,
        write => temp_write,
        ADDR => temp_count_in,
        data_in => temp_DBOUT,
        data_out => output --uscita totale del sistema
    );
    
    CONT8: cont_mod8 port map(
        clock => CLK,
        reset => temp_rst_count,
        count_in => temp_en_count,
        count => temp_count_in 
    );
    
    UART_B: Rs232RefComp port map(
        TXD =>TXD_n, --non serve perchè sto considerando comunicazione simplex
        RXD =>RXD, --Dall'esterno
        CLK => CLK,
        DBIN => "00000000",-- perchè non serve per trasferire
        DBOUT => temp_DBOUT,
        RDA	=> temp_RDA, --Dall'esterno del nodo
        RD => temp_RD,
        WR=> '0',
        RST => RST
    );
    
   
    --Per debug
    write <= temp_write;
    
end Structural;
