library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_Sistema_ROM_M is
end entity TB_Sistema_ROM_M;

architecture TB of TB_Sistema_ROM_M is
    
    component Sistema_ROM_M is
        port(
            address : in  std_logic_vector(3 downto 0);
            data_out : out std_logic_vector(3 downto 0)
        );
    end component Sistema_ROM_M;
    
    signal address_tb  : std_logic_vector(3 downto 0);
    signal data_out_tb : std_logic_vector(3 downto 0);
    
begin
    
    DUT: Sistema_ROM_M port map (
        address  => address_tb,
        data_out => data_out_tb
    );
    
    process
    begin
        -- Test diversi indirizzi
        for i in 0 to 15 loop
            address_tb <= std_logic_vector(conv_unsigned(i, 4));
            wait for 10 ns; -- Attendi tempo sufficiente per la risposta
        end loop;
        
        -- Fine test
        wait;
    end process;
    
end architecture TB;
