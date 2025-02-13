library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mem_out is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        read : in std_logic; --segnale di lettura
        write: in std_logic; -- Segnale di scrittura
        ADDR : in std_logic_vector(1 downto 0);
        data_in: in std_logic_vector(3 downto 0);
        data_out: out std_logic_vector(3 downto 0)
    );
end mem_out;

architecture Behavioral of mem_out is
    type mem_type is array (0 to 3) of std_logic_vector(3 downto 0);
    signal MEM : mem_type := (others => (others => '0')); -- Inizializza tutta la memoria a 0
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then  -- Reset sincrono: azzera tutta la memoria
                for i in 0 to 3 loop
                    MEM(i) <= (others => '0');
                end loop;
            elsif write = '1' then  -- Scrittura sincrona
                MEM(conv_integer(ADDR)) <= data_in;
            end if;
        end if;
    end process;
    
    -- Lettura sincrona (se richiesta), altrimenti può essere diretta
    data_out <= MEM(conv_integer(ADDR));

end Behavioral;
