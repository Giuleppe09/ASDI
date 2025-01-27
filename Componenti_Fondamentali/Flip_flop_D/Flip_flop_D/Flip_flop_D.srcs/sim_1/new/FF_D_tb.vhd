library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D_tb is
end FF_D_tb;

architecture tb of FF_D_tb is

    -- Componenti e segnali
    component FF_D
        port(
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            d   : in STD_LOGIC;
            y   : out STD_LOGIC
        );
    end component;

    signal clk_tb, rst_tb, d_tb, y_tb : std_logic;

    constant clk_period : time := 20 ns;

begin
    -- Istanziazione del Flip-Flop D
    uut: FF_D
        port map(
            CLK => clk_tb,
            RST => rst_tb,
            d   => d_tb,
            y   => y_tb
        );

    -- Generazione del clock
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimoli di test
    stimuli : process
    begin
        -- Reset attivo
        rst_tb <= '1';
        d_tb <= '0';
        wait for clk_period;

        -- Disattiva il reset e applica dati
        rst_tb <= '0';
        d_tb <= '1';
        wait for clk_period;

        d_tb <= '0';
        wait for clk_period;

        d_tb <= '1';
        wait for clk_period;

        -- Fine simulazione
        wait;
    end process;

end tb;
