library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
port(
    CLK : in std_logic;
    read: in std_logic;
    ADDR : in std_logic_vector(3 downto 0); --4 bit di indirizzo per accedere agli elementi della ROM
    DATA : out std_logic_vector(7 downto 0) -- dato su 8 bit letto dalla ROM
    );
end ROM;
-- creo una ROM di 16 elementi da 8 bit ciascuno
architecture behavioral of ROM is 
type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);
signal ROM : rom_type := (
"00000000", 
"00000010", 
"00000100", 
"00001000", 
"00010000",
"00100000",
"01000000", 
"10000000",
"10000001", 
"10000010", 
"10000100", 
"10001000", 
"10010000",
"10100000",
"11000000", 
"10000001");

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT
begin

process(CLK)
  begin
    if rising_edge(CLK) then
        if read = '1' then
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
    
end process;
end behavioral;