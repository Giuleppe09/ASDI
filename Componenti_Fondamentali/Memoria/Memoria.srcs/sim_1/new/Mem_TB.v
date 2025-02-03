library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_mem_out is
end tb_mem_out;

architecture testbench of tb_mem_out is
    -- Dichiarazione della componente da testare
    component mem_out
        port(
            CLK: in std_logic;
            RST: in std_logic;
            write: in std_logic;
            ADDR : in std_logic_vector(3 downto 0);
            data_in: in std_logic_vector(3 downto 0);
            data_out: out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali di test
    signal CLK     : std_logic := '0';
    signal RST     : std_logic := '0';
    signal write   : std_logic := '0';
    signal ADDR    : std_logic_vector(3 downto 0) := (others => '0');
    signal data_in : std_logic_vector(3 downto 0) := (others => '0');
    signal data_out: std_logic_vector(3 downto 0);

    -- Definizione del periodo di clock
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Istanziazione del DUT (Device Under Test)
    uut: mem_out
        port map(
            CLK     => CLK,
            RST     => RST,
            write   => write,
            ADDR    => ADDR,
            data_in => data_in,
            data_out => data_out
        );

    -- Processo per generare il clock
    process
    begin
        while now < 200 ns loop  -- Limitiamo il tempo totale di simulazione
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Processo di stimolo
    process
    begin
        -- 1. Reset iniziale
        RST <= '1';
        wait for CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;

        -- 2. Scrittura di alcuni valori in memoria
        write <= '1';
        
        ADDR    <= "0000"; data_in <= "1010"; wait for CLK_PERIOD; -- Scrivi 1010 all'indirizzo 0
        ADDR    <= "0001"; data_in <= "1100"; wait for CLK_PERIOD; -- Scrivi 1100 all'indirizzo 1
        ADDR    <= "0010"; data_in <= "1111"; wait for CLK_PERIOD; -- Scrivi 1111 all'indirizzo 2
        
        -- Disattiva la scrittura
        write <= '0';
        wait for CLK_PERIOD;

        -- 3. Lettura dei valori scritti
        ADDR <= "0000"; wait for CLK_PERIOD;
        assert data_out = "1010" report "Errore: lettura errata da ADDR 0000" severity error;
        
        ADDR <= "0001"; wait for CLK_PERIOD;
        assert data_out = "1100" report "Errore: lettura errata da ADDR 0001" severity error;

        ADDR <= "0010"; wait for CLK_PERIOD;
        assert data_out = "1111" report "Errore: lettura errata da ADDR 0010" severity error;

        -- 4. Sovrascrittura di un valore esistente
        write <= '1';
        ADDR <= "0001"; data_in <= "0110"; wait for CLK_PERIOD; -- Sovrascrive 1100 con 0110
        write <= '0';
        wait for CLK_PERIOD;
        
        -- Verifica della sovrascrittura
        ADDR <= "0001"; wait for CLK_PERIOD;
        assert data_out = "0110" report "Errore: sovrascrittura fallita su ADDR 0001" severity error;

        -- 5. Test Reset dopo scritture
        RST <= '1'; 
        wait for CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;
        
        -- Verifica che la memoria sia stata azzerata
        ADDR <= "0000"; wait for CLK_PERIOD;
        assert data_out = "0000" report "Errore: reset non ha azzerato ADDR 0000" severity error;

        ADDR <= "0001"; wait for CLK_PERIOD;
        assert data_out = "0000" report "Errore: reset non ha azzerato ADDR 0001" severity error;

        ADDR <= "0010"; wait for CLK_PERIOD;
        assert data_out = "0000" report "Errore: reset non ha azzerato ADDR 0010" severity error;

        -- Fine test
        report "Test completato con successo!";
        wait;
    end process;

end testbench;
