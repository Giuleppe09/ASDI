----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2024 18:48:12
-- Design Name: 
-- Module Name: RETE_16_4 - Behavioral
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

entity RETE_16_4 is
    Port ( 
        A : in std_logic_vector(15 downto 0); --Ingressi del mio MUX
        S_mux : in std_logic_vector(3 downto 0);  --Selezioni del mio MUX
        S_demux : in std_logic_vector(1 downto 0);  --Selezione del mio DEMUX
        Y : out std_logic_vector(3 downto 0) --Uscite del mio DEMUX
    );
end RETE_16_4;

architecture Structural of RETE_16_4 is

    --segnali di appoggio
    signal U: std_logic; --solo lo std_logic che devo far anadre dal MUX al DEMUX
    
    --definizione MUX
    component mux_16_1 is 
        port(
            C : in std_logic_vector(15 downto 0);
            S : in std_logic_vector(3 downto 0);
            Y : out std_logic
            );
    end component;
    
    --definizione DEMUX
    component demux_1_4 is 
        port(
            a : in std_logic;
            S : in std_logic_vector(1 downto 0);
            Y : out std_logic_vector(3 downto 0)
            );
    end component;
    
begin

--Ora faccio i portmap

    MUX: mux_16_1
    
        port map(
            C=>A,
            S=>S_mux,
            Y=>U
        );
    
    DEMUX: Demux_1_4

        port map(
            a=>U,
            S=>S_demux,
            Y=>Y
        );


end Structural;
