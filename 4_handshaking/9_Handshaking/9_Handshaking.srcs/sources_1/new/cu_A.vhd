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
        
        REQ_in: in std_logic;
        ACK_out: out std_logic;
        
        --Segnali interni all'entità A
        count_in: in std_logic_vector(2 downto 0);
        ris: in std_logic; --uscita comparatore
        rst_count: out std_logic; --Da dare al contatore
        en_count: out std_logic; --Da dare al contatore
        write: out std_logic; --Da dare alla MEM
        start_T: out std_logic; --start del timer
        reset_T: out std_logic; --reset del timer
        
        --Stato in out
        stato: out std_logic_vector(2 downto 0)
    );
end cu_A;

architecture Behavioral of cu_A is

    -- Definizione stati
    type state is (IDLE, SEND_REQ, WAIT_4_ACK, OK_ACK, SEND_ACK, CHECK_RIS, WRITE_IN_MEM, CHECK_COUNT, FINE);
    signal current_state, next_state: state;

begin
    -- Processo di registrazione dello stato
    reg_stato: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                current_state <= IDLE;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    -- Logica combinatoria per transizioni di stato
    comb: process(current_state, start, ACK_in, REQ_in, ris, count_in)
    begin
        -- Inizializzazione segnali
        rst_count <= '0';
        en_count <= '0';
        write <= '0';
        start_T <= '0';
        reset_T <= '0';
        
        case current_state is
            when IDLE =>
                rst_count <= '1';
                if start = '1' then
                    next_state <= SEND_REQ;
                else 
                    next_state <= IDLE;
                end if;

            when SEND_REQ =>
                REQ_out <= '1';
                start_T <= '1';
                next_state <= WAIT_4_ACK;

            when WAIT_4_ACK =>
                if ACK_in = '1' then
                    next_state <= OK_ACK;
                else
                    next_state <= WAIT_4_ACK;
                end if;

            when OK_ACK =>
                REQ_out <= '0';
                if REQ_in = '1' then
                    next_state <= SEND_ACK;
                else
                    next_state <= OK_ACK;
                end if;

            when SEND_ACK =>
                ACK_out <= '1';
                next_state <= CHECK_RIS;

            when CHECK_RIS =>
                ACK_out <= '0';
                Reset_T <='1';
                if ris = '1' then
                    next_state <= WRITE_IN_MEM;
                else
                    next_state <= CHECK_COUNT;
                end if;

            when WRITE_IN_MEM =>
                write <= '1';
                next_state <= CHECK_COUNT;

            when CHECK_COUNT =>
                en_count <= '1';
                if count_in = "111" then
                    next_state <= FINE;
                else 
                    next_state <= SEND_REQ;
                end if;

            when FINE =>
                -- Stato di fine elaborazione, resta fermo
                next_state <= FINE;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- Assegna lo stato corrente all'output
    with current_state select
        stato <= "000" when IDLE,
                 "001" when SEND_REQ,
                 "010" when WAIT_4_ACK,
                 "011" when OK_ACK,
                 "100" when SEND_ACK,
                 "101" when CHECK_RIS,
                 "110" when WRITE_IN_MEM,
                 "111" when CHECK_COUNT,
                 "001" when FINE,
                 "000" when others;

end Behavioral;
