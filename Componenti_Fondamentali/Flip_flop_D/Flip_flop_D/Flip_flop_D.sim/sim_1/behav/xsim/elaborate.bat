@echo off
REM ****************************************************************************
REM Vivado (TM) v2023.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Mon Jan 27 22:53:00 +0100 2025
REM SW Build 3865809 on Sun May  7 15:05:29 MDT 2023
REM
REM IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot FF_D_tb_behav xil_defaultlib.FF_D_tb -log elaborate.log"
call xelab  --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot FF_D_tb_behav xil_defaultlib.FF_D_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0