library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_ROM_M is
    port(
        CLK : in std_logic;
        read: in std_logic;
        address : in  std_logic_vector(3 downto 0);
        data_out    : out std_logic_vector(3 downto 0)
    );
end entity Sistema_ROM_M;


architecture Sistema of Sistema_ROM_M is

    component ROM is
        port(
            CLK : in std_logic;
            read: in std_logic;
            ADDR : in  std_logic_vector(3 downto 0);
            DATA : out std_logic_vector(7 downto 0)
        );
    end component ROM;

    component RCA_Nbit is
        generic (N: natural range 0 to 32 := 4); -- sto definendo un parametro
        port(
		OP_A_RCA: in std_logic_vector(N-1 downto 0);
		OP_B_RCA: in std_logic_vector(N-1 downto 0);
		CIN_RCA: in std_logic;
		
		S_RCA: out std_logic_vector(N-1 downto 0);
		COUT_RCA: out std_logic;
		OV: out std_logic
	);
    end component RCA_Nbit;

signal rom_data_out : std_logic_vector(7 downto 0);
signal cout_int: std_logic;
signal ov_int: std_logic;

begin
    ROM_16: ROM port map (
        CLK => clk,
        read => read,
        ADDR => address, --mappo l'ingresso della ROM all'ingresso del sistema
				--quando un indirizzo viene fornito al sistema, viene passato alla ROM
        DATA => rom_data_out --i dati in uscita dalla ROM vengono passati al segnale
    );

    RCA_M: RCA_Nbit port map (
    
        OP_A_RCA => rom_data_out(7 downto 4), 
        OP_B_RCA => rom_data_out(3 downto 0),  
        CIN_RCA => '0', --perchè non ho riporto entrante nel primo full adder
        
        S_RCA => data_out, --uscita del sistema
        COUT_RCA => cout_int,--ultimo riporto (non lo consideriamo)
        OV => ov_int --overflow
        
    );

end architecture Sistema;