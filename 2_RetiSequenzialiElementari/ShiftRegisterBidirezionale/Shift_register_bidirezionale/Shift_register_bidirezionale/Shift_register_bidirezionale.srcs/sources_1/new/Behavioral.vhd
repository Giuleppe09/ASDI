----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2025 21:30:37
-- Design Name: 
-- Module Name: Behavioral - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Behavioral is

    generic(
        N: integer :=8 -- Numero di bit
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           load : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (1 downto 0); --seleziona il tipo di shift
           data_in : in STD_LOGIC_VECTOR (N-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (N-1 downto 0));
end Behavioral;

architecture Behavioral of Behavioral is

    signal reg_tmp: STD_LOGIC_VECTOR (N-1 downto 0);

begin
    process (CLK)
    begin
        if rising_edge(CLK) then --Reset sincrono con il clock
            if (RST='1') then
                --Setta tutti i bit a zero
                reg_tmp <= (others=>'0'); 
            else
                if (load='1') then 
                    --caricamento in parallelo
                    reg_tmp <= data_in;
                else
                    --Selezione tipo di shift
                    case sel is
                        when "00" => -- Shift a sinistra di uno
                            reg_tmp <= reg_tmp(N-2 downto 0) & '0';
                        
                        when "01" => -- Shift a destra di uno
                            reg_tmp <= '0' & reg_tmp(N-1 downto 1);
                        
                        when "10" => -- Shift a sinistra di due
                            reg_tmp <= reg_tmp(N-3 downto 0) & "00";
                        
                        when "11" => -- Shift a destra di due
                            reg_tmp <= "00" & reg_tmp(N-1 downto 2);
                        
                        when others =>
                            reg_tmp <= reg_tmp; -- Nessun cambiamento
                    
                    end case;
                
                end if;
            
            end if;
            
        end if;
        
    end process;
    
    data_out <= reg_tmp; -- uscita in parallelo
        
end Behavioral;
