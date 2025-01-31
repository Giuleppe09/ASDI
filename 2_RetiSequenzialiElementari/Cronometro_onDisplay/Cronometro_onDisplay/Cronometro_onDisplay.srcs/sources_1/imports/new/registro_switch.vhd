library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_acq is
    generic(
        N: integer := 8 -- Dimensione del registro
    );
    port(
        CLK: in std_logic;
        RST: in std_logic;
        load: in std_logic; -- Segnale di caricamento (pulsante o trigger)
        data_in: in std_logic_vector(N-1 downto 0);
        data_out: out std_logic_vector(N-1 downto 0)
    );
end registro_acq;

architecture Behavioral of registro_acq is

    signal temp_data: std_logic_vector(N-1 downto 0);     
    signal load_reg: std_logic := '0'; -- Registra il valore precedente di load

begin

    reg: process(CLK)
    begin
        if rising_edge(CLK) then
            if (RST = '1') then
                temp_data <= (others => '0');
            elsif (load = '1' and load_reg = '0') then -- Rilevamento del fronte di salita di load
                temp_data <= data_in;
            end if;
            load_reg <= load; -- Salva lo stato attuale di load per il prossimo ciclo
        end if;
    end process;
    
    data_out <= temp_data;

end Behavioral;
