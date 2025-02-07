library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
port(
    CLK: in std_logic;
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switch
    DATA : out std_logic_vector(7 downto 0) -- dato su 8 bit letto dalla ROM
    );
end ROM;
-- creo una ROM di 4 elementi da 4 bit ciascuno
architecture behavioral of ROM is 
type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);
signal ROM : rom_type := (
    "00000000", 
    "00000001", 
    "00000010", 
    "00000100",
    "00001000", 
    "00010000", 
    "00100000", 
    "01000000" );

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT
begin

process(CLK)
  begin
    if rising_edge(CLK) then
            DATA <= ROM(conv_integer(ADDR));
    end if;
end process;
end behavioral;