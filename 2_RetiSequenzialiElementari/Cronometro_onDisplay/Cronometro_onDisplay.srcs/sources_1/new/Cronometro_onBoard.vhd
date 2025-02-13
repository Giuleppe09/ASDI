library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro_onBoard is
 port(
        clk: in std_logic;
        reset: in std_logic;
        switches: in std_logic_vector(5 downto 0);
        
        btn_load: in std_logic; -- Per il blocco di Acquisizione
        btn_set: in std_logic; -- set per i contatori interni al cronometro
        
        catodi : out STD_LOGIC_VECTOR(7 downto 0);
        anodi : out STD_LOGIC_VECTOR(7 downto 0)  
        
    );
end Cronometro_onBoard;

architecture Structural of Cronometro_onBoard is
     component Blocco_acquisizione  
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
    end component;
    
    component cronometro
        port(
            CLK: in std_logic;                  -- Segnale di clock in ingresso.
            RST: in std_logic;                  -- Segnale di reset in ingresso.
            set: in std_logic;                  -- Segnale per impostare i valori iniziali.
            in_sec: in std_logic_vector(5 downto 0);  -- Valore iniziale per i secondi.
            in_min: in std_logic_vector(5 downto 0);  -- Valore iniziale per i minuti.
            in_ore: in std_logic_vector(4 downto 0);  -- Valore iniziale per le ore.
            out_sec: out std_logic_vector(5 downto 0); -- Output dei secondi.
            out_min: out std_logic_vector(5 downto 0); -- Output dei minuti.
            out_ore: out std_logic_vector(4 downto 0)  -- Output delle ore.
        );
    end component;
    
    component Blocco_Visualizzazione
        port(
            CLK: in std_logic;                  
            RST: in std_logic;
            in_sec: in std_logic_vector(5 downto 0);  
            in_min: in std_logic_vector(5 downto 0); 
            in_ore: in std_logic_vector(4 downto 0); 
            catodi : out STD_LOGIC_VECTOR(7 downto 0);
            anodi : out STD_LOGIC_VECTOR(7 downto 0)  
            
        );
     end component;
        
        
     --Segnali tra bloccoAcquisizione e Cronometro
    signal in_sec_C:  std_logic_vector(5 downto 0);  
    signal in_min_C:  std_logic_vector(5 downto 0); 
    signal in_ore_C:  std_logic_vector(4 downto 0);      
        
    --Segnali tra Cronometro e BloccoVisualizzazione
    signal out_sec_C:  std_logic_vector(5 downto 0);  
    signal out_min_C:  std_logic_vector(5 downto 0); 
    signal out_ore_C:  std_logic_vector(4 downto 0);  
    
    --Segnale per lo stato
    signal stato_BA: std_logic_vector(2 downto 0);
 
    
begin
    
    --Istanziazione
    BA: Blocco_acquisizione port map(
        clk => clk,
        reset => reset,
        switches => switches,
        load => btn_load, --Bottone load
        sec_out => in_sec_C,
        min_out => in_min_C,
        ore_out => in_ore_C,
        state => stato_BA
        );
  
   CR: cronometro port map(
        CLK => clk,           -- Segnale di clock in ingresso.
        RST => reset,                 -- Segnale di reset in ingresso.
        set => btn_set,                  -- Bottone per settare inizialmente i contatori ad un determinato valore
        in_sec => in_sec_C,
        in_min => in_min_C,
        in_ore => in_ore_C,
        out_sec => out_sec_C,
        out_min => out_min_C,
        out_ore => out_ore_C
    );
    
    BV: blocco_visualizzazione port map(
 
            CLK => clk,           
            RST => reset,
            in_sec => out_sec_C,
            in_min => out_min_C,
            in_ore => out_ore_C,
            catodi => catodi,
            anodi => anodi
    );        
    
end Structural;
