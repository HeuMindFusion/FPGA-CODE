`timescale 1ns / 1ps


module accuml(
    input [7:0] ac_data,
	 input a_ena,
	 input clk1,
	 input rst,
	 output reg [7:0] accum_out
    );
	 
	 
	 always @(posedge clk1)
	   begin
		 if(rst)
		   accum_out<=8'b00000000;
		 else
		   if(a_ena)
			 accum_out<=ac_data;
		end
endmodule
