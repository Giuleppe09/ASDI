
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Nodo_B is
    Port (  
        CLK   : in  std_logic;
        RST   : in  std_logic;
        REQ   : in std_logic;
        ACK   : out  std_logic;
        BUS_in: in std_logic_vector(3 downto 0);
        
        --per debug
        output: out std_logic_vector(3 downto 0);
        --read: out std_logic;
        write: out std_logic;
        stato: out std_logic_vector(1 downto 0)
    );
end Nodo_B;

architecture Structural of Nodo_B is

    component cu_B is
        Port ( 
            --Segnali esterni.
            CLK: in std_logic;
            RST: in std_logic; -- che poi resetta il registro (?)
            
            --Segnali Per Handshaking completo
            REQ_in: in std_logic;
            ACK_out: out std_logic; 
            
           
            
            write: out std_logic; --Da dare al registro accumulatore
            --per debug
            stato: out std_logic_vector(1 downto 0)
        );
    end component;
    
    component mem_out is
        port(
            CLK: in std_logic;
            RST: in std_logic;
            
            write: in std_logic; -- Segnale di scrittura
         
            data_in: in std_logic_vector(3 downto 0);
            data_out: out std_logic_vector(3 downto 0)
        );
    end component;
    
    component RCA_Nbit is
        generic (N: natural range 0 to 32 := 4); -- sto definendo un parametro
        port(
            OP_A_RCA: in std_logic_vector(N-1 downto 0);
            OP_B_RCA: in std_logic_vector(N-1 downto 0);
            CIN_RCA: in std_logic; -- 0
            
            S_RCA: out std_logic_vector(N-1 downto 0);
            COUT_RCA: out std_logic;
            OV: out std_logic
        );
	end component;
	
	--per mem
	signal temp_read: std_logic;
	signal temp_write: std_logic;
	--per counter
	signal temp_rst_count: std_logic;
	signal temp_en_count: std_logic;
	signal temp_count_in: std_logic_vector(1 downto 0);
	--per adder
	signal temp_cout: std_logic;
	signal temp_ov: std_logic;
	signal temp_Y: std_logic_vector(3 downto 0);
	signal temp_S: std_logic_vector(3 downto 0);
	
begin

    Control_unit_B:cu_B port map(
        --Segnali esterni.
        CLK => CLK,
        RST => RST,
        
        --Segnali Per Handshaking completo
        REQ_in => REQ,
        ACK_out => ACK,
        
      
        write => temp_write,
        --per debug
        stato => stato
    );
    
    MEM: mem_out port map(
        CLK => CLK,
        RST => RST,
     
        write => temp_write,
        
        data_in => temp_S,
        data_out => temp_Y 
    );
    
   
    
    ADDER: RCA_Nbit port map( -- Da cambiare con il carry look ahead
            OP_A_RCA => BUS_in,
            OP_B_RCA => temp_Y,
            CIN_RCA => '0',
            
            S_RCA => temp_S,
            COUT_RCA => temp_cout,
            OV => temp_ov
        );
    
    
    output <= temp_Y;
    write <= temp_write;
    
end Structural;
