library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_A is
    Port ( 
        --Segnali esterni.
        start: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        
         --Segnali per comunicazione con la UART
        WR: out std_logic; --Da dare alla UART
        TBE : in std_logic; -- Da leggere dalla UART
        
        --Segnali interni all'entita A
        count_in: in std_logic_vector(2 downto 0); --8 locazioni da 8 bit
        
        rst_count: out std_logic; --Da dare al contatore.std_logic
        en_count: out std_logic; --Da dare al end
        
       
        
        --Stato in out per il debug
        stato: out std_logic_vector(2 downto 0)
    );
end cu_A;

architecture Behavioral of cu_A is

    type state is (idle, WRITE_IN_UART,WAIT_4_TBE, CHECK_COUNT);--SENT NON SERVE PENSO
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
			  
		
    comb: process(current_state, start, TBE)
    --Nella sensisitivity list bisogna includere TBE. 
        
        begin 
            
            rst_count <='0';
            en_count <= '0';
            
            CASE current_state is
                WHEN idle =>
                    rst_count <='1';
                    
                    if(start='1')then
                        next_state <= WRITE_IN_UART;
                        --Per l'inserimento dei dati nello shift register della UART.
                        --Inserimento che avverrà in parallelo
                    else 
                        next_state <= idle;
                    end if;
                    
                 WHEN WRITE_IN_UART =>
                    WR <= '1'; --Indico alla UART la volontà di voler scrivere.
                    --viene posto sul bus un nuovo dato.
                    next_state <= WAIT_4_TBE;
                  
                 WHEN WAIT_4_TBE =>
                    WR <= '0'; --lo abbassiamo manualmente
                    if TBE ='0' then
                        next_state <= WAIT_4_TBE;
                    else 
                        next_state <= CHECK_COUNT;
                    end if;
                 
                 WHEN CHECK_COUNT =>
                    if(count_in="111") then
                        next_state <= idle;
                    else
                        next_state <= WRITE_IN_UART;
                    end if;
                 
                 
                WHEN others =>
		          next_state <= idle;
		
		end CASE;
		
        end process;   

    
    -- Assegna lo stato corrente all'output
    with current_state select
        stato <= "000" when IDLE,
                 "001" when WRITE_IN_UART,
                 "010" when WAIT_4_TBE,
                 "011" when CHECK_COUNT,
                 "111" when others;
end Behavioral;