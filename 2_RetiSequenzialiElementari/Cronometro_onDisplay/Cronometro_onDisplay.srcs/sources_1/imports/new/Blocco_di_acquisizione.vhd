
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Blocco_acquisizione is
    port(
        clk: in std_logic;
        reset: in std_logic;
        switches: in std_logic_vector(5 downto 0);
        load: in std_logic;
        sec_out: out std_logic_vector(5 downto 0);
        min_out: out std_logic_vector(5 downto 0);
        ore_out: out std_logic_vector(4 downto 0);
        state: out std_logic_vector(2 downto 0)
    );
end Blocco_acquisizione;

architecture Structural of Blocco_acquisizione is

    component Control_unit 
        port(
            CLK: in std_logic;
            RST: in std_logic;
            load: in std_logic;
            load_sec: out std_logic;
            load_min: out std_logic;
            load_ore: out std_logic;
            state: out std_logic_vector(2 downto 0)
        );
    end component;
    
    component ButtonDebouncer
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock in nanosec
            btn_noise_time: integer :=  10000000 --durata dell'oscillazione 
        );
        Port( 
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC
        );
    end component;
    
    component registro_acq is
        generic(
            N: integer := 8 --dimensione del registro
        );
        port(
            CLK: in std_logic;
            RST: in std_logic;
            load: in std_logic; --segnale di caricamento/scrittura
            data_in: in std_logic_vector(N-1 downto 0);
            data_out: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    signal load_temp: std_logic := '0';
    signal load_sec_temp: std_logic := '0';
    signal load_min_temp: std_logic := '0';
    signal load_ore_temp: std_logic := '0';

begin

    deb: ButtonDebouncer
    port map(
        RST => reset,
        CLK => clk,
        BTN => load,
        CLEARED_BTN => load_temp
    );
    
    CU: Control_Unit
    port map(
        CLK => clk,
        RST => reset,
        load => load_temp,
        load_sec => load_sec_temp,
        load_min => load_min_temp,
        load_ore => load_ore_temp,
        state => state
    );
    
    reg_sec: registro_acq
    generic map(6)
    port map(
        clk => clk,
        RST => reset,
        load => load_sec_temp,
        data_in => switches,
        data_out => sec_out
    );
    
    reg_min: registro_acq
    generic map(6)
    port map(
        clk => clk,
        RST => reset,
        load => load_min_temp,
        data_in => switches,
        data_out => min_out
    );
    
    reg_ore: registro_acq
    generic map(5)
    port map(
        clk => clk,
        RST => reset,
        load => load_ore_temp,
        data_in => switches(4 downto 0),
        data_out => ore_out
    );

end Structural;
