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
        
        --Segnali interni all'entità A
        count_in: in std_logic_vector(1 downto 0);
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        read: out std_logic; --Da dare alla MEM
        write: out std_logic; --Da dare alla MEM
        --per debug
        stato: out std_logic_vector(2 downto 0)
    );
end cu_B;

architecture Behavioral of cu_B is

    --Abbiamo supposto la possibilit? di eseguire più volte il ciclo, cioè di non terminare dopo una singola esecuzione.
    --Per questo non ? previsto uno stato di fine
    type state is (WAIT_4_REQ, SEND_ACK , OK_read, WRITE_inMEM , DONE , CHECK_COUNT, FINE);
	signal current_state,next_state: state;

	begin
	reg_stato: process(clk)
			  begin
			  if(clk'event and clk='1') then
		         if(rst='1') then 
				    current_state <=FINE;
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
		
    comb: process(current_state, REQ_in) 
    
        begin 
            --resetto i segnali interni al clock successivo
            rst_count <='0';
            read<='0';
            write<='0';
            en_count <= '0';
            
           
            CASE current_state is
                WHEN WAIT_4_REQ =>
                    
                    if(REQ_in='1')then
                        next_state <= SEND_ACK;
                    else 
                        next_state <= WAIT_4_REQ;
                    end if;
                    
                  
                 WHEN SEND_ACK =>
                    read <='1'; 
                    ACK_out <= '1'; --lo alziamo
                    --aspetto che REQ si abbassi
                    if(REQ_in='0')then
                        next_state <= OK_read;
                    else 
                        next_state <= SEND_ACK;
                    end if;
                    
                 
                 WHEN OK_read=>
                    next_state <= WRITE_inMEM;
                 
                 WHEN WRITE_inMEM =>
                    write<='1';
                    next_state <= DONE;
                    
                 WHEN DONE =>
                    ACK_out <='0'; --abbasso ACK quando ho finito 
                    next_state <= CHECK_COUNT;
                    
                 WHEN CHECK_COUNT =>
                    en_count <= '1';
                    
                    if(count_in ="11")then
                        next_state <= FINE;
                    else 
                        next_state <= WAIT_4_REQ;
                    end if;
                  
                WHEN FINE =>
                    rst_count <='1';
                    next_state <= WAIT_4_REQ;
                    
                WHEN others =>
		          next_state <= FINE;
		
		end CASE;
		
        end process;   
        
         -- Codifica dello stato corrente per debug 
        with current_state select 
        stato <= "000" when WAIT_4_REQ,  
                "001" when SEND_ACK ,  
                "010" when OK_read, 
                "011" when WRITE_inMEM ,  
                "100" when DONE ,  
                "101" when CHECK_COUNT, 
                "110" when FINE,
                "111" when others;


end Behavioral;