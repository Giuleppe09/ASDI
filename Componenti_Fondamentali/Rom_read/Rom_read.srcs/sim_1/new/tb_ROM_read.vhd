library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM_TB is
end ROM_TB;

architecture testbench of ROM_TB is

    -- Dichiarazione del componente ROM
    component ROM
        port(
            CLK  : in std_logic;
            read : in std_logic;
            ADDR : in std_logic_vector(1 downto 0);
            DATA : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali di test
    signal CLK_tb  : std_logic := '0';
    signal read_tb : std_logic := '0';
    signal ADDR_tb : std_logic_vector(1 downto 0) := "00";
    signal DATA_tb : std_logic_vector(3 downto 0);

begin
    -- Istanziare la ROM
    uut: ROM port map (
        CLK  => CLK_tb,
        read => read_tb,
        ADDR => ADDR_tb,
        DATA => DATA_tb
    );

    -- Processo per generare il clock
    process
    begin
        while true loop
            CLK_tb <= '0';
            wait for 5 ns;
            CLK_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Processo di test
    process
    begin
        wait for 10 ns;
        read_tb <= '1'; -- Abilita la lettura
        
        ADDR_tb <= "00"; wait for 10 ns;
        ADDR_tb <= "01"; wait for 10 ns;
        ADDR_tb <= "10"; wait for 10 ns;
        ADDR_tb <= "11"; wait for 10 ns;

        read_tb <= '0'; -- Disabilita la lettura
        wait for 20 ns;

        -- Terminare la simulazione
        wait;
    end process;
end testbench;
