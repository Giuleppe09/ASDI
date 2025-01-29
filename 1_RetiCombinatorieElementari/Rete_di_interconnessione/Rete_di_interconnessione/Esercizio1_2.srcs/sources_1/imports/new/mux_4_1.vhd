library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1 is 
	port(	B : in std_logic_vector(3 downto 0);
			--si poteva fare pure con un std_vector
			S_int : in std_logic_vector(1 downto 0);
			Y_int : out STD_LOGIC
		);		
end mux_4_1;

-- Definizione architettura del modulo mux_4_1 con una descrizione strutturale.
architecture structural of mux_4_1 is

	signal u : std_logic_vector(1 downto 0);

	component mux_2_1
		port(	a0 	: in STD_LOGIC;
				a1 	: in STD_LOGIC;
				s 	: in STD_LOGIC;
				y 	: out STD_LOGIC
			);	
	end component;

	begin
	
		mux0: mux_2_1 
			Port map(	a0 	=> B(0),
						a1 	=> B(1),
						s 	=> S_int(0),
						y 	=> u(0)
					);
		mux1: mux_2_1
			Port map(	a0 	=> B(2),
						a1 	=> B(3),
						s 	=> S_int(0),
						y 	=> u(1)
					);
		mux2: mux_2_1
			Port map(	a0 	=> u(0),
						a1 	=> u(1),
						s 	=> S_int(1),
						y 	=> Y_int
				);
end structural;