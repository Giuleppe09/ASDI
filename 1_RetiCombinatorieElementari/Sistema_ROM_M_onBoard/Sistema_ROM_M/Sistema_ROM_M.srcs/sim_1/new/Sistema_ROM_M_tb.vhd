library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_Sistema_ROM_M is
end entity TB_Sistema_ROM_M;

architecture test of TB_Sistema_ROM_M is
    -- Component under test (CUT)
    component Sistema_ROM_M
        port(
            address_in : in  std_logic_vector(3 downto 0);
            data_out   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali di test
    signal address_in_tb : std_logic_vector(3 downto 0);
    signal data_out_tb   : std_logic_vector(3 downto 0);

begin
    -- Istanza del componente sotto test
    DUT: Sistema_ROM_M port map (
        address_in => address_in_tb,
        data_out   => data_out_tb
    );

    -- Processo di stimolo
    stim_proc: process
    begin
        -- Test 1: Indirizzo 0000
        address_in_tb <= "0000";
        wait for 10 ns;

        -- Test 2: Indirizzo 0001
        address_in_tb <= "0001";
        wait for 10 ns;

        -- Test 3: Indirizzo 0010
        address_in_tb <= "0010";
        wait for 10 ns;

        -- Test 4: Indirizzo 0011
        address_in_tb <= "0011";
        wait for 10 ns;

        -- Test 5: Indirizzo 0100
        address_in_tb <= "0100";
        wait for 10 ns;

        -- Test 6: Indirizzo 0101
        address_in_tb <= "0101";
        wait for 10 ns;

        -- Test 7: Indirizzo 0110
        address_in_tb <= "0110";
        wait for 10 ns;

        -- Test 8: Indirizzo 0111
        address_in_tb <= "0111";
        wait for 10 ns;

        -- Test 9: Indirizzo 1000
        address_in_tb <= "1000";
        wait for 10 ns;

        -- Test 10: Indirizzo 1111
        address_in_tb <= "1111";
        wait for 10 ns;

        -- Fine simulazione
        wait;
    end process;
end architecture test;
