library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- *******************************************************************************
-- MUX 2:1 --

entity mux_2_1 is

	port( 	a0 	: in STD_LOGIC;
			a1 	: in STD_LOGIC;
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
end mux_2_1;


architecture dataflow of mux_2_1 is

	
	begin
		y <= ((a0 and (NOT s)) OR (a1 and s));
		

end dataflow;
