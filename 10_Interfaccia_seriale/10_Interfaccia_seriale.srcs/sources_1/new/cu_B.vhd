library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_B is
    Port ( 
        --Segnali esterni.
        CLK: in std_logic;
        RST: in std_logic;
        
        --Segnali per la comunicazione con la UART
        RDA: in std_logic;
        RD: out std_logic;
       
        
        --Segnali interni all'entità A
        count_in: in std_logic_vector(2 downto 0);
        rst_count: out std_logic; 
        en_count: out std_logic; 
       
        write: out std_logic; --Da dare alla MEM
        --per debug
        stato: out std_logic_vector(2 downto 0)
    );
end cu_B;

architecture Behavioral of cu_B is

    --Abbiamo supposto la possibilit? di eseguire più volte il ciclo, cioè di non terminare dopo una singola esecuzione.
    --Per questo non ? previsto uno stato di fine
    type state is (WAIT_4_RDA,READ_UART,WRITE_IN_MEM,CHECK_COUNT,FINE);
	signal current_state,next_state: state;

	begin
	reg_stato: process(clk)
			  begin
			  if(clk'event and clk='1') then
		         if(rst='1') then 
				    current_state <= FINE; -- in cui rst_count='1'.
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
		
    comb: process(current_state, RDA) 
    
        begin 
            --resetto i segnali interni al clock successivo
            rst_count <='0'; 
            write<='0';
            en_count <= '0';
            
           
            CASE current_state is
                WHEN WAIT_4_RDA =>
                    
                    if(RDA='1')then
                        next_state <= READ_UART;
                    else 
                        next_state <= WAIT_4_RDA;
                    end if;
                    
                  
                 WHEN READ_UART =>
                    RD <='1';
                    next_state <= WRITE_IN_MEM;
                 
                
                 WHEN WRITE_IN_MEM =>
                    write<='1';
                    RD <='0';
                    next_state <= CHECK_COUNT;
              
                    
                 WHEN CHECK_COUNT =>
                    en_count <= '1';
                    
                    if(count_in ="111")then
                        next_state <= FINE;
                    else 
                        next_state <= WAIT_4_RDA;
                    end if;
                  
                WHEN FINE =>
                    rst_count <='1';
                    next_state <= WAIT_4_RDA;
                    
                WHEN others =>
		          next_state <= FINE;
		
		end CASE;
		
        end process;   
        
         -- Codifica dello stato corrente per debug 
        with current_state select 
        stato <= "000" when WAIT_4_RDA,  
                "001" when READ_UART,  
                "010" when WRITE_IN_MEM, 
                "011" when CHECK_COUNT,
                "100" when FINE,
                "101" when others;
              

end Behavioral;