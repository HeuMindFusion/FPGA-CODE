`timescale 1ns / 1ps


module conv1_top(
   input clk,
	input[3:0] m2,
	input rst,
	output[3:0] c_1
    );
wire x1;
wire y1;
wire en;

b2c1   b1(.clk(clk),
          .rst(rst),
			 .b2c_in(m2),
			 .b2c_out(x1),
			 .b2c_en(en)
			 );
			 
conv1  conv1(.clk(clk),
             .conv1_en(en),
				 .x(x1),
				 .conv_out(y1)
				 );
				 
c2b1  c1(.clk(clk),
         .c2b_en(rst),
			.c2b_in(y1),
			.c2b_out(c_1)
			);

endmodule
