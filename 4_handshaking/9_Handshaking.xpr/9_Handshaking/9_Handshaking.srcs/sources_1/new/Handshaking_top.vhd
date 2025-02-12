----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2025 17:48:37
-- Design Name: 
-- Module Name: Nodo_B - Behavioral
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

entity Handshaking is
    Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            output: out std_logic_vector(3 downto 0);
            --per debug
            ACK   : out  std_logic;
            REQ   : out std_logic;
            BUS_dato: out std_logic_vector(3 downto 0);
            stato_A: out std_logic_vector(2 downto 0);
            stato_B: out std_logic_vector(2 downto 0)
        );
end Handshaking;

architecture Structural of Handshaking is

    component Nodo_A is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            START : in  std_logic;
            ACK   : in  std_logic;
            REQ   : out std_logic;
            BUS_out: out std_logic_vector(3 downto 0)  := (others => '0') ;
            stato: out std_logic_vector(2 downto 0);
            read: out std_logic
        );
    end component;
    
    component Nodo_B is
        Port (  
            CLK   : in  std_logic;
            RST   : in  std_logic;
            REQ   : in std_logic;
            ACK   : out  std_logic;
            BUS_in: in std_logic_vector(3 downto 0);
            output: out std_logic_vector(3 downto 0);
            --per debug
            read: out std_logic;
            write: out std_logic;
            stato: out std_logic_vector(2 downto 0)
        );
    end component;
    
    signal temp_REQ: std_logic;
    signal temp_ACK: std_logic;
    signal temp_BUS: std_logic_vector(3 downto 0);
    --per nodo A
    signal temp_read_A: std_logic;
    --per nodo B
	signal temp_read_B: std_logic;
	signal temp_write_B: std_logic;
	
begin

    A:Nodo_A port map(  
            CLK   => CLK,
            RST   => RST,
            START => START,
            ACK   => temp_ACK,
            REQ   => temp_REQ,
            BUS_out => temp_BUS,
            stato => stato_A,
            read => temp_read_A
        );
    
    B:Nodo_B port map(  
            CLK   => CLK,
            RST   => RST,
            ACK   => temp_ACK,
            REQ   => temp_REQ,
            BUS_in => temp_BUS,
            output => output,
            read => temp_read_B,
            write => temp_write_B,
            stato => stato_B
        );
    
   BUS_dato <=temp_BUS;
   ACK <= temp_ACK;
   REQ <= temp_REQ;
   
end Structural;