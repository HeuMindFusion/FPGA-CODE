`timescale 1ns / 1ps


module mux(
    input clk,
	 input rst,
	 input[7:0] mr_m,
	 output[7:0] r_15
    );
wire[7:0] r_01;
wire[7:0] r_12;
wire[7:0] r_23;
wire[7:0] r_34;
wire[7:0] r_45;
wire[7:0] r_56;
wire[7:0] r_67;
wire[7:0] r_78;
wire[7:0] r_89;
wire[7:0] r_910;
wire[7:0] r_1011;
wire[7:0] r_1112;
wire[7:0] r_1213;
wire[7:0] r_1314;
wire[7:0] r_1415;

	 
mux_0   m0(.clk(clk),
           .rst(rst),
			  .mr(mr_m),
			  .r_0(r_01)
            );
				
mux_1   m1(.clk(clk),
           .rst(rst),
			  .mr(mr_m),
			  .r_0(r_01),
			  .r_1(r_12)
            );
				
mux_2   m2(.clk(clk),              //g2和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_1(r_12),
			  .r_2(r_23)
            );
				
mux_3   m3(.clk(clk),              //g3和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_2(r_23),
			  .r_3(r_34)
            );
				
mux_4   m4(.clk(clk),              //g4和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_3(r_34),
			  .r_4(r_45)
            );
				
mux_5   m5(.clk(clk),              //g5和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_4(r_45),
			  .r_5(r_56)
            );
				
mux_6   m6(.clk(clk),              //g6和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_5(r_56),
			  .r_6(r_67)
            );
				
mux_7   m7(.clk(clk),              //g7和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_6(r_67),
			  .r_7(r_78)
            );
				
mux_8   m8(.clk(clk),              //g8和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_7(r_78),
			  .r_8(r_89)
            );
				
mux_9   m9(.clk(clk),              //g9和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_8(r_89),
			  .r_9(r_910)
            );

mux_10   m10(.clk(clk),              //g10和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_9(r_910),
			  .r_10(r_1011)
            );
				
mux_11   m11(.clk(clk),              //g11和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_10(r_1011),
			  .r_11(r_1112)
            );
				
mux_12   m12(.clk(clk),              //g12和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_11(r_1112),
			  .r_12(r_1213)
            );
				
mux_13   m13(.clk(clk),              //g13和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_12(r_1213),
			  .r_13(r_1314)
            );
				
mux_14   m14(.clk(clk),              //g14和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_13(r_1314),
			  .r_14(r_1415)
            );
				
mux_15   m15(.clk(clk),              //g15和m+r的值相乘
           .rst(rst),
			  .mr(mr_m),
			  .r_14(r_1415),
			  .r_15(r_15)
            );

endmodule
