`timescale 1ns / 1ps

module CRC(
    input clk,
	 input rst,
	 input[15:0] d,                     //输入数据
	 output[15:0] crc_out               //输出CRC
	 );
wire[15:0] r_t;
	 
mod     m(.clk(clk),
          .rst(rst),
			 .r(r_t),
		    .crc_m(crc_out)
			 );
			
control  c(.clk(clk),
           .rst(rst),
			  .d(d),
			  .crc_c(crc_out),
			  .r(r_t)
			  );
	 
	 
endmodule
