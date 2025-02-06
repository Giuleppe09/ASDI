library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);--moltiplicatore e moltiplicando
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ, selM, en_count: in std_logic;
		  count_in: out std_logic_vector(2 downto 0);
		  P: out std_logic_vector(16 downto 0);
		  test_sum,test_Mreg: out std_logic_vector(7 downto 0) ); --risultato finale
		  
end unita_operativa;

architecture structural of unita_operativa is

	component adder_sub is
	port( X, Y: in std_logic_vector(7 downto 0);
		  cin: in std_logic;
		  Z: out std_logic_vector(7 downto 0);
		  cout: out std_logic);		  
	end component;
	
	component registro8 is 
		port( A: in std_logic_vector(7 downto 0);
		  clk, res, load: in std_logic;
		  B: out std_logic_vector(7 downto 0));
	end component;
	
	component mux_21 is
	generic (width : integer range 0 to 32 := 17);
	port( x0, x1: in std_logic_vector(width-1 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(width-1 downto 0));
	end component;
	
	
	component shift_register is
	port( parallel_in: in std_logic_vector(16 downto 0);
		  serial_in: in std_logic;
		  clock, reset, load, shift: in std_logic;
		  parallel_out: out std_logic_vector(16 downto 0));	  
	end component;
	
	
	component cont_mod8 is
	port( clock,  reset: in std_logic;
		  count_in: in std_logic;
		  count: out std_logic_vector(2 downto 0));
	end component;


	signal Mreg,op2: std_logic_vector(7 downto 0); --segnale temporaneao tra reg8 M 
	signal AQ_init: std_logic_vector(16 downto 0); --segnale in input all'SR 
	signal AQ_in: std_logic_vector(16 downto 0); --segnale in input all'SR 
	signal AQ_out: std_logic_vector(16 downto 0); --segnale temporaneo uscita dell'SR
	signal sum: std_logic_vector(7 downto 0); --uscita del parallel adder 
	signal AQ_sum_in : std_logic_vector(16 downto 0); 
	signal riporto: std_logic; -- riporto in uscita dell'adder che non utilizziamo
	signal  SRserialIn: std_logic;
	
begin
	
	-- 1) predisposizione del secondo operando della somma: 
	
	-- registro moltiplicando
	M: registro8 port map(Y, clock, reset, loadM, Mreg);
	
	-- mux per selezionare moltiplicando oppure 0 come secondo operando della somma
	--qui ci serve per fare in modo che il risultato dell'adder sia stabile
	MUX_molt: mux_21 generic map (width => 8) port map("00000000", Mreg, selM, op2);
	
    -- 2) predisposizione del primo operando della somma:
    
    --stringa da 17 bit da inserire nello shift register A.Q durante la fare di inizializzazone:
    --è ottenuta concatenando 00000000 con il moltiplicatore X e lo 0 che va in Q[-1]
    AQ_init <= "00000000" & X & "0";  --valore da inserire all'inizio nello shift register
    
    --stringa di 17 bit da inserire nello shift register A.Q durante la fase operativa dopo aver effettuato la somma
    AQ_sum_in <=sum & AQ_out(8 downto 0);  
    
    -- mux per selezionare l'ingresso parallelo dello shift register: valore iniziale AQ_init 
    -- oppure uscita dell'adder AQ_sum_in
    MUX_SR_parallel_in : mux_21 generic map (width => 17) port map(AQ_init, AQ_sum_in, selAQ, AQ_in);
    
    
    -- 3) predisposizione dell'ingresso seriale dello shift register: deve prendere sempre 0 in questo caso
	SRserialIn <=AQ_out(16);
    	
	-- 4) shift register A.Q
	SR: shift_register port map(AQ_in, SRserialIn, clock, reset, loadAQ, shift, AQ_out);
	
	-- 5) sommatore
	ADD_SUB: adder_sub port map(AQ_out(16 downto 9), op2, sub, sum, riporto);
	
	-- 6) contatore
	CONT: cont_mod8 port map(clock, reset, en_count, count_in);
	
	--7) uscita del moltiplicatore, corrispondente al valore contenuto nello shift register
	P<=AQ_out;
	test_Mreg<=Mreg;
	test_sum<=sum;

end structural;
