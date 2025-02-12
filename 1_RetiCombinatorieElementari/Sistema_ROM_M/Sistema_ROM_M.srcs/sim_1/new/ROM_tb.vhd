library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ROM_tb is
end ROM_tb;

architecture tb of ROM_tb is
    -- Component declaration
    component ROM
        port(
            RST  : in std_logic;
            ADDR : in std_logic_vector(3 downto 0);
            DATA : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal RST_tb  : std_logic := '0';
    signal ADDR_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal DATA_tb : std_logic_vector(7 downto 0);

begin
    -- Instantiate the ROM
    UUT: ROM port map (
        RST  => RST_tb,
        ADDR => ADDR_tb,
        DATA => DATA_tb
    );

    -- Stimulus process
    process
    begin
        -- Test 1: Reset attivo, deve restituire la prima locazione ("00000000")
        RST_tb <= '1';
        ADDR_tb <= "0001";  -- Un valore arbitrario per verificare che il reset lo ignori
        wait for 10 ns;
        
        -- Test 2: Disattiviamo il reset e leggiamo tutti gli indirizzi
        RST_tb <= '0';
        
        for i in 0 to 15 loop
            ADDR_tb <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        -- Test concluso
        wait;
    end process;
end tb;
