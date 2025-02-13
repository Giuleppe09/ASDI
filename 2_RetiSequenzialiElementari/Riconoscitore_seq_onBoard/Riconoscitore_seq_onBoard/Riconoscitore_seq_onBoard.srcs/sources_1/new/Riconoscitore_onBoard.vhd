library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Riconoscitore_onBoard is
    port(
        RST: in std_logic;
        CLK: in std_logic;
        i: in std_logic;
        i_read: in std_logic;
        M: in std_logic;
        m_read: in std_logic;
        LED: out std_logic;
        state: out std_logic_vector(3 downto 0)
    );
end Riconoscitore_onBoard;

architecture Structural of Riconoscitore_onBoard is

    -- Dichiarazione componenti
    component ButtonDebouncer is
        generic(
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000
        );
        port(
            RST: in std_logic;
            CLK: in std_logic;
            BTN: in std_logic;
            CLEARED_BTN: out std_logic -- segnale di output ripulito
        );
    end component;
    
    component RICONOSCITORE_DI_SEQ is
        port(
            i: in std_logic; --ingresso
            i_read: in std_logic;--permesso di leggere l'ingresso
            RST: in std_logic; 
            M: in std_logic; --modo
            m_read: in std_logic;--permesso di leggere il modo
            Y: out std_logic; --uscita
            state: out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali di appoggio
    signal cleared_i_read: std_logic;
    signal cleared_m_read: std_logic;
   

begin

    -- **Istanziazione del debouncer per i_read**
    deb_i: ButtonDebouncer generic map (
            CLK_period => 10,
            btn_noise_time => 10000000
        )
        port map(
            RST => RST,
            CLK => CLK,
            BTN => i_read,
            CLEARED_BTN => cleared_i_read
    );
    
    -- **Istanziazione del debouncer per m_read**
    deb_m: ButtonDebouncer generic map (
            CLK_period => 10,
            btn_noise_time => 10000000
        )
        port map(
            RST => RST,
            CLK => CLK,
            BTN => m_read,
            CLEARED_BTN => cleared_m_read
    );
    
    -- **Istanziazione del riconoscitore di sequenza**
    ric: RICONOSCITORE_DI_SEQ port map(
        i => i,
        i_read => cleared_i_read,
        RST => RST,
        M => M,
        m_read => cleared_m_read,
        Y => LED,
        state => state
    );

end Structural;
