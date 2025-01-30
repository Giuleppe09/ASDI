----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2024
-- Design Name: 
-- Module Name: tb_riconoscitore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench per il riconoscitore di sequenze
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_riconoscitore is
end;

architecture test of tb_riconoscitore is

    -- Component da testare
    component riconoscitore_di_seq
        port(
            CLK : in std_logic;
            RST : in std_logic;
            i   : in std_logic;
            M   : in std_logic;
            Y   : out std_logic;
            state : out std_logic_vector(3 downto 0)  -- Debug opzionale
        );
    end component;

    -- Segnali locali per la simulazione
    signal CLK    : std_logic := '0';
    signal RST    : std_logic := '0';
    signal i      : std_logic := '0';
    signal M      : std_logic := '0';
    signal Y      : std_logic;
    signal state  : std_logic_vector(3 downto 0);

    -- Clock a 50 MHz (periodo 20 ns)
    constant clk_period : time := 20 ns;

begin

    -- Instanziazione del riconoscitore
    uut: riconoscitore_di_seq
        port map(
            CLK => CLK,
            RST => RST,
            i   => i,
            M   => M,
            Y   => Y,
            state => state
        );

    -- Processo per generare il clock
    clock_gen: process
    begin
        while true loop
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Processo di stimolo
    stimulus: process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for clk_period;
        RST <= '0';

        -- Simulazione con M=0 (sequenza standard)
        M <= '0';

        -- Inizio sequenza: 0, 1, 0, 1 (stato S3 -> Y=1)
        i <= '0'; wait for clk_period;
        i <= '1'; wait for clk_period;
        i <= '0'; wait for clk_period;
        i <= '1'; wait for clk_period;

        -- Test stato S5 (inserisco una transizione verso S5)
        i <= '0'; wait for clk_period;
        i <= '1'; wait for clk_period;
        
        -- Attiva reset durante la sequenza
        RST <= '1';
        wait for CLK_PERIOD;
        RST <= '0';


        -- Cambia M a 1 e verifica sequenza alternativa
        M <= '1';
        i <= '1'; wait for clk_period;
        i <= '1'; wait for clk_period;
        i <= '0'; wait for clk_period;
        i <= '1'; wait for clk_period;

        -- Test combinato con reset intermittente
        RST <= '1';
        wait for 2 * CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;

        -- Testare la sequenza con vari input
        -- Mode 1: S0, S1, S2, S3 (output Y = '1')
        M <= '0'; i <= '1';
        wait for 2 * CLK_PERIOD; -- Transizione a S1
        i <= '1';
        wait for 2 * CLK_PERIOD; -- Transizione a S2
        i <= '0';
        wait for 2 * CLK_PERIOD; -- Transizione a S3 (Y = '1')
        
        -- Mode 2:  S6, S7, S8 (output Y = '1')
        M <= '1'; i <= '1';
        wait for 2 * CLK_PERIOD; -- Transizione a S6
        i <= '1';
        wait for 2 * CLK_PERIOD; -- Transizione a S7
        i <= '0';
        wait for 2 * CLK_PERIOD; -- Transizione a S8 (Y = '1')


         wait;

    end process;

end test;
