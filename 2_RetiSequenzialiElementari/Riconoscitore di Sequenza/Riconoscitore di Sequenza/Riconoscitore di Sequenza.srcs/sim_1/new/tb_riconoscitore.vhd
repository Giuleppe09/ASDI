LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY TB_RICONOSCITORE_DI_SEQ IS
END TB_RICONOSCITORE_DI_SEQ;

ARCHITECTURE behavior OF TB_RICONOSCITORE_DI_SEQ IS 
    
    -- Component della UUT (Unit Under Test)
    COMPONENT RICONOSCITORE_DI_SEQ
    PORT(
         i    : IN  std_logic;
         RST  : IN  std_logic;
         CLK  : IN  std_logic;
         M    : IN  std_logic;
         Y    : OUT std_logic;
         state: OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
    -- Segnali per la simulazione
    SIGNAL i    : std_logic := '0';
    SIGNAL RST  : std_logic := '0';
    SIGNAL CLK  : std_logic := '0';
    SIGNAL M    : std_logic := '0';
    SIGNAL Y    : std_logic;
    SIGNAL state: std_logic_vector(3 downto 0);
    
    -- Periodo del clock
    CONSTANT CLK_PERIOD : time := 10 ns;
    
BEGIN
    
    -- Istanza della UUT
    uut: RICONOSCITORE_DI_SEQ PORT MAP (
          i    => i,
          RST  => RST,
          CLK  => CLK,
          M    => M,
          Y    => Y,
          state=> state
        );
    
    -- Processo per generare il clock
    clk_process :process
    begin
        while now < 500 ns loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;
    
    -- Processo Stimolo
    stim_proc: process
    begin    
        -- Reset iniziale
        RST <= '1';
        wait for 2*CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;
        
        -- Test con M = 0, sequenza 101
        M <= '0';
        i <= '1';
        wait for CLK_PERIOD;
        i <= '0';
        wait for CLK_PERIOD;
        i <= '1';
        wait for CLK_PERIOD;
        
        -- Test con M = 1, sequenza 110
        M <= '1';
        wait for CLK_PERIOD;
        i <= '1';
        wait for CLK_PERIOD;
        i <= '1';
        wait for CLK_PERIOD;
        i <= '0';
        wait for CLK_PERIOD;
        
        -- Test con reset intermedio
        RST <= '1';
        wait for CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;
        
        -- Sequenza aggiuntiva per validazione
        i <= '1';
        wait for CLK_PERIOD;
        i <= '0';
        wait for CLK_PERIOD;
        i <= '1';
        wait for CLK_PERIOD;
        
        wait;
    end process;

END behavior;
