----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2024 17:41:50
-- Design Name: 
-- Module Name: tb_mux_16_1 - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_16_1_tb is
end;

architecture bench of mux_16_1_tb is

  component mux_16_1
      port(
          C : in std_logic_vector(15 downto 0);
          S : in std_logic_vector(3 downto 0);
          Y : out std_logic
      );
  end component;

  signal input: std_logic_vector(15 downto 0);
  signal control: std_logic_vector(3 downto 0);
  signal output: std_logic ;

begin

  uut: mux_16_1 port map ( C => input,
                           S => control,
                           Y => output );

  stimulus: process
  begin
    
    wait for 100 ns;
    
    -- Put initialisation code here
    input 	<= "1011101010011010"; 
    control <= "0000";
    wait for 10 ns; -- Y = 0, essendo il vettore di tipo dowto il primo inserimento del mio multiplexer è 0
    control <= "0001"; 
    wait for 10 ns; -- Y = 1
    control <= "0010"; 
    wait for 10 ns; -- Y = 0
    control <= "0011"; 
    wait for 10 ns; -- Y = 1
    control <= "0100"; 
    wait for 10 ns; -- Y = 1
    control <= "0101"; 
    wait for 10 ns; -- Y = 0
    control <= "0110"; 
    wait for 10 ns; -- Y = 0
    control <= "0111"; 
    wait for 10 ns; -- Y = 1
    control <= "1000"; 
    wait for 10 ns; -- Y = 0
    control <= "1001"; 
    wait for 10 ns; -- Y = 1
    control <= "1010"; 
    wait for 10 ns; -- Y = 0
    control <= "1011"; 
    wait for 10 ns; -- Y = 1
    control <= "1100"; 
    wait for 10 ns; -- Y = 1
    control <= "1101"; 
    wait for 10 ns; -- Y = 1
    control <= "1110"; 
    wait for 10 ns; -- Y = 0
    control <= "1111"; 
    wait for 10 ns; -- Y = 1
    
    -- Put test bench stimulus code here

    wait;
  end process;


end bench;

