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
        
        --Segnali interni all'entit? A
        count_in: in std_logic_vector(1 downto 0);
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        read: out std_logic; --Da dare alla ROM
        
        --Stato in out
        stato: out std_logic_vector(2 downto 0)
    );
end cu_A;

architecture Behavioral of cu_A is

    --Abbiamo supposto la possibilit? di eseguire pi? volte il ciclo, cio? di non terminare dopo una singola esecuzione.
    --Per questo non ? previsto uno stato di fine
    type state is (idle, WRITE_ON_BUS, SEND_REQ , WAIT_4_ACK , OK_ACK, WAIT_4_DONE, CHECK_COUNT);--SENT NON SERVE PENSO
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
			  
		
    comb: process(current_state, start, ACK_in) 
    --Va messo anche il reset no? no perch? gi? sta in reg_stato per? comunque devo poter resettare il contatore l?.
    --Dunque in idle tengo sempre un reset_count='1'
        begin 
            
            rst_count <='0';
            read<='0';
            en_count <= '0';
            
           
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
                    --viene posto sul bus un nuovo dato.
                    next_state <= SEND_REQ;
                  
                 WHEN SEND_REQ =>
                    REQ_OUT <= '1'; --lo abbassiamo manualmente
                    next_state <= WAIT_4_ACK;
                 
                 WHEN WAIT_4_ACK =>
                    if(ACK_in='1') then
                        next_state <= OK_ACK;
                    else
                        next_state <= WAIT_4_ACK;
                    end if;
                 
                 WHEN OK_ACK=>
                    REQ_OUT<='0';
                    next_state <= WAIT_4_DONE;
                 
                 WHEN WAIT_4_DONE =>
                    if(ACK_in='0') then --Il ricevitore abbassa l'ack quando dovrebbe mandare il done.
                    --In questo modo abbiamo sfruttato il protocollo interlacciato.
                        next_state <= CHECK_COUNT;
                    else
                        next_state <= WAIT_4_DONE;
                    end if;
                   
                 WHEN CHECK_COUNT =>
                    en_count <= '1';
                    
                    if(count_in ="11")then
                        next_state <= idle;
                    else 
                        next_state <= WRITE_ON_BUS;
                    end if;
                  
                WHEN others =>
		          next_state <= idle;
		
		end CASE;
		
        end process;   

    
    -- Assegna lo stato corrente all'output
    with current_state select
        stato <= "000" when IDLE,
                 "001" when WRITE_ON_BUS,
                 "010" when SEND_REQ,
                 "011" when WAIT_4_ACK,
                 "100" when OK_ACK,
                 "101" when WAIT_4_DONE,
                 "110" when CHECK_COUNT,
                 "111" when others;
end Behavioral;