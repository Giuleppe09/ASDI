library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RCA_Nbit is
	generic (N: natural range 0 to 32 := 4); -- sto definendo un parametro
	port(
		OP_A_RCA: in std_logic_vector(N-1 downto 0);
		OP_B_RCA: in std_logic_vector(N-1 downto 0);
		CIN_RCA: in std_logic;
		
		S_RCA: out std_logic_vector(N-1 downto 0);
		COUT_RCA: out std_logic;
		OV: out std_logic
	);
end RCA_Nbit;

architecture dataflow of RCA_Nbit is

	component myFA is
	   port(
		OP_A: in std_logic;
		OP_B: in std_logic;
		CIN: in std_logic;
	
		S: out std_logic; --se un segnale è in uscita non posso leggerlo
		COUT: out std_logic
		);
	end component;
	signal cout_int: std_logic_vector(N-1 downto 0);
	signal s_int: std_logic_vector(N-1 downto 0);
	
begin
	
	
	
	
	
	FA_0_to_N_1: for i in 0 to N-1 generate
	
	    IF_CLAUSE: if i=0 generate
	       --statemente componente (sto facendo il portmap)
	       --sto collegando i fili che vengono da fuori, 
            FA_0: myFA port map(
            --mi sto predendo il bit meno significativo
            OP_A => OP_A_RCA(0), 
            OP_B => OP_B_RCA(0),
            CIN => CIN_RCA,
            S => s_int(0), --uso un'uscita di appoggio s
            COUT => cout_int(0)
            );
     	end generate IF_CLAUSE;
     	
     	ELSE_CLAUSE: if i/= 0 generate --non uso ELSIF perchè è supportato in VHDL2008 
     	                               --che non è la versione di default usata in vivado
	    
	 		FA_comp: myFA port map(
			OP_A => OP_A_RCA(i),
			OP_B => OP_B_RCA(i),
			CIN => cout_int(i-1), --riporto del precedente
			COUT => cout_int(i),  --riporto in uscita
			S => s_int(i)         --Mi serve un segnale di appoggio 
			-- perchè se lo mando in uscita non posso leggerlo poi
		);
	    end generate ELSE_CLAUSE;
	    
	end generate FA_0_to_N_1;
	
		
	S_RCA <= s_int; --ora leggo s_int, per questo ho definito il segnale di appoggio
	-- mi serve leggere il segno per vedere se sono andata in overflow
	COUT_RCA <= cout_int(N-1);
	
	OV <= (OP_A_RCA(N-1) and OP_B_RCA(N-1) and not s_int(N-1)) or (not OP_A_RCA(N-1) and not OP_B_RCA(N-1) and s_int(N-1));
	
end dataflow;









