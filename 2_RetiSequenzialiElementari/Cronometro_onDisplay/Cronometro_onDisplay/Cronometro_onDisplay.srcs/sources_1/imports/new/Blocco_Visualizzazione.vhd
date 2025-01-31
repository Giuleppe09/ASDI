library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Blocco_Visualizzazione is
     port(
            CLK: in std_logic;                  
            RST: in std_logic;
            in_sec: in std_logic_vector(5 downto 0);  
            in_min: in std_logic_vector(5 downto 0); 
            in_ore: in std_logic_vector(4 downto 0); 
            catodi : out STD_LOGIC_VECTOR(7 downto 0);
            anodi : out STD_LOGIC_VECTOR(7 downto 0)  
            
        );
end Blocco_Visualizzazione;

architecture Structural of Blocco_Visualizzazione is

    component display_seven_segments is
	Generic( 
				clock_frequency_in : integer := 50000000; 
				clock_frequency_out : integer := 5000000
				);
    Port ( 
            clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;
    
    component Encoder_Display is
    Port(
           in_sec: in std_logic_vector(5 downto 0); 
           in_min: in std_logic_vector(5 downto 0); 
           in_ore: in std_logic_vector(4 downto 0); 
           value32_out: out  STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
    
    
   --Segnali intermedi 
    signal input_Display: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
    
begin
    
    --Istanziazione
    encoder: Encoder_Display port map(
        in_sec => in_sec,   
        in_min => in_min,
        in_ore => in_ore,
        value32_out => input_Display
     );
     
     display: display_seven_segments 
        Generic Map( 
            clock_frequency_in => 100000000,
            clock_frequency_out => 500
        )
        port map ( 
            clock => CLK,
            reset => RST,
            value32_in => input_Display,
            enable => "00111111", --Accendiamo solo le prime 6 cifre
            dots => "00010100", -- Accendiamo solo i punti che dividono ore e minuti e secondi.
            anodes  => anodi,
            cathodes => catodi
        );
    
end Structural;