library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;



entity encoder_display is
    Port(
           in_sec: in std_logic_vector(5 downto 0); 
           in_min: in std_logic_vector(5 downto 0); 
           in_ore: in std_logic_vector(4 downto 0); 
           value32_out: out  STD_LOGIC_VECTOR (31 downto 0)
        );
end encoder_display;

architecture DataFlow of encoder_display is

    --E' praticamente una tabella di verità che codifica gli input binari in pattern
    signal sec_temp : std_logic_vector (7 downto 0) := (others => '0');
    signal min_temp :  std_logic_vector (7 downto 0) := (others => '0');
    signal ore_temp :  std_logic_vector (7 downto 0) := (others => '0');
    
begin
    
    value32_out <= "00000000" & ore_temp & min_temp & sec_temp;
    
    -- Prima cifra dei secondi
    with conv_integer(unsigned(in_sec)) select
            --Prima cifra dei secondi
            sec_temp (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                    "0001" when 1|11|21|31|41|51,
                                    "0010" when 2|12|22|32|42|52,
                                    "0011" when 3|13|23|33|43|53,
                                    "0100" when 4|14|24|34|44|54,
                                    "0101" when 5|15|25|35|45|55,
                                    "0110" when 6|16|26|36|46|56,
                                    "0111" when 7|17|27|37|47|57,
                                    "1000" when 8|18|28|38|48|58,
                                    "1001" when 9|19|29|39|49|59,
                                    "1111" when others;
                                    
    -- Seconda cifra dei secondi 
     with conv_integer(unsigned(in_sec)) select
            sec_temp (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 29,
                                    "0011" when 30 to 39,
                                    "0100" when 40 to 49,
                                    "0101" when 50 to 59,
                                     "1111" when others;
                                    
    -- Prima cifra dei minuti
     with conv_integer(unsigned(in_min)) select
            min_temp (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                    "0001" when 1|11|21|31|41|51,
                                    "0010" when 2|12|22|32|42|52,
                                    "0011" when 3|13|23|33|43|53,
                                    "0100" when 4|14|24|34|44|54,
                                    "0101" when 5|15|25|35|45|55,
                                    "0110" when 6|16|26|36|46|56,
                                    "0111" when 7|17|27|37|47|57,
                                    "1000" when 8|18|28|38|48|58,
                                    "1001" when 9|19|29|39|49|59,
                                    "1111" when others;
                                    
    -- Seconda cifra dei minuti                               
     with conv_integer(unsigned(in_min)) select
            min_temp (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 29,
                                    "0011" when 30 to 39,
                                    "0100" when 40 to 49,
                                    "0101" when 50 to 59,
                                    "1111" when others;
                          
     -- Prima cifra delle ore                               
     with conv_integer(unsigned(in_ore)) select
            ore_temp (3 downto 0) <= "0000" when 0|10|20,
                                    "0001" when 1|11|21,
                                    "0010" when 2|12|22,
                                    "0011" when 3|13|23,
                                    "0100" when 4|14,
                                    "0101" when 5|15,
                                    "0110" when 6|16,
                                    "0111" when 7|17,
                                    "1000" when 8|18,
                                    "1001" when 9|19,
                                    "1111" when others;
                                    
    -- Seconda cifra delle ore
    with conv_integer(unsigned(in_ore)) select
             ore_temp (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 23,
                                    "1111" when others;
                                                         


end DataFlow;
