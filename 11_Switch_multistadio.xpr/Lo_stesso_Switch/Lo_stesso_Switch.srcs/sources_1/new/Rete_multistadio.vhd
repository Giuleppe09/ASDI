

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rete_multistadio is
    Port ( 
        x1 : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        x2 : in std_logic_vector(1 downto 0);
        x3 : in std_logic_vector(1 downto 0);
        x4 : in std_logic_vector(1 downto 0);
        
        y1 : out STD_LOGIC_VECTOR(1 downto 0);
        y2 : out STD_LOGIC_VECTOR(1 downto 0);
        y3 : out STD_LOGIC_VECTOR(1 downto 0);
        y4 : out STD_LOGIC_VECTOR(1 downto 0);
        
        S_mux,S_demux: in STD_LOGIC_VECTOR(1 downto 0)
        
    );
end Rete_multistadio;

architecture Structural of Rete_multistadio is

    component Nodo_sw is
    Port ( 
        A : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        B : in std_logic_vector(1 downto 0);
        S_mux : in std_logic;
        S_demux : in STD_LOGIC;
        Y_a : out STD_LOGIC_VECTOR(1 downto 0);
        Y_b : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;
    
    signal link_out00: std_logic_vector(1 downto 0);
    signal link_out01: std_logic_vector(1 downto 0);
    signal link_out10: std_logic_vector(1 downto 0);
    signal link_out11: std_logic_vector(1 downto 0);
begin
    --Primo stadio
    Switch1 : Nodo_sw port map(
        A => x1,
        B => x2,
        S_mux => S_mux(0),
        S_demux => S_demux(1),
        Y_a => link_out00,
        Y_b => link_out01
    );
    
    Switch2 : Nodo_sw port map(
        A => x3,
        B => x4,
        S_mux => S_mux(0),
        S_demux => S_demux(1),
        Y_a => link_out10,
        Y_b => link_out11
    );
    
    --Secondo stadio
    Switch3 : Nodo_sw port map(
        A => link_out00,
        B => link_out10,
        S_mux => S_mux(1),
        S_demux => S_demux(0),
        Y_a => y1,
        Y_b => y2
    );
    
    Switch4 : Nodo_sw port map(
        A => link_out01,
        B => link_out11,
        S_mux => S_mux(1),
        S_demux => S_demux(0),
        Y_a => y3,
        Y_b => y4
    );


end Structural;
