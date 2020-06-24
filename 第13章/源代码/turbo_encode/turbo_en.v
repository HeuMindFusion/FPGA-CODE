`timescale 1ns / 1ps


module turbo_en(
   input clk,
	input rst,
	input[3:0] m,
	output[3:0] out
    );
wire[3:0] y1;
wire f1;
wire d_o;
wire coo;
wire[3:0] x;
wire[3:0] c1;
wire[3:0] c2;
wire[3:0] d;

interleaver  i1(.clk(clk),
                .rst(rst),
					 .m3(m),
					 .y(y1),
					 .f(f1)
					 );

conv1_top    co1(.clk(clk),
                 .rst(f1),
					  .m2(x),
					  .c_1(c1)
					  );

conv2_top    co2(.clk(clk),
                 .rst(f1),
					  .m3(y1),
					  .c_2(c2),
					  .co(coo)
					  );
					  
delete        t1(.clk(clk),
                 .delete_start(coo),
					  .delete_in1(c1),
					  .delete_in2(c2),
					  .delete_out(d),
					  .delete_over(d_o)
					  );
					  
control_turbo  ct(.clk(clk),
                  .rst(rst),
						.m1(m),
						.m2(m),
						.f(f1),
						.d_over(d_o),
						.d_start(coo),
						.delete_in(d),
						.m2_o(x),
						.out(out)
						);
						
endmodule
