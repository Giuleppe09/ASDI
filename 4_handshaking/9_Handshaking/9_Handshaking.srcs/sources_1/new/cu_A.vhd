library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_A is
   Port ( 
            start     : in  std_logic;
            CLK       : in  std_logic;
            RST       : in  std_logic;
        
            -- Segnali Per Handshaking 
            REQ_out   : out std_logic;
            ACK_in    : in  std_logic;
        
            -- Segnali interni all'entità 
            count_in  : in  std_logic_vector(2 downto 0);
            rst_count : out std_logic;
            en_count  : out std_logic;
            read      : out std_logic;
        
            -- Segnali per debug
            stato     : out std_logic_vector(2 downto 0)
        );
end cu_A;

architecture Behavioral of cu_A is

    -- Definizione stati
    type state is (IDLE, WRITE_ON_BUS, SEND_REQ, WAIT_4_ACK, ABBASSO_REQ, WAIT_4_ACK0, CHECK_COUNT);
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
    comb: process(current_state, start, ACK_in, count_in)
    begin
        -- Inizializzazione segnali
        rst_count <= '0';
        en_count  <= '0';

        case current_state is
            when IDLE =>
                rst_count <= '1';
                if start = '1' then
                    next_state <= WRITE_ON_BUS;
                else 
                    next_state <= IDLE;
                end if;

            when WRITE_ON_BUS =>
                read <= '1';
                next_state <= SEND_REQ;
                
            when SEND_REQ =>
                REQ_out <= '1';
                next_state <= WAIT_4_ACK;

            when WAIT_4_ACK =>
                if ACK_in = '1' then
                    next_state <= ABBASSO_REQ;
                else
                    next_state <= WAIT_4_ACK;
                end if;

            when ABBASSO_REQ =>
                REQ_out <= '0';
                next_state <= WAIT_4_ACK0;
                
            when WAIT_4_ACK0 =>
                if ACK_in = '1' then
                    next_state <= WAIT_4_ACK0;
                else 
                    next_state <= CHECK_COUNT;
                end if;
                
            when CHECK_COUNT =>
                en_count <= '1';
                if count_in = "111" then
                    next_state <= IDLE;
                else 
                    next_state <= SEND_REQ;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- Assegna lo stato corrente all'output per debug
    with current_state select
        stato <= "000" when IDLE,
                 "001" when WRITE_ON_BUS,
                 "010" when SEND_REQ,
                 "011" when WAIT_4_ACK,
                 "100" when ABBASSO_REQ,
                 "101" when WAIT_4_ACK0,
                 "110" when CHECK_COUNT,
                 "000" when others;

end Behavioral;
