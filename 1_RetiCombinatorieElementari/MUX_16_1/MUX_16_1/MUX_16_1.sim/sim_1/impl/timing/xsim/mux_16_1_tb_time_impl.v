// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Mon Nov 18 18:25:01 2024
// Host        : MadamImAdam running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/ladyc/Desktop/ASDI/VIVADO-PROJECTS/MUX_16_1/MUX_16_1.sim/sim_1/impl/timing/xsim/mux_16_1_tb_time_impl.v
// Design      : mux_16_1
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xa7a15tcpg236-2I
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "4c264de5" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module mux_16_1
   (C,
    S,
    Y);
  input [15:0]C;
  input [3:0]S;
  output Y;

  wire [15:0]C;
  wire [15:0]C_IBUF;
  wire [3:0]S;
  wire [3:0]S_IBUF;
  wire Y;
  wire Y_OBUF;
  wire Y_OBUF_inst_i_2_n_0;
  wire Y_OBUF_inst_i_3_n_0;
  wire Y_OBUF_inst_i_4_n_0;
  wire Y_OBUF_inst_i_5_n_0;
  wire Y_OBUF_inst_i_6_n_0;
  wire Y_OBUF_inst_i_7_n_0;

initial begin
 $sdf_annotate("mux_16_1_tb_time_impl.sdf",,,,"tool_control");
end
  IBUF \C_IBUF[0]_inst 
       (.I(C[0]),
        .O(C_IBUF[0]));
  IBUF \C_IBUF[10]_inst 
       (.I(C[10]),
        .O(C_IBUF[10]));
  IBUF \C_IBUF[11]_inst 
       (.I(C[11]),
        .O(C_IBUF[11]));
  IBUF \C_IBUF[12]_inst 
       (.I(C[12]),
        .O(C_IBUF[12]));
  IBUF \C_IBUF[13]_inst 
       (.I(C[13]),
        .O(C_IBUF[13]));
  IBUF \C_IBUF[14]_inst 
       (.I(C[14]),
        .O(C_IBUF[14]));
  IBUF \C_IBUF[15]_inst 
       (.I(C[15]),
        .O(C_IBUF[15]));
  IBUF \C_IBUF[1]_inst 
       (.I(C[1]),
        .O(C_IBUF[1]));
  IBUF \C_IBUF[2]_inst 
       (.I(C[2]),
        .O(C_IBUF[2]));
  IBUF \C_IBUF[3]_inst 
       (.I(C[3]),
        .O(C_IBUF[3]));
  IBUF \C_IBUF[4]_inst 
       (.I(C[4]),
        .O(C_IBUF[4]));
  IBUF \C_IBUF[5]_inst 
       (.I(C[5]),
        .O(C_IBUF[5]));
  IBUF \C_IBUF[6]_inst 
       (.I(C[6]),
        .O(C_IBUF[6]));
  IBUF \C_IBUF[7]_inst 
       (.I(C[7]),
        .O(C_IBUF[7]));
  IBUF \C_IBUF[8]_inst 
       (.I(C[8]),
        .O(C_IBUF[8]));
  IBUF \C_IBUF[9]_inst 
       (.I(C[9]),
        .O(C_IBUF[9]));
  IBUF \S_IBUF[0]_inst 
       (.I(S[0]),
        .O(S_IBUF[0]));
  IBUF \S_IBUF[1]_inst 
       (.I(S[1]),
        .O(S_IBUF[1]));
  IBUF \S_IBUF[2]_inst 
       (.I(S[2]),
        .O(S_IBUF[2]));
  IBUF \S_IBUF[3]_inst 
       (.I(S[3]),
        .O(S_IBUF[3]));
  OBUF Y_OBUF_inst
       (.I(Y_OBUF),
        .O(Y));
  MUXF8 Y_OBUF_inst_i_1
       (.I0(Y_OBUF_inst_i_2_n_0),
        .I1(Y_OBUF_inst_i_3_n_0),
        .O(Y_OBUF),
        .S(S_IBUF[3]));
  MUXF7 Y_OBUF_inst_i_2
       (.I0(Y_OBUF_inst_i_4_n_0),
        .I1(Y_OBUF_inst_i_5_n_0),
        .O(Y_OBUF_inst_i_2_n_0),
        .S(S_IBUF[2]));
  MUXF7 Y_OBUF_inst_i_3
       (.I0(Y_OBUF_inst_i_6_n_0),
        .I1(Y_OBUF_inst_i_7_n_0),
        .O(Y_OBUF_inst_i_3_n_0),
        .S(S_IBUF[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Y_OBUF_inst_i_4
       (.I0(C_IBUF[3]),
        .I1(C_IBUF[2]),
        .I2(S_IBUF[1]),
        .I3(C_IBUF[1]),
        .I4(S_IBUF[0]),
        .I5(C_IBUF[0]),
        .O(Y_OBUF_inst_i_4_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Y_OBUF_inst_i_5
       (.I0(C_IBUF[7]),
        .I1(C_IBUF[6]),
        .I2(S_IBUF[1]),
        .I3(C_IBUF[5]),
        .I4(S_IBUF[0]),
        .I5(C_IBUF[4]),
        .O(Y_OBUF_inst_i_5_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Y_OBUF_inst_i_6
       (.I0(C_IBUF[11]),
        .I1(C_IBUF[10]),
        .I2(S_IBUF[1]),
        .I3(C_IBUF[9]),
        .I4(S_IBUF[0]),
        .I5(C_IBUF[8]),
        .O(Y_OBUF_inst_i_6_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Y_OBUF_inst_i_7
       (.I0(C_IBUF[15]),
        .I1(C_IBUF[14]),
        .I2(S_IBUF[1]),
        .I3(C_IBUF[13]),
        .I4(S_IBUF[0]),
        .I5(C_IBUF[12]),
        .O(Y_OBUF_inst_i_7_n_0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
