library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Demux_1_2 is
    PORT(
			A : in STD_LOGIC_VECTOR(1 downto 0);
			S : in STD_LOGIC;
			Y_a : out STD_LOGIC_VECTOR(1 downto 0);
			Y_b : out STD_LOGIC_VECTOR(1 downto 0)
	);
end Demux_1_2;

architecture Behavioral of Demux_1_2 is
begin
    process(A, S)
    begin
        if S = '0' then
            Y_a <= A; -- Se S è '0', fa uscire il dato in Y_a
        else
            Y_b <= A; -- Se S è '1', fa uscire il dato in Y_b
        end if;
    end process;
end Behavioral;
