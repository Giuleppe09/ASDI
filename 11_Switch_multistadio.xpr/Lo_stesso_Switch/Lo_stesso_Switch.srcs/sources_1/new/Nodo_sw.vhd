
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo_sw is
    Port ( 
        A : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        B : in std_logic_vector(1 downto 0);
        S_mux : in std_logic;
        S_demux : in std_logic;
        Y_a : out STD_LOGIC_VECTOR(1 downto 0);
        Y_b : out STD_LOGIC_VECTOR(1 downto 0)
    );
end Nodo_sw;

architecture Structural of Nodo_sw is

    component mux_2_1 is
    port(
        A : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        B : in std_logic_vector(1 downto 0);
        S : in std_logic;                    -- Selettore
        Y : out std_logic_vector(1 downto 0) -- Uscita
    );
    end component;
    
    component Demux_1_2 is
    PORT(
        A : in STD_LOGIC_VECTOR(1 downto 0);
        S : in std_logic;
        Y_a : out STD_LOGIC_VECTOR(1 downto 0);
        Y_b : out STD_LOGIC_VECTOR(1 downto 0)
	);
    end component;
    
    --Segnale d'appogio
    signal link_sw: STD_LOGIC_VECTOR(1 downto 0);
    
begin
    
    --istanziazione 
    MUX: mux_2_1 port map(
        A => A,
        B => B,
        S => S_mux,     -- Selettore mux
        Y => link_sw    -- Uscita mux
    );
    
    --istanziazione 
    DEMUX: Demux_1_2 port map(
        A => link_sw,   -- Uscita mux
        S => S_demux,   -- Selettore demux
        Y_a => Y_a,
        Y_b => Y_b
    );


end Structural;
