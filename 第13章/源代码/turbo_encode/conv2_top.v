`timescale 1ns / 1ps


module conv2_top(
   input clk,
	input[3:0] m3,
	input rst,
	output[3:0] c_2,
	output co
    );
wire x1;
wire y1;
wire en;

b2c2   b2(.clk(clk),
          .rst(rst),
			 .b2c_in(m3),
			 .b2c_out(x1),
			 .b2c_en(en)
			 );
			 
conv2  conv2(.clk(clk),
             .conv2_en(en),
				 .x(x1),
				 .conv_out(y1)
				 );
				 
c2b2  c2(.clk(clk),
         .c2b_en(rst),
			.c2b_in(y1),
			.c2b_out(c_2),
			.c2b_over(co)
			);

endmodule
