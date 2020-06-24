`timescale 1ns / 1ps

module RS_top(
   input clk,
	input rst,                                    //重置，低有效
	input[7:0] m,                                 //输入数据
	output [7:0] c                                //输出码字
    );
wire[7:0] mr_t;
wire[7:0] r_t;
	 
control  con(.clk(clk),
             .rst(rst),
				 .mr(mr_t),
				 .m(m),
				 .r_15(r_t),
				 .c(c)
				 );
				 
mux      mux(.clk(clk),
             .rst(rst),
				 .mr_m(mr_t),
				 .r_15(r_t)
             );


endmodule
