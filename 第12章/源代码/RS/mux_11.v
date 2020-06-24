`timescale 1ns / 1ps


module mux_11(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_10,
	 output[7:0] r_11
    );
wire[7:0] a_11;
reg[7:0] g_11;
reg[7:0] r11;

assign a_11 = mr;

 always @(posedge clk)                            //g11和m+r的值相乘
  begin
  if(!rst)
   begin
	g_11<=0;
	r11<=0;
	end
  else
   begin
    g_11[0]<=a_11[2]^a_11[3]^a_11[5]^a_11[6];	
	 g_11[1]<=a_11[3]^a_11[4]^a_11[6]^a_11[7];	
	 g_11[2]<=a_11[2]^a_11[3]^a_11[4]^a_11[6]^a_11[7];	
    g_11[3]<=a_11[0]^a_11[2]^a_11[4]^a_11[6]^a_11[7];	
    g_11[4]<=a_11[1]^a_11[2]^a_11[6]^a_11[7];	
	 g_11[5]<=a_11[0]^a_11[2]^a_11[3]^a_11[7];	
	 g_11[6]<=a_11[0]^a_11[1]^a_11[3]^a_11[4];	
	 g_11[7]<=a_11[1]^a_11[2]^a_11[4]^a_11[5];
	 r11<=r_10^g_11;
	end
 end
 
assign 	 r_11=r11;

endmodule
