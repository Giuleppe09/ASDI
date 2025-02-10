
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Priority_sw is
    Port ( 
        mex_A : in std_logic_vector(3 downto 0); --(data + destinazione
        mex_B : in std_logic_vector(3 downto 0);
        mex_C : in std_logic_vector(3 downto 0);
        mex_D : in std_logic_vector(3 downto 0);     

        req_A  : in std_logic;  -- segnale che indica se il nodo A ha un dato valido
        req_B  : in std_logic;
        req_C  : in std_logic;
        req_D  : in std_logic;
        
        --output
        Y_deb:  out std_logic_vector(7 downto 0);
        X_deb: out std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(1 downto 0);
        S_mux,S_demux: out STD_LOGIC_VECTOR(1 downto 0)
    );
end ;

architecture Behavioral of Priority_sw is
    
    component Rete_multistadio is
    Port ( 
        x1 : in std_logic_vector(1 downto 0); -- Ingressi (2 ingressi: A(0) e A(1))
        x2 : in std_logic_vector(1 downto 0);
        x3 : in std_logic_vector(1 downto 0);
        x4 : in std_logic_vector(1 downto 0);
        
        y1 : out STD_LOGIC_VECTOR(1 downto 0);
        y2 : out STD_LOGIC_VECTOR(1 downto 0);
        y3 : out STD_LOGIC_VECTOR(1 downto 0);
        y4 : out STD_LOGIC_VECTOR(1 downto 0);
        
        S_mux,S_demux: in STD_LOGIC_VECTOR(1 downto 0)
        
    );
    end component;
    
    
    --Segnali di appoggio
    signal X: std_logic_vector(7 downto 0);
    signal Y: std_logic_vector(7 downto 0);
    signal temp_mux: std_logic_vector(1 downto 0);
    signal temp_demux: std_logic_vector(1 downto 0);
    
     begin
     
    SM: Rete_multistadio port map (
     
        x1 => X(1 downto 0),
        x2 => X(3 downto 2),
        x3 => X(5 downto 4),
        x4 => X(7 downto 6),
        
        y1 => Y(1 downto 0),
        y2 => Y(3 downto 2),
        y3 => Y(5 downto 4),
        y4 => Y(7 downto 6),
        
        S_mux => temp_mux,
        S_demux => temp_demux     
        );
        
     --Arbitro a priorità
     process_Arbitro : process(req_A, req_B, req_C, req_D, mex_A, mex_B, mex_C, mex_D)
        begin 
            
            -- Priorità: A > B > C > D
            if (req_A = '1') then 
                temp_mux <= "00";
                X(1 downto 0) <= mex_A(3 downto 2);
                temp_demux <= mex_A(1 downto 0);
        
            elsif (req_B = '1') then
                temp_mux <= "01";
                X(3 downto 2) <= mex_B(3 downto 2);
                temp_demux <= mex_B(1 downto 0);
        
            elsif (req_C = '1') then
                temp_mux <= "10";
                X(5 downto 4) <= mex_C(3 downto 2);
                temp_demux <= mex_C(1 downto 0);
        
            elsif (req_D = '1') then
                temp_mux <= "11";
                X(7 downto 6) <= mex_D(3 downto 2); 
                temp_demux <= mex_D(1 downto 0);
            end if;
        end process;
       
       --per avere in output solo 2 bit
       process_output : process(Y, temp_demux)
        begin 
            case temp_demux is
                when "00" => 
                    data_out <= Y(1 downto 0);
                when "01" => 
                    data_out <= Y(3 downto 2);
                when "10" => 
                    data_out <= Y(5 downto 4);
                when "11" =>
                    data_out <= Y(7 downto 6);
                when others =>
                    data_out <= "00";
            end case;
        end process;
      
      --per debug
       X_deb <= X;
       Y_deb <= Y;
       S_mux <= temp_mux;
       S_demux <= temp_demux;
       
end Behavioral;
