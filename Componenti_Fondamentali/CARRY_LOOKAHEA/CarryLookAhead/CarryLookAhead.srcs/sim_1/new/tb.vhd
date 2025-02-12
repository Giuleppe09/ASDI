library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Top_CarryLookAhead is
end tb_Top_CarryLookAhead;

architecture behavior of tb_Top_CarryLookAhead is

    -- Dichiarazione dei segnali di test
    signal x, y : std_logic_vector(3 downto 0); -- Test con 4 bit
    signal c_in : std_logic;
    signal S : std_logic_vector(3 downto 0);
    signal c_out : std_logic;

    -- Dichiarazione del componente da testare
    component Top_CarryLookAhead is
        generic (N: integer);
        Port(
            x, y : in std_logic_vector(N-1 downto 0);
            c_in : in std_logic;
            S : out std_logic_vector(N-1 downto 0);
            c_out : out std_logic
        );
    end component;

begin

    -- Istanza del componente da testare
    uut: Top_CarryLookAhead
        generic map(N => 4) -- Per esempio, 4 bit
        port map(
            x => x,
            y => y,
            c_in => c_in,
            S => S,
            c_out => c_out
        );

    -- Processo di stimolo per testare
    stim_proc: process
    begin
        -- Test 1: Somma di due numeri senza riporto
        x <= "0001"; -- 1 in binario
        y <= "0010"; -- 2 in binario
        c_in <= '0'; -- Riporto entrante 0
        wait for 10 ns; -- Attendere un intervallo di tempo
        assert (S = "0011" and c_out = '0') report "Test 1 fallito!" severity error;

        -- Test 2: Somma di due numeri con riporto
        x <= "1101"; -- 13 in binario
        y <= "0111"; -- 7 in binario
        c_in <= '0'; -- Riporto entrante 0
        wait for 10 ns;
        assert (S = "0100" and c_out = '1') report "Test 2 fallito!" severity error;

        -- Test 3: Somma con riporto entrante
        x <= "1010"; -- 10 in binario
        y <= "1011"; -- 11 in binario
        c_in <= '1'; -- Riporto entrante 1
        wait for 10 ns;
        assert (S = "01101" and c_out = '1') report "Test 3 fallito!" severity error;

        -- Test 4: Somma con tutti zeri
        x <= "0000"; -- 0 in binario
        y <= "0000"; -- 0 in binario
        c_in <= '0'; -- Riporto entrante 0
        wait for 10 ns;
        assert (S = "0000" and c_out = '0') report "Test 4 fallito!" severity error;

        -- Test 5: Somma con carry out finale
        x <= "1111"; -- 15 in binario
        y <= "0001"; -- 1 in binario
        c_in <= '1'; -- Riporto entrante 1
        wait for 10 ns;
        assert (S = "0001" and c_out = '1') report "Test 5 fallito!" severity error;

        -- Fine dei test
        wait;
    end process;

end behavior;
