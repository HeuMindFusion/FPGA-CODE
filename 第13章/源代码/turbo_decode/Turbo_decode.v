`timescale 1ns / 1ps


module Turbo_decode(
    input clk,
	 input rst,
	 input[15:0] x_1,
	 input[15:0] x_2,
	 input[15:0] x_3,
	 input[15:0] x_4,
	 input[15:0] y1_1,
	 input[15:0] y1_2,
	 input[15:0] y1_3,
	 input[15:0] y1_4,
	 input[15:0] y2_1,
	 input[15:0] y2_2,
	 input[15:0] y2_3,
	 input[15:0] y2_4,
	 output[30:0] soft11,
	 output[30:0] soft12,
	 output[30:0] soft13,
	 output[30:0] soft14,
	 output[3:0] d,
	 output[29:0] how_1,
	 output[29:0] how_2,
	 output[29:0] how_3,
	 output[29:0] how_4
    );
wire[30:0] soft1;
wire[30:0] soft2;
wire[30:0] soft3;
wire[30:0] soft4;
wire[29:0] z21;
wire[29:0] z22;
wire[29:0] z23;
wire[29:0] z24;
wire[29:0] z11;
wire[29:0] z12;
wire[29:0] z13;
wire[29:0] z14;
wire[29:0] w11;
wire[29:0] w12;
wire[29:0] w13;
wire[29:0] w14;
wire[29:0] w21;
wire[29:0] w22;
wire[29:0] w23;
wire[29:0] w24;
wire[15:0] xi1;
wire[15:0] xi2;
wire[15:0] xi3;
wire[15:0] xi4;
	 
dec1       d1(.clk(clk),              //分量译码器D1
              .rst(rst),
				  //.z2_en(z2_en),
		        .x_1(x_1),
		        .x_2(x_2),
		        .x_3(x_3),
		        .x_4(x_4),
			     .y1_1(y1_1),
			     .y1_2(y1_2),
			     .y1_3(y1_3),
			     .y1_4(y1_4),
			     .z2_1(z21),
			     .z2_2(z22),
			     .z2_3(z23),
			     .z2_4(z24),
			     .w1_1(w11),
			     .w1_2(w12),
			     .w1_3(w13),
			     .w1_4(w14),
				  .softout11(soft11),
			     .softout12(soft12),
			     .softout13(soft13),
			     .softout14(soft14)
			     );
			
dec2       d2(.clk(clk),              //分量译码器D2
              .rst(rst),
			     .z1_1(z11),
			     .z1_2(z12),
			     .z1_3(z13),
			     .z1_4(z14),
			     .y2_1(y2_1),
			     .y2_2(y2_2),
			     .y2_3(y2_3),
			     .y2_4(y2_4),
			     .x_i1(xi1),
			     .x_i2(xi2),
			     .x_i3(xi3),
			     .x_i4(xi4),
			     .w2_1(w21),
			     .w2_2(w22),
			     .w2_3(w23),
			     .w2_4(w24),
			     .softout1(soft1),
			     .softout2(soft2),
			     .softout3(soft3),
			     .softout4(soft4)
			     );
			
inter1     i1(.clk(clk),               //交织器1
              .rst(rst),
				  .w1_1(w11),
				  .w1_2(w12),
				  .w1_3(w13),
				  .w1_4(w14),
				  .z1_1(z11),
				  .z1_2(z12),
				  .z1_3(z13),
				  .z1_4(z14)
				  );

inter2     i2(.clk(clk),               //交织器2
              .rst(rst),
				  .x_1(x_1),
				  .x_2(x_2),
				  .x_3(x_3),
				  .x_4(x_4),
				  .x_i1(xi1),
				  .x_i2(xi2),
				  .x_i3(xi3),
				  .x_i4(xi4)
				  );
				  
inter_d1  t1(.clk(clk),                //解交织器1
             .rst(rst),
				 .w2_1(w21),
				 .w2_2(w22),
				 .w2_3(w23),
				 .w2_4(w24),
				 .z2_1(z21),
				 .z2_2(z22),
				 .z2_3(z23),
				 .z2_4(z24)
				 );
				 
inter_d2  t2(.clk(clk),                //解交织器2，带硬判决
             .rst(rst),
				 .soft_in1(soft1),
				 .soft_in2(soft2),
				 .soft_in3(soft3),
				 .soft_in4(soft4),
				 .how_1(how_1),
				 .how_2(how_2),
				 .how_3(how_3),
				 .how_4(how_4),
				 .d(d)
				 );

endmodule
