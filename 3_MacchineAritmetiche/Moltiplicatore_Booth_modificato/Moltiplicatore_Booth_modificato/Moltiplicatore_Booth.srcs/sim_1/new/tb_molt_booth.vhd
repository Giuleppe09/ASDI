library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity tb_molt_booth is
end tb_molt_booth;

architecture testbench of tb_molt_booth is

    -- Component declaration
    component molt_booth
        port(
            clock, reset, start: in std_logic;
            X, Y: in std_logic_vector(7 downto 0);
            P: out std_logic_vector(15 downto 0);
            stop_cu: out std_logic;
            stato: out std_logic_vector(3 downto 0);
            test_sum, test_Mreg: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals
    signal clock, reset, start: std_logic := '0';
    signal X, Y: std_logic_vector(7 downto 0) := (others => '0');
    signal P: std_logic_vector(15 downto 0);
    signal stop_cu: std_logic;
    signal stato: std_logic_vector(3 downto 0);
    signal test_sum, test_Mreg: std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin
    
    -- Instantiate Unit Under Test (UUT)
    UUT: molt_booth port map (
        clock => clock,
        reset => reset,
        start => start,
        X => X,
        Y => Y,
        P => P,
        stop_cu => stop_cu,
        stato => stato,
        test_sum => test_sum,
        test_Mreg => test_Mreg
    );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            clock <= '0';
            wait for clk_period / 2;
            clock <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset iniziale
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        -- **Test Case 1: 5 * 3 = 15**
        X <= "00000101"; -- 5
        Y <= "00000011"; -- 3
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until stop_cu = '1';
        wait for clk_period;
        report "Test 1: X=5, Y=3 -> P=" & integer'image(to_integer(signed(P))) severity note;
        assert P = "00000000000001111" report "Test 1 Failed!" severity error;
      

        -- **Test Case 2: -4 * 2 = -8**
        X <= "11111100"; -- -4 (Two's complement)
        Y <= "00000010"; -- 2
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until stop_cu = '1';
        wait for clk_period;
        report "Test 2: X=-4, Y=2 -> P=" & integer'image(to_integer(signed(P))) severity note;
        assert P = "11111111111111000" report "Test 2 Failed!" severity error;
  

        -- **Test Case 3: -7 * -3 = 21**
        X <= "11111001"; -- -7
        Y <= "11111101"; -- -3
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until stop_cu = '1';
        wait for clk_period;
        report "Test 3: X=-7, Y=-3 -> P=" & integer'image(to_integer(signed(P))) severity note;
        assert P = "0000000000010101" report "Test 3 Failed!" severity error;
       

        -- **Test Case 4: 0 * 10 = 0**
        X <= "00000000";
        Y <= "00001010";
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until stop_cu = '1';
        wait for clk_period;
        report "Test 4: X=0, Y=10 -> P=" & integer'image(to_integer(signed(P))) severity note;
        assert P = "00000000000000000" report "Test 4 Failed!" severity error;
        

        -- **Test Case 5: 7 * 0 = 0**
        X <= "00000111";
        Y <= "00000000";
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until stop_cu = '1';
        wait for clk_period;
        report "Test 5: X=7, Y=0 -> P=" & integer'image(to_integer(signed(P))) severity note;
        assert P = "00000000000000000" report "Test 5 Failed!" severity error;
        

        -- **Monitor test signals**
        report "Final values: test_sum=" & integer'image(to_integer(signed(test_sum))) &
               " test_Mreg=" & integer'image(to_integer(signed(test_Mreg))) severity note;

        report "Testbench completed successfully!" severity note;
        wait;
    end process;
    
end testbench;
