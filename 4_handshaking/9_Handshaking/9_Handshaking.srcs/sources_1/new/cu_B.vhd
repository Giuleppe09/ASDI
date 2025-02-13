library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_B is
    Port (
        -- Segnali esterni
        CLK     : in  std_logic;
        RST     : in  std_logic;
        
        -- Segnali per Handshaking completo
        REQ_in  : in  std_logic;
        ACK_out : out std_logic;
        
        -- Segnale di scrittura per la memoria
        write   : out std_logic;
        
        -- Segnale di stato per debug
        stato   : out std_logic_vector(1 downto 0)
    );
end cu_B;

architecture Behavioral of cu_B is

    -- Definizione degli stati
    type state is (WAIT_4_REQ, SEND_ACK, ABBASSO_ACK, WRITE_IN_MEM);
    signal current_state, next_state: state;

begin
    -- Processo di registrazione dello stato
    reg_stato: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then 
                current_state <= WAIT_4_REQ;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;

    -- Logica combinatoria per le transizioni di stato
    comb: process(current_state, REQ_in) 
    begin 
        -- Inizializzazione segnali di output
        write   <= '0';
        ACK_out <= '0';

        case current_state is
            when WAIT_4_REQ =>
                if REQ_in = '1' then
                    next_state <= SEND_ACK;
                else 
                    next_state <= WAIT_4_REQ;
                end if;
                
            when SEND_ACK =>
                ACK_out <= '1';
                if REQ_in = '0' then
                    next_state <= ABBASSO_ACK;
                else
                    next_state <= SEND_ACK;
                end if;
                
            when ABBASSO_ACK =>
                next_state <= WRITE_IN_MEM;
                
            when WRITE_IN_MEM =>
                write <= '1';
                next_state <= WAIT_4_REQ;
                
            when others =>
                next_state <= WAIT_4_REQ;
        end case;
    end process;
    
    -- Codifica dello stato corrente per debug
    with current_state select 
        stato <= "00" when WAIT_4_REQ,  
                 "01" when SEND_ACK,  
                 "10" when ABBASSO_ACK,
                 "11" when WRITE_IN_MEM;
end Behavioral;
