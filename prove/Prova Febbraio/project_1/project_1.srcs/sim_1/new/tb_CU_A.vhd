library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_cu_A is
end tb_cu_A;

architecture Behavioral of tb_cu_A is
    signal start: std_logic := '0';
    signal CLK: std_logic := '0';
    signal RST: std_logic := '0';
    signal REQ_out: std_logic;
    signal ACK_in: std_logic := '0';
    signal REQ_in: std_logic := '0';
    signal ACK_out: std_logic;
    signal count_in: std_logic_vector(2 downto 0) := "000";
    signal ris: std_logic := '0';
    signal rst_count: std_logic;
    signal en_count: std_logic;
    signal write: std_logic;
    signal start_T: std_logic;
    signal reset_T: std_logic;
    signal stato: std_logic_vector(2 downto 0);
    
    constant CLK_period: time := 10 ns;
    
    -- Istanza della unità di controllo
    component cu_A
        Port ( start: in std_logic;
               CLK: in std_logic;
               RST: in std_logic;
               REQ_out: out std_logic;
               ACK_in: in std_logic;
               REQ_in: in std_logic;
               ACK_out: out std_logic;
               count_in: in std_logic_vector(2 downto 0);
               ris: in std_logic;
               rst_count: out std_logic;
               en_count: out std_logic;
               write: out std_logic;
               start_T: out std_logic;
               reset_T: out std_logic;
               stato: out std_logic_vector(2 downto 0));
    end component;
    
begin
    -- Collegamento del DUT
    uut: cu_A port map (
        start => start,
        CLK => CLK,
        RST => RST,
        REQ_out => REQ_out,
        ACK_in => ACK_in,
        REQ_in => REQ_in,
        ACK_out => ACK_out,
        count_in => count_in,
        ris => ris,
        rst_count => rst_count,
        en_count => en_count,
        write => write,
        start_T => start_T,
        reset_T => reset_T,
        stato => stato
    );
    
    -- Processo di clock
    process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_period / 2;
            CLK <= '1';
            wait for CLK_period / 2;
        end loop;
    end process;
    
    -- Stimoli
    process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- Avvio della macchina
        start <= '1';
        wait for CLK_period;
        start <= '0';
        wait for 30 ns;
        
        -- Simula handshake
        ACK_in <= '1';
        wait for CLK_period;
        ACK_in <= '0';
        wait for 20 ns;
        
        REQ_in <= '1';
        wait for CLK_period;
        REQ_in <= '0';
        
        -- Simula verifica comparatore
        ris <= '1';
        wait for CLK_period;
        ris <= '0';
        
        -- Simula conteggio fino a 7
        for i in 0 to 7 loop
            count_in <= std_logic_vector(conv_unsigned(i, 3));
            wait for CLK_period;
        end loop;
        
        -- Termina la simulazione
        wait for 50 ns;
        assert false report "Test completo!" severity failure;
    end process;
    
end Behavioral;
