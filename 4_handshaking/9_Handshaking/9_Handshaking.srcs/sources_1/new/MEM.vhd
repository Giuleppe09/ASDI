library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mem_out is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        write: in std_logic;  -- Segnale di scrittura
        data_in: in std_logic_vector(3 downto 0);
        data_out: out std_logic_vector(3 downto 0)
    );
end mem_out;

architecture Behavioral of mem_out is
    signal MEM: std_logic_vector(3 downto 0) := (others => '0'); -- Registro a 4 bit
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then  -- Reset sincrono: azzera il registro
                MEM <= (others => '0');
            elsif write = '1' then  -- Scrittura sincrona
                MEM <= data_in;
            end if;
        end if;
    end process;

    -- Uscita sempre uguale al valore salvato nel registro
    data_out <= MEM;

end Behavioral;
