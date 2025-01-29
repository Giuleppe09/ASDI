library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity RETE_16_4_tb is
end;

architecture bench of RETE_16_4_tb is

  component RETE_16_4
      Port ( 
          A : in std_logic_vector(15 downto 0);
          S_mux : in std_logic_vector(3 downto 0);
          S_demux : in std_logic_vector(1 downto 0);
          Y : out std_logic_vector(3 downto 0)
      );
  end component;

  -- Segnali di test
  signal A_tb: std_logic_vector(15 downto 0);
  signal S_mux_tb: std_logic_vector(3 downto 0);
  signal S_demux_tb: std_logic_vector(1 downto 0);
  signal Y_tb: std_logic_vector(3 downto 0);

begin

  -- Unit Under Test (UUT)
  UUT: RETE_16_4 port map ( 
      A => A_tb,
      S_mux => S_mux_tb,
      S_demux => S_demux_tb,
      Y => Y_tb
  );

  stimulus: process
  begin
  
    -- Inizializzazione
    wait for 100 ns;
    
    -- Test Case 1: Verifica routing primo bit verso prima uscita
    A_tb <= "1010101010101010";  -- Alterniamo 1 e 0
    S_mux_tb <= "0000";          -- Seleziona il primo bit (0)
    S_demux_tb <= "00";          -- Prima uscita
    wait for 10 ns;
    -- Output atteso: "0001" perché il primo bit è 0
    
    -- Test Case 2: Verifica routing primo bit verso seconda uscita
    S_demux_tb <= "01";          -- Seconda uscita
    wait for 10 ns;
    -- Output atteso: "0010"
    
    -- Test Case 3: Verifica secondo bit verso terza uscita
    S_mux_tb <= "0001";          -- Seleziona il secondo bit (1)
    S_demux_tb <= "10";          -- Terza uscita
    wait for 10 ns;
    -- Output atteso: "0100"
    
    -- Test Case 4: Verifica ultimo bit verso ultima uscita
    S_mux_tb <= "1111";          -- Seleziona l'ultimo bit
    S_demux_tb <= "11";          -- Ultima uscita
    wait for 10 ns;
    -- Output atteso: "1000"
    
    -- Test Case 5: Cambio pattern di input
    A_tb <= "1111000011110000";
    S_mux_tb <= "0111";          -- Seleziona il bit 7
    S_demux_tb <= "01";          -- Seconda uscita
    wait for 10 ns;
    
    -- Test Case 6: Verifica bit centrali
    A_tb <= "0000111100001111";
    S_mux_tb <= "1000";          -- Seleziona il bit 8
    S_demux_tb <= "10";          -- Terza uscita
    wait for 10 ns;
    
    -- Test Case 7: Verifica pattern alternati
    A_tb <= "0101010101010101";
    for i in 0 to 3 loop
        S_mux_tb <= std_logic_vector(to_unsigned(i, 4));
        S_demux_tb <= std_logic_vector(to_unsigned(i mod 4, 2));
        wait for 10 ns;
    end loop;
    
    -- Test Case 8: Verifica tutti zeri
    A_tb <= "0000000000000000";
    S_mux_tb <= "1010";          -- Bit 10
    S_demux_tb <= "11";          -- Ultima uscita
    wait for 10 ns;
    
    -- Test Case 9: Verifica tutti uni
    A_tb <= "1111111111111111";
    S_mux_tb <= "0101";          -- Bit 5
    S_demux_tb <= "00";          -- Prima uscita
    wait for 10 ns;
    
    -- Test Case 10: Pattern complesso
    A_tb <= "1100110011001100";
    for i in 0 to 3 loop
        S_mux_tb <= std_logic_vector(to_unsigned(i*4, 4));
        S_demux_tb <= std_logic_vector(to_unsigned(3-i mod 4, 2));
        wait for 10 ns;
    end loop;

    wait;
  end process;

end bench;