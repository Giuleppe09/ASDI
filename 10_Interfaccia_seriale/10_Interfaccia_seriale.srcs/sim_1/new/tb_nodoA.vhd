library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Nodo_A is
end tb_Nodo_A;

architecture Behavioral of tb_Nodo_A is

    component Nodo_A
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            RXD   : in  std_logic;
            TXD   : out std_logic;
            stato: out std_logic_vector(2 downto 0);
            read: out std_logic;
            WR_deb: out std_logic;
            TBE_deb: out std_logic
        );
    end component;
    
    signal CLK   : std_logic := '0';
    signal RST   : std_logic := '0';
    signal START : std_logic := '0';
    signal RXD   : std_logic := '1';
    signal TXD   : std_logic;
    signal stato : std_logic_vector(2 downto 0);
    signal read  : std_logic;
    signal WR : std_logic;
    signal TBE: std_logic;
    
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Istanza del nodo A
    uut: Nodo_A port map (
        CLK   => CLK,
        RST   => RST,
        START => START,
        RXD   => RXD,
        TXD   => TXD,
        stato => stato,
        read  => read,
        WR_deb => WR,
        tbe_deb => tbe
        
    );
    
    -- Processo per generare il clock
    process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;
    
    -- Stimoli di test
    process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- Avvio della comunicazione
        START <= '1';
        wait for 20 ns;
        START <= '0';
        
        -- Simulazione della ricezione dati sulla linea RXD
        RXD <= '0';
        wait for 50 ns;
        RXD <= '1';
        wait for 50 ns;
        
        -- Attendere la trasmissione
        wait for 500 ns;
        
        -- Fine della simulazione
        wait;
    end process;
    
end Behavioral;
