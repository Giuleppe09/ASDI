    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    entity Control_unit_tb is
    end Control_unit_tb;
    
    architecture testbench of Control_unit_tb is
    
        -- Dichiarazione del componente da testare
        component Control_unit
            port ( 
                RST: in std_logic;
                CLK: in std_logic;
                i: in std_logic;
                i_read: in std_logic;
                M: in std_logic;
                m_read: in std_logic;
                i_out: out std_logic;
                m_out: out std_logic
            );
        end component;
    
        -- **Segnali di test**
        signal RST_tb: std_logic := '0';
        signal CLK_tb: std_logic := '0';
        signal i_tb: std_logic := '0';
        signal i_read_tb: std_logic := '0';
        signal M_tb: std_logic := '0';
        signal m_read_tb: std_logic := '0';
        signal i_out_tb: std_logic;
        signal m_out_tb: std_logic;
    
        -- **Periodo del clock**
        constant CLK_PERIOD: time := 10 ns;
    
    begin
    
        -- **Istanziazione della Control Unit**
        UUT: Control_unit 
            port map (
                RST => RST_tb,
                CLK => CLK_tb,
                i => i_tb,
                i_read => i_read_tb,
                M => M_tb,
                m_read => m_read_tb,
                i_out => i_out_tb,
                m_out => m_out_tb
            );
    
        -- **Generazione del clock**
        process
        begin
            while now < 200 ns loop  -- Simulazione per 200 ns
                CLK_tb <= '0';
                wait for CLK_PERIOD / 2;
                CLK_tb <= '1';
                wait for CLK_PERIOD / 2;
            end loop;
            wait; -- Termina la simulazione
        end process;
    
        -- **Stimoli di test**
        process
        begin
            -- **Reset iniziale**
            RST_tb <= '1';
            wait for 20 ns;
            RST_tb <= '0';
            wait for 20 ns;
    
            -- **Test 1: Scrittura nel registro i_out**
            i_tb <= '1';
            i_read_tb <= '1';
            wait for CLK_PERIOD;
            i_read_tb <= '0';
            wait for CLK_PERIOD;
    
            -- **Verifica i_out**
            assert i_out_tb = '1'
            report "Errore: i_out dovrebbe essere '1' dopo i_read" severity error;
    
            -- **Test 2: Scrittura nel registro i_out con valore 0**
            i_tb <= '0';
            i_read_tb <= '1';
            wait for CLK_PERIOD;
            i_read_tb <= '0';
            wait for CLK_PERIOD;
    
            -- **Verifica i_out**
            assert i_out_tb = '0'
            report "Errore: i_out dovrebbe essere '0' dopo i_read" severity error;
    
            -- **Test 3: Scrittura nel registro m_out**
            M_tb <= '1';
            m_read_tb <= '1';
            wait for CLK_PERIOD;
            m_read_tb <= '0';
            wait for CLK_PERIOD;
    
            -- **Verifica m_out**
            assert m_out_tb = '1'
            report "Errore: m_out dovrebbe essere '1' dopo m_read" severity error;
    
            -- **Test 4: Scrittura nel registro m_out con valore 0**
            M_tb <= '0';
            m_read_tb <= '1';
            wait for CLK_PERIOD;
            m_read_tb <= '0';
            wait for CLK_PERIOD;
    
            -- **Verifica m_out**
            assert m_out_tb = '0'
            report "Errore: m_out dovrebbe essere '0' dopo m_read" severity error;
    
            -- **Fine della simulazione**
            report "Test completato con successo!" severity note;
            wait;
        end process;
    
    end testbench;
