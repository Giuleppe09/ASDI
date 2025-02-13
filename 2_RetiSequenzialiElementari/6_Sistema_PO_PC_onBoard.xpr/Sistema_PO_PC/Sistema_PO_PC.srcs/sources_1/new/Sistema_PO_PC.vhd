library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistemaPO_PC is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        output: out std_logic_vector(3 downto 0);
        state: out std_logic_vector(2 downto 0); --per verificare in che stato siamo
        --perr debug
        rst_cont: out std_logic;    --reset contatore
        read: out std_logic;        --comandi
        write: out std_logic
    );
end sistemaPO_PC;

architecture Structural of sistemaPO_PC is

signal cleared_start: std_logic;
signal en_cont_temp: std_logic;
signal rst_cont_temp: std_logic;
signal read_temp: std_logic;
signal write_temp: std_logic;
signal count_temp: std_logic_vector(3 downto 0); --indirizzi per leggere e scrivere
signal out_m_temp: std_logic_vector(3 downto 0);

begin
    
    --Istanziazione
    unita_controllo: entity work.Control_unit port map(
        --ingressi
        clk => clk,
        start => cleared_start,
        reset => reset,
        count => count_temp,
        --uscite per il contatore
        en_cont => en_cont_temp,
        rst_cont => rst_cont_temp,
        --uscite per le memorie
        read => read_temp,
        write => write_temp,
        state => state
    ); 
    
    contatore: entity work.cont_mod16 port map(
        clock => clk,
        reset => rst_cont_temp,
        count_in => en_cont_temp,     --enable
        count => count_temp        --indirizzi memorie
    );
    
    ROM_M: entity work.Sistema_ROM_M port map(
        CLK => clk,
        read => read_temp,     --comando
        address => count_temp, --dove leggere
        data_out => out_m_temp --4 bit
    );
    
    MEM: entity work.mem_out port map(
    
        CLK=> clk,
        RST=> reset,
        write=> write_temp,     --comando
        ADDR => count_temp,     --dove scrivere
        data_in=> out_m_temp,   --4 bit
        data_out => output      --uscita
    );
    
    DEB: entity work.ButtonDebouncer port map(
    
        CLK=> clk,
        RST=> reset,
        BTN=> start,     
        CLEARED_BTN => cleared_start  
    );
    
    rst_cont <= rst_cont_temp; --reset contatore
    read  <= read_temp;        --comandi
    write <= write_temp;

end Structural;