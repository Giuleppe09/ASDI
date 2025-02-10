library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_B is
    Port ( 
        --Segnali esterni.
        CLK: in std_logic;
        RST: in std_logic;
        
        --Segnali Per Handshaking completo
        REQ_in: in std_logic;
        ACK_out: out std_logic; 
        
       
        write: out std_logic; --Da dare alla MEM
        --per debug
        stato: out std_logic_vector(1 downto 0)
    );
end cu_B;

architecture Behavioral of cu_B is

    --Abbiamo supposto la possibilit? di eseguire più volte il ciclo, cioè di non terminare dopo una singola esecuzione.
    --Per questo non ? previsto uno stato di fine
    type state is (WAIT_4_REQ, SEND_ACK ,WRITE_in_MEM);
	signal current_state,next_state: state;

	begin
	reg_stato: process(clk)
			  begin
			  if(clk'event and clk='1') then
		         if(rst='1') then 
				    current_state <=WAIT_4_REQ;
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
		
    comb: process(current_state, REQ_in) 
    
        begin 
          
            write<='0';
           
            CASE current_state is
                WHEN WAIT_4_REQ =>
                    
                    if(REQ_in='1')then
                        next_state <= SEND_ACK;
                    else 
                        next_state <= WAIT_4_REQ;
                    end if;
                    
                  
                 WHEN SEND_ACK =>
                   
                    ACK_out <= '1'; --lo alziamo
                    next_state <= WRITE_IN_MEM;
                 
                 WHEN WRITE_IN_MEM => -- Protocollo di handshaking semplice
                    ACK_out <= '0'; 
                    write<='1';
                    next_state <= WAIT_4_REQ;
                    
                    
                WHEN others =>
		          next_state <= WAIT_4_REQ;
		
		end CASE;
		
        end process;   
        
         -- Codifica dello stato corrente per debug 
        with current_state select 
        stato <= "00" when WAIT_4_REQ,  
                "01" when SEND_ACK ,  
                "10" when WRITE_in_MEM,
                "11" when others;


end Behavioral;