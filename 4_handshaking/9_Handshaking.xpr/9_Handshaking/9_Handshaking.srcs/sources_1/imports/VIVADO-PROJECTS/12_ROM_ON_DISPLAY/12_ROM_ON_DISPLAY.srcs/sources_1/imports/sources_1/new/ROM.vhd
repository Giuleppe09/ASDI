library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
port(
    CLK: in std_logic;
    read : in std_logic; --segnale di lettura
    ADDR : in std_logic_vector(1 downto 0); --2 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switch
    DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit letto dalla ROM
    );
end ROM;
-- creo una ROM di 4 elementi da 4 bit ciascuno
architecture behavioral of ROM is 
type rom_type is array (0 to 3) of std_logic_vector(3 downto 0);
signal ROM : rom_type := (
"0000", 
"0001", 
"0010", 
"0100" );

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT
begin

process(CLK)
  begin
    if rising_edge(CLK) then
        if (read = '1') then
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
end process;
end behavioral;