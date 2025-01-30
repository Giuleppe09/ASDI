-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
-- Date        : Thu Jan 30 13:19:35 2025
-- Host        : MadamImAdam running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/ladyc/Desktop/ASDI/VIVADO-PROJECTS/Riconoscitore_seq_onBoard/Riconoscitore_seq_onBoard.sim/sim_1/impl/func/xsim/Riconoscitore_onBoard_func_impl.vhd
-- Design      : Riconoscitore_onBoard
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ButtonDebouncer is
  port (
    CLEARED_BTN : out STD_LOGIC;
    RST_IBUF : in STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC;
    i_read_IBUF : in STD_LOGIC
  );
end ButtonDebouncer;

architecture STRUCTURE of ButtonDebouncer is
  signal BTN_state : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \BTN_state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^cleared_btn\ : STD_LOGIC;
  signal CLEARED_BTN_i_1_n_0 : STD_LOGIC;
  signal CLEARED_BTN_i_2_n_0 : STD_LOGIC;
  signal CLEARED_BTN_i_3_n_0 : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_7_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_8_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_9_n_0\ : STD_LOGIC;
  signal count : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \deb.count[0]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count[31]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count[31]_i_2_n_0\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[0]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[10]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[11]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[12]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[13]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[14]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[15]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[16]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[17]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[18]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[19]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[1]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[20]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[21]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[22]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[23]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[24]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[25]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[26]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[27]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[28]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[29]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[2]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[30]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[31]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[3]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[4]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[5]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[6]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[7]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[8]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[9]\ : STD_LOGIC;
  signal \NLW_deb.count_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[24]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[31]_i_3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_deb.count_reg[31]_i_3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_deb.count_reg[4]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_BTN_state_reg[0]\ : label is "chk_pressed:01,chk_not_pressed:11,pressed:10,not_pressed:00";
  attribute FSM_ENCODED_STATES of \FSM_sequential_BTN_state_reg[1]\ : label is "chk_pressed:01,chk_not_pressed:11,pressed:10,not_pressed:00";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \deb.count_reg[12]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[16]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[20]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[24]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[28]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[31]_i_3\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[4]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[8]_i_1\ : label is 35;
begin
  CLEARED_BTN <= \^cleared_btn\;
CLEARED_BTN_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FFFF00001000"
    )
        port map (
      I0 => CLEARED_BTN_i_2_n_0,
      I1 => \FSM_sequential_BTN_state[1]_i_4_n_0\,
      I2 => i_read_IBUF,
      I3 => count,
      I4 => BTN_state(1),
      I5 => \^cleared_btn\,
      O => CLEARED_BTN_i_1_n_0
    );
CLEARED_BTN_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \FSM_sequential_BTN_state[1]_i_2_n_0\,
      I1 => \FSM_sequential_BTN_state[1]_i_8_n_0\,
      I2 => \FSM_sequential_BTN_state[1]_i_7_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_6_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_5_n_0\,
      I5 => CLEARED_BTN_i_3_n_0,
      O => CLEARED_BTN_i_2_n_0
    );
CLEARED_BTN_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[16]\,
      I1 => \deb.count_reg_n_0_[17]\,
      O => CLEARED_BTN_i_3_n_0
    );
CLEARED_BTN_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => CLEARED_BTN_i_1_n_0,
      Q => \^cleared_btn\,
      R => RST_IBUF
    );
\FSM_sequential_BTN_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F6F6F6F6F6F6F606"
    )
        port map (
      I0 => BTN_state(1),
      I1 => i_read_IBUF,
      I2 => count,
      I3 => \FSM_sequential_BTN_state[1]_i_4_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_3_n_0\,
      I5 => \FSM_sequential_BTN_state[1]_i_2_n_0\,
      O => \BTN_state__0\(0)
    );
\FSM_sequential_BTN_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => BTN_state(1),
      I1 => \FSM_sequential_BTN_state[1]_i_2_n_0\,
      I2 => \FSM_sequential_BTN_state[1]_i_3_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_4_n_0\,
      I4 => count,
      I5 => i_read_IBUF,
      O => \BTN_state__0\(1)
    );
\FSM_sequential_BTN_state[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \deb.count_reg_n_0_[25]\,
      I1 => \deb.count_reg_n_0_[24]\,
      I2 => \deb.count_reg_n_0_[23]\,
      I3 => \deb.count_reg_n_0_[22]\,
      O => \FSM_sequential_BTN_state[1]_i_2_n_0\
    );
\FSM_sequential_BTN_state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[17]\,
      I1 => \deb.count_reg_n_0_[16]\,
      I2 => \FSM_sequential_BTN_state[1]_i_5_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_6_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_7_n_0\,
      I5 => \FSM_sequential_BTN_state[1]_i_8_n_0\,
      O => \FSM_sequential_BTN_state[1]_i_3_n_0\
    );
\FSM_sequential_BTN_state[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \FSM_sequential_BTN_state[1]_i_9_n_0\,
      I1 => \deb.count_reg_n_0_[26]\,
      I2 => \deb.count_reg_n_0_[27]\,
      I3 => \deb.count_reg_n_0_[28]\,
      I4 => \deb.count_reg_n_0_[29]\,
      O => \FSM_sequential_BTN_state[1]_i_4_n_0\
    );
\FSM_sequential_BTN_state[1]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[7]\,
      I1 => \deb.count_reg_n_0_[6]\,
      I2 => \deb.count_reg_n_0_[5]\,
      I3 => \deb.count_reg_n_0_[4]\,
      O => \FSM_sequential_BTN_state[1]_i_5_n_0\
    );
\FSM_sequential_BTN_state[1]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[3]\,
      I1 => \deb.count_reg_n_0_[2]\,
      I2 => \deb.count_reg_n_0_[1]\,
      I3 => \deb.count_reg_n_0_[0]\,
      O => \FSM_sequential_BTN_state[1]_i_6_n_0\
    );
\FSM_sequential_BTN_state[1]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => \deb.count_reg_n_0_[14]\,
      I1 => \deb.count_reg_n_0_[15]\,
      I2 => \deb.count_reg_n_0_[13]\,
      I3 => \deb.count_reg_n_0_[12]\,
      O => \FSM_sequential_BTN_state[1]_i_7_n_0\
    );
\FSM_sequential_BTN_state[1]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[11]\,
      I1 => \deb.count_reg_n_0_[10]\,
      I2 => \deb.count_reg_n_0_[9]\,
      I3 => \deb.count_reg_n_0_[8]\,
      O => \FSM_sequential_BTN_state[1]_i_8_n_0\
    );
\FSM_sequential_BTN_state[1]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[18]\,
      I1 => \deb.count_reg_n_0_[19]\,
      I2 => \deb.count_reg_n_0_[20]\,
      I3 => \deb.count_reg_n_0_[21]\,
      I4 => \deb.count_reg_n_0_[31]\,
      I5 => \deb.count_reg_n_0_[30]\,
      O => \FSM_sequential_BTN_state[1]_i_9_n_0\
    );
\FSM_sequential_BTN_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \BTN_state__0\(0),
      Q => count,
      R => RST_IBUF
    );
\FSM_sequential_BTN_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \BTN_state__0\(1),
      Q => BTN_state(1),
      R => RST_IBUF
    );
\deb.count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
        port map (
      I0 => RST_IBUF,
      I1 => count,
      I2 => \deb.count_reg_n_0_[0]\,
      O => \deb.count[0]_i_1_n_0\
    );
\deb.count[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => RST_IBUF,
      I1 => count,
      I2 => \FSM_sequential_BTN_state[1]_i_2_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_3_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_4_n_0\,
      O => \deb.count[31]_i_1_n_0\
    );
\deb.count[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => count,
      I1 => RST_IBUF,
      O => \deb.count[31]_i_2_n_0\
    );
\deb.count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \deb.count[0]_i_1_n_0\,
      Q => \deb.count_reg_n_0_[0]\,
      R => '0'
    );
\deb.count_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(10),
      Q => \deb.count_reg_n_0_[10]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(11),
      Q => \deb.count_reg_n_0_[11]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(12),
      Q => \deb.count_reg_n_0_[12]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[8]_i_1_n_0\,
      CO(3) => \deb.count_reg[12]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[12]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3) => \deb.count_reg_n_0_[12]\,
      S(2) => \deb.count_reg_n_0_[11]\,
      S(1) => \deb.count_reg_n_0_[10]\,
      S(0) => \deb.count_reg_n_0_[9]\
    );
\deb.count_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(13),
      Q => \deb.count_reg_n_0_[13]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(14),
      Q => \deb.count_reg_n_0_[14]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(15),
      Q => \deb.count_reg_n_0_[15]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(16),
      Q => \deb.count_reg_n_0_[16]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[12]_i_1_n_0\,
      CO(3) => \deb.count_reg[16]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[16]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(16 downto 13),
      S(3) => \deb.count_reg_n_0_[16]\,
      S(2) => \deb.count_reg_n_0_[15]\,
      S(1) => \deb.count_reg_n_0_[14]\,
      S(0) => \deb.count_reg_n_0_[13]\
    );
\deb.count_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(17),
      Q => \deb.count_reg_n_0_[17]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(18),
      Q => \deb.count_reg_n_0_[18]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(19),
      Q => \deb.count_reg_n_0_[19]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(1),
      Q => \deb.count_reg_n_0_[1]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(20),
      Q => \deb.count_reg_n_0_[20]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[16]_i_1_n_0\,
      CO(3) => \deb.count_reg[20]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[20]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(20 downto 17),
      S(3) => \deb.count_reg_n_0_[20]\,
      S(2) => \deb.count_reg_n_0_[19]\,
      S(1) => \deb.count_reg_n_0_[18]\,
      S(0) => \deb.count_reg_n_0_[17]\
    );
\deb.count_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(21),
      Q => \deb.count_reg_n_0_[21]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(22),
      Q => \deb.count_reg_n_0_[22]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(23),
      Q => \deb.count_reg_n_0_[23]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(24),
      Q => \deb.count_reg_n_0_[24]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[20]_i_1_n_0\,
      CO(3) => \deb.count_reg[24]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[24]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(24 downto 21),
      S(3) => \deb.count_reg_n_0_[24]\,
      S(2) => \deb.count_reg_n_0_[23]\,
      S(1) => \deb.count_reg_n_0_[22]\,
      S(0) => \deb.count_reg_n_0_[21]\
    );
\deb.count_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(25),
      Q => \deb.count_reg_n_0_[25]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(26),
      Q => \deb.count_reg_n_0_[26]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(27),
      Q => \deb.count_reg_n_0_[27]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(28),
      Q => \deb.count_reg_n_0_[28]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[24]_i_1_n_0\,
      CO(3) => \deb.count_reg[28]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[28]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(28 downto 25),
      S(3) => \deb.count_reg_n_0_[28]\,
      S(2) => \deb.count_reg_n_0_[27]\,
      S(1) => \deb.count_reg_n_0_[26]\,
      S(0) => \deb.count_reg_n_0_[25]\
    );
\deb.count_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(29),
      Q => \deb.count_reg_n_0_[29]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(2),
      Q => \deb.count_reg_n_0_[2]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(30),
      Q => \deb.count_reg_n_0_[30]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(31),
      Q => \deb.count_reg_n_0_[31]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[31]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[28]_i_1_n_0\,
      CO(3 downto 0) => \NLW_deb.count_reg[31]_i_3_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_deb.count_reg[31]_i_3_O_UNCONNECTED\(3),
      O(2 downto 0) => data0(31 downto 29),
      S(3) => '0',
      S(2) => \deb.count_reg_n_0_[31]\,
      S(1) => \deb.count_reg_n_0_[30]\,
      S(0) => \deb.count_reg_n_0_[29]\
    );
\deb.count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(3),
      Q => \deb.count_reg_n_0_[3]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(4),
      Q => \deb.count_reg_n_0_[4]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \deb.count_reg[4]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[4]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \deb.count_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3) => \deb.count_reg_n_0_[4]\,
      S(2) => \deb.count_reg_n_0_[3]\,
      S(1) => \deb.count_reg_n_0_[2]\,
      S(0) => \deb.count_reg_n_0_[1]\
    );
\deb.count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(5),
      Q => \deb.count_reg_n_0_[5]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(6),
      Q => \deb.count_reg_n_0_[6]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(7),
      Q => \deb.count_reg_n_0_[7]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(8),
      Q => \deb.count_reg_n_0_[8]\,
      R => \deb.count[31]_i_1_n_0\
    );
\deb.count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[4]_i_1_n_0\,
      CO(3) => \deb.count_reg[8]_i_1_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[8]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3) => \deb.count_reg_n_0_[8]\,
      S(2) => \deb.count_reg_n_0_[7]\,
      S(1) => \deb.count_reg_n_0_[6]\,
      S(0) => \deb.count_reg_n_0_[5]\
    );
\deb.count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2_n_0\,
      D => data0(9),
      Q => \deb.count_reg_n_0_[9]\,
      R => \deb.count[31]_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ButtonDebouncer_0 is
  port (
    reg_M : out STD_LOGIC;
    RST_IBUF : in STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC;
    m_read_IBUF : in STD_LOGIC;
    CLEARED_BTN : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ButtonDebouncer_0 : entity is "ButtonDebouncer";
end ButtonDebouncer_0;

architecture STRUCTURE of ButtonDebouncer_0 is
  signal BTN_state : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \BTN_state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \CLEARED_BTN_i_1__0_n_0\ : STD_LOGIC;
  signal \CLEARED_BTN_i_2__0_n_0\ : STD_LOGIC;
  signal \CLEARED_BTN_i_3__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_3__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_4__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_5__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_6__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_7__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_8__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_BTN_state[1]_i_9__0_n_0\ : STD_LOGIC;
  signal cleared_m_read : STD_LOGIC;
  signal count : STD_LOGIC;
  signal \deb.count[0]_i_1_n_0\ : STD_LOGIC;
  signal \deb.count[31]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count[31]_i_2__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[12]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[16]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[20]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[24]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[28]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[31]_i_3__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[31]_i_3__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[31]_i_3__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[4]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1__0_n_0\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1__0_n_4\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1__0_n_5\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1__0_n_6\ : STD_LOGIC;
  signal \deb.count_reg[8]_i_1__0_n_7\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[0]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[10]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[11]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[12]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[13]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[14]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[15]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[16]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[17]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[18]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[19]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[1]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[20]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[21]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[22]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[23]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[24]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[25]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[26]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[27]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[28]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[29]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[2]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[30]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[31]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[3]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[4]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[5]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[6]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[7]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[8]\ : STD_LOGIC;
  signal \deb.count_reg_n_0_[9]\ : STD_LOGIC;
  signal \NLW_deb.count_reg[12]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[16]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[20]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[24]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[28]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[31]_i_3__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_deb.count_reg[31]_i_3__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_deb.count_reg[4]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_deb.count_reg[8]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_BTN_state_reg[0]\ : label is "chk_pressed:01,chk_not_pressed:11,pressed:10,not_pressed:00";
  attribute FSM_ENCODED_STATES of \FSM_sequential_BTN_state_reg[1]\ : label is "chk_pressed:01,chk_not_pressed:11,pressed:10,not_pressed:00";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \deb.count_reg[12]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[16]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[20]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[24]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[28]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[31]_i_3__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[4]_i_1__0\ : label is 35;
  attribute ADDER_THRESHOLD of \deb.count_reg[8]_i_1__0\ : label is 35;
begin
\CLEARED_BTN_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FFFF00001000"
    )
        port map (
      I0 => \CLEARED_BTN_i_2__0_n_0\,
      I1 => \FSM_sequential_BTN_state[1]_i_4__0_n_0\,
      I2 => m_read_IBUF,
      I3 => count,
      I4 => BTN_state(1),
      I5 => cleared_m_read,
      O => \CLEARED_BTN_i_1__0_n_0\
    );
\CLEARED_BTN_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \FSM_sequential_BTN_state[1]_i_2__0_n_0\,
      I1 => \FSM_sequential_BTN_state[1]_i_8__0_n_0\,
      I2 => \FSM_sequential_BTN_state[1]_i_7__0_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_6__0_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_5__0_n_0\,
      I5 => \CLEARED_BTN_i_3__0_n_0\,
      O => \CLEARED_BTN_i_2__0_n_0\
    );
\CLEARED_BTN_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[16]\,
      I1 => \deb.count_reg_n_0_[17]\,
      O => \CLEARED_BTN_i_3__0_n_0\
    );
CLEARED_BTN_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \CLEARED_BTN_i_1__0_n_0\,
      Q => cleared_m_read,
      R => RST_IBUF
    );
\FSM_sequential_BTN_state[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F6F6F6F6F6F6F606"
    )
        port map (
      I0 => BTN_state(1),
      I1 => m_read_IBUF,
      I2 => count,
      I3 => \FSM_sequential_BTN_state[1]_i_4__0_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_3__0_n_0\,
      I5 => \FSM_sequential_BTN_state[1]_i_2__0_n_0\,
      O => \BTN_state__0\(0)
    );
\FSM_sequential_BTN_state[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => BTN_state(1),
      I1 => \FSM_sequential_BTN_state[1]_i_2__0_n_0\,
      I2 => \FSM_sequential_BTN_state[1]_i_3__0_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_4__0_n_0\,
      I4 => count,
      I5 => m_read_IBUF,
      O => \BTN_state__0\(1)
    );
\FSM_sequential_BTN_state[1]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \deb.count_reg_n_0_[25]\,
      I1 => \deb.count_reg_n_0_[24]\,
      I2 => \deb.count_reg_n_0_[23]\,
      I3 => \deb.count_reg_n_0_[22]\,
      O => \FSM_sequential_BTN_state[1]_i_2__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[17]\,
      I1 => \deb.count_reg_n_0_[16]\,
      I2 => \FSM_sequential_BTN_state[1]_i_5__0_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_6__0_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_7__0_n_0\,
      I5 => \FSM_sequential_BTN_state[1]_i_8__0_n_0\,
      O => \FSM_sequential_BTN_state[1]_i_3__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \FSM_sequential_BTN_state[1]_i_9__0_n_0\,
      I1 => \deb.count_reg_n_0_[26]\,
      I2 => \deb.count_reg_n_0_[27]\,
      I3 => \deb.count_reg_n_0_[28]\,
      I4 => \deb.count_reg_n_0_[29]\,
      O => \FSM_sequential_BTN_state[1]_i_4__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_5__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[7]\,
      I1 => \deb.count_reg_n_0_[6]\,
      I2 => \deb.count_reg_n_0_[5]\,
      I3 => \deb.count_reg_n_0_[4]\,
      O => \FSM_sequential_BTN_state[1]_i_5__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_6__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[3]\,
      I1 => \deb.count_reg_n_0_[2]\,
      I2 => \deb.count_reg_n_0_[1]\,
      I3 => \deb.count_reg_n_0_[0]\,
      O => \FSM_sequential_BTN_state[1]_i_6__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_7__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => \deb.count_reg_n_0_[14]\,
      I1 => \deb.count_reg_n_0_[15]\,
      I2 => \deb.count_reg_n_0_[13]\,
      I3 => \deb.count_reg_n_0_[12]\,
      O => \FSM_sequential_BTN_state[1]_i_7__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_8__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => \deb.count_reg_n_0_[11]\,
      I1 => \deb.count_reg_n_0_[10]\,
      I2 => \deb.count_reg_n_0_[9]\,
      I3 => \deb.count_reg_n_0_[8]\,
      O => \FSM_sequential_BTN_state[1]_i_8__0_n_0\
    );
\FSM_sequential_BTN_state[1]_i_9__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF7"
    )
        port map (
      I0 => \deb.count_reg_n_0_[18]\,
      I1 => \deb.count_reg_n_0_[19]\,
      I2 => \deb.count_reg_n_0_[20]\,
      I3 => \deb.count_reg_n_0_[21]\,
      I4 => \deb.count_reg_n_0_[31]\,
      I5 => \deb.count_reg_n_0_[30]\,
      O => \FSM_sequential_BTN_state[1]_i_9__0_n_0\
    );
\FSM_sequential_BTN_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \BTN_state__0\(0),
      Q => count,
      R => RST_IBUF
    );
\FSM_sequential_BTN_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \BTN_state__0\(1),
      Q => BTN_state(1),
      R => RST_IBUF
    );
\deb.count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
        port map (
      I0 => RST_IBUF,
      I1 => count,
      I2 => \deb.count_reg_n_0_[0]\,
      O => \deb.count[0]_i_1_n_0\
    );
\deb.count[31]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => RST_IBUF,
      I1 => count,
      I2 => \FSM_sequential_BTN_state[1]_i_2__0_n_0\,
      I3 => \FSM_sequential_BTN_state[1]_i_3__0_n_0\,
      I4 => \FSM_sequential_BTN_state[1]_i_4__0_n_0\,
      O => \deb.count[31]_i_1__0_n_0\
    );
\deb.count[31]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => count,
      I1 => RST_IBUF,
      O => \deb.count[31]_i_2__0_n_0\
    );
\deb.count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \deb.count[0]_i_1_n_0\,
      Q => \deb.count_reg_n_0_[0]\,
      R => '0'
    );
\deb.count_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[12]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[10]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[12]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[11]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[12]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[12]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[12]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[8]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[12]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[12]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[12]_i_1__0_n_4\,
      O(2) => \deb.count_reg[12]_i_1__0_n_5\,
      O(1) => \deb.count_reg[12]_i_1__0_n_6\,
      O(0) => \deb.count_reg[12]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[12]\,
      S(2) => \deb.count_reg_n_0_[11]\,
      S(1) => \deb.count_reg_n_0_[10]\,
      S(0) => \deb.count_reg_n_0_[9]\
    );
\deb.count_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[16]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[13]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[16]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[14]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[16]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[15]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[16]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[16]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[16]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[12]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[16]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[16]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[16]_i_1__0_n_4\,
      O(2) => \deb.count_reg[16]_i_1__0_n_5\,
      O(1) => \deb.count_reg[16]_i_1__0_n_6\,
      O(0) => \deb.count_reg[16]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[16]\,
      S(2) => \deb.count_reg_n_0_[15]\,
      S(1) => \deb.count_reg_n_0_[14]\,
      S(0) => \deb.count_reg_n_0_[13]\
    );
\deb.count_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[20]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[17]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[20]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[18]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[20]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[19]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[4]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[1]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[20]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[20]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[20]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[16]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[20]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[20]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[20]_i_1__0_n_4\,
      O(2) => \deb.count_reg[20]_i_1__0_n_5\,
      O(1) => \deb.count_reg[20]_i_1__0_n_6\,
      O(0) => \deb.count_reg[20]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[20]\,
      S(2) => \deb.count_reg_n_0_[19]\,
      S(1) => \deb.count_reg_n_0_[18]\,
      S(0) => \deb.count_reg_n_0_[17]\
    );
\deb.count_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[24]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[21]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[24]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[22]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[24]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[23]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[24]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[24]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[24]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[20]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[24]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[24]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[24]_i_1__0_n_4\,
      O(2) => \deb.count_reg[24]_i_1__0_n_5\,
      O(1) => \deb.count_reg[24]_i_1__0_n_6\,
      O(0) => \deb.count_reg[24]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[24]\,
      S(2) => \deb.count_reg_n_0_[23]\,
      S(1) => \deb.count_reg_n_0_[22]\,
      S(0) => \deb.count_reg_n_0_[21]\
    );
\deb.count_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[28]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[25]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[28]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[26]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[28]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[27]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[28]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[28]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[28]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[24]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[28]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[28]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[28]_i_1__0_n_4\,
      O(2) => \deb.count_reg[28]_i_1__0_n_5\,
      O(1) => \deb.count_reg[28]_i_1__0_n_6\,
      O(0) => \deb.count_reg[28]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[28]\,
      S(2) => \deb.count_reg_n_0_[27]\,
      S(1) => \deb.count_reg_n_0_[26]\,
      S(0) => \deb.count_reg_n_0_[25]\
    );
\deb.count_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[31]_i_3__0_n_7\,
      Q => \deb.count_reg_n_0_[29]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[4]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[2]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[31]_i_3__0_n_6\,
      Q => \deb.count_reg_n_0_[30]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[31]_i_3__0_n_5\,
      Q => \deb.count_reg_n_0_[31]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[31]_i_3__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[28]_i_1__0_n_0\,
      CO(3 downto 0) => \NLW_deb.count_reg[31]_i_3__0_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_deb.count_reg[31]_i_3__0_O_UNCONNECTED\(3),
      O(2) => \deb.count_reg[31]_i_3__0_n_5\,
      O(1) => \deb.count_reg[31]_i_3__0_n_6\,
      O(0) => \deb.count_reg[31]_i_3__0_n_7\,
      S(3) => '0',
      S(2) => \deb.count_reg_n_0_[31]\,
      S(1) => \deb.count_reg_n_0_[30]\,
      S(0) => \deb.count_reg_n_0_[29]\
    );
\deb.count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[4]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[3]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[4]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[4]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[4]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \deb.count_reg[4]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[4]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \deb.count_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[4]_i_1__0_n_4\,
      O(2) => \deb.count_reg[4]_i_1__0_n_5\,
      O(1) => \deb.count_reg[4]_i_1__0_n_6\,
      O(0) => \deb.count_reg[4]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[4]\,
      S(2) => \deb.count_reg_n_0_[3]\,
      S(1) => \deb.count_reg_n_0_[2]\,
      S(0) => \deb.count_reg_n_0_[1]\
    );
\deb.count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[8]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[5]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[8]_i_1__0_n_6\,
      Q => \deb.count_reg_n_0_[6]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[8]_i_1__0_n_5\,
      Q => \deb.count_reg_n_0_[7]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[8]_i_1__0_n_4\,
      Q => \deb.count_reg_n_0_[8]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
\deb.count_reg[8]_i_1__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \deb.count_reg[4]_i_1__0_n_0\,
      CO(3) => \deb.count_reg[8]_i_1__0_n_0\,
      CO(2 downto 0) => \NLW_deb.count_reg[8]_i_1__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \deb.count_reg[8]_i_1__0_n_4\,
      O(2) => \deb.count_reg[8]_i_1__0_n_5\,
      O(1) => \deb.count_reg[8]_i_1__0_n_6\,
      O(0) => \deb.count_reg[8]_i_1__0_n_7\,
      S(3) => \deb.count_reg_n_0_[8]\,
      S(2) => \deb.count_reg_n_0_[7]\,
      S(1) => \deb.count_reg_n_0_[6]\,
      S(0) => \deb.count_reg_n_0_[5]\
    );
\deb.count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => \deb.count[31]_i_2__0_n_0\,
      D => \deb.count_reg[12]_i_1__0_n_7\,
      Q => \deb.count_reg_n_0_[9]\,
      R => \deb.count[31]_i_1__0_n_0\
    );
reg_M_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cleared_m_read,
      I1 => CLEARED_BTN,
      O => reg_M
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Control_unit is
  port (
    i_out : out STD_LOGIC;
    m_out : out STD_LOGIC;
    RST_IBUF : in STD_LOGIC;
    CLEARED_BTN : in STD_LOGIC;
    i_IBUF : in STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC;
    reg_M : in STD_LOGIC;
    M_IBUF : in STD_LOGIC
  );
end Control_unit;

architecture STRUCTURE of Control_unit is
begin
reg_M_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => reg_M,
      D => M_IBUF,
      Q => m_out,
      R => RST_IBUF
    );
reg_data_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => CLEARED_BTN,
      D => i_IBUF,
      Q => i_out,
      R => RST_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity RICONOSCITORE_DI_SEQ is
  port (
    state_OBUF : out STD_LOGIC_VECTOR ( 3 downto 0 );
    LED_OBUF : out STD_LOGIC;
    RST_IBUF : in STD_LOGIC;
    m_out : in STD_LOGIC;
    i_out : in STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC;
    lopt : out STD_LOGIC
  );
end RICONOSCITORE_DI_SEQ;

architecture STRUCTURE of RICONOSCITORE_DI_SEQ is
  signal \FSM_onehot_stato_corrente[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[4]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[5]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[6]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[7]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[8]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente[8]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg[8]_lopt_replica_1\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[1]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[2]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[4]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[5]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[6]\ : STD_LOGIC;
  signal \FSM_onehot_stato_corrente_reg_n_0_[7]\ : STD_LOGIC;
  signal \^state_obuf\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_stato_corrente[3]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \FSM_onehot_stato_corrente[5]_i_1\ : label is "soft_lutpair2";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[0]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[1]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[2]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[3]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[4]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[5]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[6]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[7]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[8]\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_stato_corrente_reg[8]_lopt_replica\ : label is "s4:000010000,s3:000001000,s2:000000100,s1:000000010,s0:000000001,s7:010000000,s6:001000000,s8:100000000,s5:000100000";
  attribute OPT_INSERTED_REPDRIVER : boolean;
  attribute OPT_INSERTED_REPDRIVER of \FSM_onehot_stato_corrente_reg[8]_lopt_replica\ : label is std.standard.true;
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \FSM_onehot_stato_corrente_reg[8]_lopt_replica\ : label is "SWEEP";
begin
  lopt <= \FSM_onehot_stato_corrente_reg[8]_lopt_replica_1\;
  state_OBUF(3 downto 0) <= \^state_obuf\(3 downto 0);
\FSM_onehot_stato_corrente[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF4"
    )
        port map (
      I0 => m_out,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[0]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[5]\,
      I3 => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      O => \FSM_onehot_stato_corrente[1]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[1]\,
      I1 => i_out,
      O => \FSM_onehot_stato_corrente[2]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[2]\,
      I1 => i_out,
      O => \FSM_onehot_stato_corrente[3]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[1]\,
      I1 => i_out,
      O => \FSM_onehot_stato_corrente[4]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => i_out,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[2]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[4]\,
      O => \FSM_onehot_stato_corrente[5]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFFEAEA"
    )
        port map (
      I0 => \^state_obuf\(3),
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[0]\,
      I2 => m_out,
      I3 => i_out,
      I4 => \FSM_onehot_stato_corrente_reg_n_0_[6]\,
      O => \FSM_onehot_stato_corrente[6]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[6]\,
      I2 => i_out,
      O => \FSM_onehot_stato_corrente[7]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FE00"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[5]\,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[0]\,
      I3 => RST_IBUF,
      I4 => m_out,
      O => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      I1 => i_out,
      O => \FSM_onehot_stato_corrente[8]_i_2_n_0\
    );
\FSM_onehot_stato_corrente_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => '0',
      Q => \FSM_onehot_stato_corrente_reg_n_0_[0]\,
      S => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[1]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[1]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[2]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[2]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[3]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[4]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[4]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[5]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[5]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[6]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[6]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[7]_i_1_n_0\,
      Q => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[8]_i_2_n_0\,
      Q => \^state_obuf\(3),
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
\FSM_onehot_stato_corrente_reg[8]_lopt_replica\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \FSM_onehot_stato_corrente[8]_i_2_n_0\,
      Q => \FSM_onehot_stato_corrente_reg[8]_lopt_replica_1\,
      R => \FSM_onehot_stato_corrente[8]_i_1_n_0\
    );
LED_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => i_out,
      I1 => \^state_obuf\(3),
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      O => LED_OBUF
    );
\state_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[5]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      I3 => \FSM_onehot_stato_corrente_reg_n_0_[1]\,
      O => \^state_obuf\(0)
    );
\state_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[6]\,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[3]\,
      I3 => \FSM_onehot_stato_corrente_reg_n_0_[2]\,
      O => \^state_obuf\(1)
    );
\state_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \FSM_onehot_stato_corrente_reg_n_0_[6]\,
      I1 => \FSM_onehot_stato_corrente_reg_n_0_[7]\,
      I2 => \FSM_onehot_stato_corrente_reg_n_0_[5]\,
      I3 => \FSM_onehot_stato_corrente_reg_n_0_[4]\,
      O => \^state_obuf\(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Riconoscitore_onBoard is
  port (
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    i : in STD_LOGIC;
    i_read : in STD_LOGIC;
    M : in STD_LOGIC;
    m_read : in STD_LOGIC;
    LED : out STD_LOGIC;
    state : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Riconoscitore_onBoard : entity is true;
  attribute \DesignAttr:ENABLE_AIE_NETLIST_VIEW\ : boolean;
  attribute \DesignAttr:ENABLE_AIE_NETLIST_VIEW\ of Riconoscitore_onBoard : entity is std.standard.true;
  attribute \DesignAttr:ENABLE_NOC_NETLIST_VIEW\ : boolean;
  attribute \DesignAttr:ENABLE_NOC_NETLIST_VIEW\ of Riconoscitore_onBoard : entity is std.standard.true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of Riconoscitore_onBoard : entity is "2f79ba9e";
end Riconoscitore_onBoard;

architecture STRUCTURE of Riconoscitore_onBoard is
  signal CLEARED_BTN : STD_LOGIC;
  signal CLK_IBUF : STD_LOGIC;
  signal CLK_IBUF_BUFG : STD_LOGIC;
  signal LED_OBUF : STD_LOGIC;
  signal M_IBUF : STD_LOGIC;
  signal RST_IBUF : STD_LOGIC;
  signal i_IBUF : STD_LOGIC;
  signal i_out : STD_LOGIC;
  signal i_read_IBUF : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal m_out : STD_LOGIC;
  signal m_read_IBUF : STD_LOGIC;
  signal reg_M : STD_LOGIC;
  signal state_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_ric_state_OBUF_UNCONNECTED : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \state_OBUF[3]_inst\ : label is "SWEEP";
begin
CLK_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => CLK_IBUF,
      O => CLK_IBUF_BUFG
    );
CLK_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => CLK,
      O => CLK_IBUF
    );
CU: entity work.Control_unit
     port map (
      CLEARED_BTN => CLEARED_BTN,
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      M_IBUF => M_IBUF,
      RST_IBUF => RST_IBUF,
      i_IBUF => i_IBUF,
      i_out => i_out,
      m_out => m_out,
      reg_M => reg_M
    );
LED_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF,
      O => LED
    );
M_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => M,
      O => M_IBUF
    );
RST_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => RST,
      O => RST_IBUF
    );
deb_i: entity work.ButtonDebouncer
     port map (
      CLEARED_BTN => CLEARED_BTN,
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      RST_IBUF => RST_IBUF,
      i_read_IBUF => i_read_IBUF
    );
deb_m: entity work.ButtonDebouncer_0
     port map (
      CLEARED_BTN => CLEARED_BTN,
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      RST_IBUF => RST_IBUF,
      m_read_IBUF => m_read_IBUF,
      reg_M => reg_M
    );
i_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => i,
      O => i_IBUF
    );
i_read_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => i_read,
      O => i_read_IBUF
    );
m_read_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => m_read,
      O => m_read_IBUF
    );
ric: entity work.RICONOSCITORE_DI_SEQ
     port map (
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      LED_OBUF => LED_OBUF,
      RST_IBUF => RST_IBUF,
      i_out => i_out,
      lopt => lopt,
      m_out => m_out,
      state_OBUF(3) => NLW_ric_state_OBUF_UNCONNECTED(3),
      state_OBUF(2 downto 0) => state_OBUF(2 downto 0)
    );
\state_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => state_OBUF(0),
      O => state(0)
    );
\state_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => state_OBUF(1),
      O => state(1)
    );
\state_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => state_OBUF(2),
      O => state(2)
    );
\state_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => lopt,
      O => state(3)
    );
end STRUCTURE;
