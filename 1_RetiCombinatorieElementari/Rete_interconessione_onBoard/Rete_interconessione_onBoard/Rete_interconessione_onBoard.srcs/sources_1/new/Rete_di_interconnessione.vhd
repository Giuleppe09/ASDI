
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rete_board is
    port ( 
        
        clock: in std_logic;
        RST: in std_logic;
        --bottoni
        load_first_input: in std_logic;
        load_second_input: in std_logic;
        load_indirizzamento: in std_logic;
        --input
        data_in8: in std_logic_vector(7 downto 0);
        sel_MUX_in:in std_logic_vector(3 downto 0);
        sel_DEMUX_in: in std_logic_vector(1 downto 0);
        --output
        LED: out std_logic_vector(3 downto 0)
        
    );
end Rete_board;

architecture Structural of Rete_board is

    component Control_unit is 
        port ( 
        
        clock: in std_logic;
        RST: in std_logic;
        --bottoni
        load_first_input: in std_logic;
        load_second_input: in std_logic;
        load_indirizzamento: in std_logic;
        --input
        data_in8: in std_logic_vector(7 downto 0);
        sel_MUX_in:in std_logic_vector(3 downto 0);
        sel_DEMUX_in: in std_logic_vector(1 downto 0);
        --output
        data_out16: out std_logic_vector(15 downto 0);
        sel_MUX_out: out std_logic_vector(3 downto 0);
        sel_DEMUX_out: out std_logic_vector(1 downto 0)
        
    );
    
    end component;
    
    component RETE_16_4 is
        port ( 
        A : in std_logic_vector(15 downto 0); --Ingressi del mio MUX
        S_mux : in std_logic_vector(3 downto 0);  --Selezioni del mio MUX
        S_demux : in std_logic_vector(1 downto 0);  --Selezione del mio DEMUX
        Y : out std_logic_vector(3 downto 0) --Uscite del mio DEMUX
    );
    end component;
    
    --Segnali di appoggio
    signal data_in: std_logic_vector(15 downto 0);
    signal sel_MUX: std_logic_vector(3 downto 0);
    signal sel_DEMUX: std_logic_vector(1 downto 0);
    
begin

    --istanziazione
    CU: Control_unit port map(
    
        clock => clock,
        RST => RST,
        load_first_input => load_first_input,
        load_second_input => load_second_input,
        load_indirizzamento =>load_indirizzamento,
        data_in8 => data_in8,
        sel_MUX_in => sel_MUX_in,
        sel_DEMUX_in => sel_DEMUX_in,
        --Le uscite della control unit sono mappate nei segnali di appoggio
        data_out16=> data_in,
        sel_MUX_out=> sel_MUX,
        sel_DEMUX_out=> sel_DEMUX
    );
    RI: Rete_16_4 port map(
    
        A => data_in,
        S_mux => sel_MUX,
        S_demux => sel_DEMUX,
        Y => LED --Y di tutta la rete Board
    );
end Structural;
