library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- il progetto utilizza un clock divider
entity molt_booth is
	 port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   --stop: out std_logic;	--a che serve?	   
		   P: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic;
		   stato: out std_logic_vector(3 downto 0);
		   test_sum,test_Mreg: out std_logic_vector(7 downto 0));
end molt_booth;

architecture structural of molt_booth is
	component unita_controllo is 
		port( clock, reset, start: in std_logic;
		  Q: in std_logic_vector(1 downto 0);
		  count_in: in std_logic_vector(2 downto 0);
		  loadM, en_count, loadAQ, en_shift: out std_logic;
		  selAQ,selM, subtract, stop_cu: out std_logic;
		  stato: out std_logic_vector(3 downto 0)); 
	end component;
	
	component unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);--moltiplicatore e moltiplicando
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ,selM, en_count: in std_logic;
		  count_in: out std_logic_vector(2 downto 0);
		  P: out std_logic_vector(16 downto 0);
		  test_sum,test_Mreg: out std_logic_vector(7 downto 0)); --risultato finale
	end component;
	
	
	signal  temp_selAQ, temp_sub, temp_loadAQ: std_logic; --temp_clock ci servirà più tardi
	signal temp_count_in: std_logic_vector(2 downto 0);
	signal tempQ: std_logic_vector(1 downto 0) := X(0)&"0" ;
	signal temp_p: std_logic_vector(16 downto 0); --uscita parte operativa (AQ_out)
	signal temp_en_count, t_load_add: std_logic;
	signal fine_conteggio: std_logic;
	signal temp_shift: std_logic;
	signal temp_loadM: std_logic;
	signal temp_stop_cu: std_logic; -- segnale di reset generato dalla UC
	signal temp_reset_in: std_logic; -- segnale di reset in ingresso alla UO
	signal temp_selM: std_logic;
	signal temp_test_sum,temp_test_Mreg:std_logic_vector(7 downto 0);
	
	begin
	
	UC: unita_controllo port map
	( clock, reset, start, tempQ,
	temp_count_in, 
	temp_loadM, temp_en_count, temp_loadAQ, temp_shift, 
	temp_selAQ, temp_selM, temp_sub, temp_stop_cu, stato);
	
		  
	
	UO: unita_operativa port map
	(X, Y, clock, temp_reset_in, temp_loadAQ, temp_shift, temp_loadM, 
	temp_sub, temp_selAQ, temp_selM, temp_en_count, temp_count_in, temp_p,temp_test_sum,temp_test_Mreg); 
	
		  
	tempQ<=temp_p(1 downto 0); --invio all'unità di controllo il bit meno significativo del registro A.Q
	P<=temp_p(16 downto 1);
	
	-- la UO viene resettata sia se arriva un reset dall'esterno sia se l'operazione di moltiplicazione termina
	temp_reset_in <= reset or temp_stop_cu;
	
	stop_cu <= temp_stop_cu;
	test_sum<=temp_test_sum;
	test_Mreg<=temp_test_Mreg;
	
	end structural;