
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
    port ( 
        
        RST: in std_logic;
        CLK: in std_logic;
        i: in std_logic;
        i_read: in std_logic;
        M: in std_logic;
        m_read: in std_logic;
        i_out: out std_logic;
        m_out: out std_logic
        
    );
end Control_unit;

architecture Behavioral of Control_unit is

    --Registri
    signal reg_data: std_logic;
    signal reg_M: std_logic;

begin
    
    --assegnazioni 
    i_out <= reg_data;
    m_out <= reg_M;
    
    proc: process(CLK)
    
    begin
    
        if(rising_edge(CLK)) then 
            if (RST='1') then
                --reg_data <= '0';
                --reg_M <= '0';
            else
                
                    reg_data <= i;
                els
                    reg_M <= M;
                end if;
           end if;
      end if;
      
    end process;              
                    
    end Behavioral;
