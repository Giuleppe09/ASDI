----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2025 10:28:11
-- Design Name: 
-- Module Name: Control_unit - Behavioral
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

entity Control_unit is
    port ( 
        
        clock: in std_logic;
        RST: in std_logic;
        --bottoni
        load_first_input: in std_logic;
        load_second_input: in std_logic;
        load_indirizzamento: in std_logic;
        --input
        data_in8: in std_logic_vector(7 downto 0);
        sel_MUX_in:in std_logic_vector(3 downto 0);
        sel_DEMUX_in: in std_logic_vector(1 downto 0);
        --output
        data_out16: out std_logic_vector(15 downto 0);
        sel_MUX_out: out std_logic_vector(3 downto 0);
        sel_DEMUX_out: out std_logic_vector(1 downto 0)
        
    );
end Control_unit;

architecture Behavioral of Control_unit is

    --Registri
    signal reg_data: std_logic_vector(15 downto 0):= (others => '0');
    signal reg_sel_MUX: std_logic_vector(3 downto 0):= (others => '0');
    signal reg_sel_DEMUX: std_logic_vector(1 downto 0):= (others => '0');

begin
    
    --assegnazioni 
    data_out16 <= reg_data;
    sel_MUX_out <= reg_sel_MUX;
    sel_DEMUX_out <= reg_sel_DEMUX;
    
    proc: process(clock)
    
    begin
    
        if(rising_edge(clock)) then 
            if (RST='1') then
                reg_data <= (others => '0');
            else
                if(load_first_input = '1') then
                    reg_data(7 downto 0) <= data_in8;
                elsif(load_second_input = '1') then 
                    reg_data(15 downto 8) <= data_in8;
                elsif(load_indirizzamento = '1') then
                    reg_sel_MUX <= sel_MUX_in;
                    reg_sel_DEMUX <= sel_DEMUX_in;
                end if;
           end if;
      end if;
      
    end process;              
                    
    end Behavioral;
