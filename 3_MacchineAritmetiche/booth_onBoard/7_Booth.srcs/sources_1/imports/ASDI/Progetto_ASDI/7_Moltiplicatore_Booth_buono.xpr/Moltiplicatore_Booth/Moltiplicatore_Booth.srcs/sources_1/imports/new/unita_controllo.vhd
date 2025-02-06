library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity unita_controllo is 
	port( clock, reset, start: in std_logic;--clock è il clock della board, clock_div viene dal divisore di freq
	      Q: in std_logic_vector(1 downto 0); --per scegliere l'operazione
		  count_in: in std_logic_vector(2 downto 0);
		  loadM, en_count, loadAQ, en_shift: out std_logic;
		  selAQ, selM, subtract, stop_cu: out std_logic; --selAQ è per il caricamento del dato nello shift register: se è 0 è da fuori, se è 1 è interno
		  --non abbiamo più il multiplexer MUX_molt, quindi non abbiamo in uscita selM
		  --non abbiamo più il flip flop quindi non abbiamo più selF
		  stato: out std_logic_vector(3 downto 0)
		  );
end unita_controllo;


architecture structural of unita_controllo is
	type state is (idle, caricamento, ok_start , scan , avvia_ADDER, avvia_shift, incr_count);
	signal current_state,next_state: state;

	begin 
		
	reg_stato: process(clock)
			  begin
			  if(clock'event and clock='1') then
		         if(reset='1') then 
				    current_state <=idle;
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
	comb: process(current_state, start, count_in)
		  begin
		  
		  -- Attenzione! questo process si attiva ogni volta che c'è una variazione nei segnali della sensitivity list
		  -- current_state e count per loro natura variano sempre in corrispodenza del fronte di salita del clock
		  -- start viene dall'esterno: se non varia (sale e scende) col fronte del clock, si potrebbe avere una situazione
		  -- in cui il next_state varia ma non ha modo da stabilizzarsi (perchè current_state non è ancora variato)
		  -- quando il moltiplicatore sarà messo su board, START dovrà essere generato come uscita del button debouncer
		  
		 en_count <='0'; 
         selAQ <= '0';
         loadAQ <='0';  --carica nello shift register
         selM <='0';
         loadM <='0';   --carica il moltiplicando nel registro M
         stop_cu <='0';  
         en_shift <='0'; --segnale che abilita lo shift durante le prime N-1 iterazioni
         
		  	            
	     CASE current_state is
		  
		  WHEN idle => 
		  
                  if(start='1') then 
					   next_state <= caricamento;
				    else 
					   next_state <= idle;
					end if;
		
		  --fornisce i segnali di caricamento operandi
		  WHEN caricamento => 
		  
		            loadM <='1'; --abilita il caricamento del moltiplicando nel registro M
		            
					loadAQ <='1'; --abilita il caricamento del moltiplicatore e degli 8 zeri in testa 
					              --nello shift register A.Q (perchè selAQ=0)
					
					next_state <= ok_start;
					
        WHEN ok_start => --per aspettare il caricamento
					next_state <= scan;      
					     
        WHEN scan => 
                
                    --carichiamo il risultato nello shift register
                    selAQ <='1';
                    loadAQ<='1';
                    
                    subtract <='0';
                    
                    if (Q = "00") or (Q="11") then
                        selM <='0';
                        next_state <= avvia_shift;
                    elsif (Q = "01") then
                        selM <='1';
                        next_state <= avvia_ADDER;
                    elsif (Q = "10") then
                        selM <='1';
                        subtract <='1';
                        next_state <= avvia_ADDER;            
                    end if;	
                    
                    
                    
		--acquisisce gli operandi, su cui il sommatore inizia a lavorare immediatamente
		 WHEN avvia_ADDER => 
		 
				    next_state <= avvia_shift;
                
                
		 --carica il risultato della somma in A e da fornisce il segnale di shift
		 WHEN avvia_shift =>  
					en_shift <='1';
					next_state <= incr_count;      
		 
		 --esegue lo shift, abilita incremento conteggio e predispone per nuova iterazione  
		 WHEN incr_count =>  
		 
		            if(count_in ="111") then
					   next_state <= idle;
					   stop_cu <='1';
					else
					   en_count <= '1';
					   next_state <= scan;
                    end if;
		                
		WHEN others =>
		      next_state <= idle;
		
		end CASE;
		
    end process; 
    
    -- Codifica dello stato corrente per debug 
    with current_state select 
        stato <= "0000" when IDLE, 
                "0001" when caricamento , 
                "0010" when ok_start ,
                "0011" when scan , 
                "0100" when avvia_ADDER, 
                "0101" when avvia_shift,
                "0110" when incr_count,
                "1000" when others;
 end structural;