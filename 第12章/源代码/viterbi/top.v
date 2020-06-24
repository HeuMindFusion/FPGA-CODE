`timescale 1ns / 1ps


module top(
   input clk,
	input clk_div2,
	input rst,
	input x,
	output y,
	output c,
	output rd,           //指示有效输入的起始
	output ready         //指示有效输出的起始
    );
	 
wire[13:0] a;
wire[6:0] c_out;
wire[13:0] x_m;

v_con  con(.clk(clk),
           .rst(rst),
			  .x(x),
			  .x_out(x_m),
			  .a_o(a),
			  .c_o(c_out),
			  .y(y),
			  .c(c),
			  .rd(rd),
			  .ready(ready)
			  );

v_cal  cal(.clk_div2(clk_div2),
           .rst(rst),
			  .x_t(x_m),
			  .a_o(a),
			  .c_o(c_out)
			  );

endmodule
