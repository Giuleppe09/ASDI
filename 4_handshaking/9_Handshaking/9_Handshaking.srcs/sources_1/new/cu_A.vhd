library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_A is
    Port ( 
        --Segnali esterni.
        start: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        
        --Segnali Per Handshaking completo
        REQ_out: out std_logic;
        ACK_in: in std_logic; 
        
        --Segnali interni all'entità A
        count_in: in std_logic_vector(1 downto 0);
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        read: out std_logic --Da dare alla ROM
    );
end cu_A;

architecture Behavioral of cu_A is

    --Abbiamo supposto la possibilità di eseguire più volte il ciclo, cioè di non terminare dopo una singola esecuzione.
    --Per questo non è previsto uno stato di fine
    type state is (idle, WRITE_ON_BUS, SEND_REQ , WAIT_4_ACK , OK_ACK, WAIT_4_DONE, SENT, CHECK_COUNT);--SENT NON SERVE PENSO
	signal current_state,next_state: state;

	begin
	reg_stato: process(clk)
			  begin
			  if(clk'event and clk='1') then
		         if(rst='1') then 
				    current_state <=idle;
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
		
    comb: process(current_state, start, count_in) 
    --Va messo anche il reset no? no perchè già sta in reg_stato però comunque devo poter resettare il contatore lì.
    --Dunque in idle tengo sempre un reset_count='1'
        begin 
            
            rst_count <='0';
            read<='0';
            
           
            CASE current_state is
                WHEN idle =>
                    rst_count <='1';
                    
                    if(start='1')then
                        next_state <= WRITE_ON_BUS;
                    else 
                        next_state <= idle;
                    end if;
                    
                 WHEN WRITE_ON_BUS =>
                    read <='1';
                    next_state <= SEND_REQ;
                  
                WHEN others =>
		      next_state <= idle;
		
		end CASE;
		
        end process;   


end Behavioral;
