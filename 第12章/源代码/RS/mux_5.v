`timescale 1ns / 1ps


module mux_5(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_4,
	 output[7:0] r_5
    );
wire[7:0] a_5;
reg[7:0] g_5;
reg[7:0] r5;

assign a_5 = mr;

 always @(posedge clk)                            //g5和m+r的值相乘
  begin
  if(!rst)
   begin
	g_5<=0;
	r5<=0;
	end
  else
   begin
    g_5[0]<=a_5[0]^a_5[1]^a_5[3]^a_5[4]^a_5[7];	
	 g_5[1]<=a_5[0]^a_5[1]^a_5[2]^a_5[4]^a_5[5]^a_5[6];	
	 g_5[2]<=a_5[0]^a_5[2]^a_5[4]^a_5[6];	
    g_5[3]<=a_5[4];	
    g_5[4]<=a_5[0]^a_5[1]^a_5[3]^a_5[4]^a_5[7];	
	 g_5[5]<=a_5[0]^a_5[1]^a_5[2]^a_5[4]^a_5[5];	
	 g_5[6]<=a_5[1]^a_5[2]^a_5[3]^a_5[5]^a_5[6];	
	 g_5[7]<=a_5[0]^a_5[2]^a_5[3]^a_5[4]^a_5[6]^a_5[7];
	 r5 <= r_4^g_5;
	end
 end

assign 	 r_5 = r5;

endmodule
