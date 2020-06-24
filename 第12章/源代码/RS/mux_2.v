`timescale 1ns / 1ps


module mux_2(
    input clk,
	 input rst,
	 input[7:0] r_1,
	 input[7:0] mr,
	 output[7:0] r_2
    );
	 
 wire[7:0] a_2;
 reg[7:0] g_2; 
 reg[7:0] r2;

 assign a_2 = mr; 
 
 always @(posedge clk)                            //g2和m+r的值相乘
  begin
  if(!rst)
   begin
	g_2<=0;
	r2<=0;
	end
  else
	begin
    g_2[0]<=a_2[0]^a_2[2]^a_2[4]^a_2[6]^a_2[7];	
	 g_2[1]<=a_2[1]^a_2[3]^a_2[5]^a_2[7];	
	 g_2[2]<=a_2[7];	
    g_2[3]<=a_2[2]^a_2[4]^a_2[6]^a_2[7];	
    g_2[4]<=a_2[0]^a_2[2]^a_2[3]^a_2[4]^a_2[5]^a_2[6];	
	 g_2[5]<=a_2[1]^a_2[3]^a_2[4]^a_2[5]^a_2[6]^a_2[7];	
	 g_2[6]<=a_2[0]^a_2[2]^a_2[4]^a_2[5]^a_2[6]^a_2[7];	
	 g_2[7]<=a_2[1]^a_2[3]^a_2[5]^a_2[6]^a_2[7];
	 r2 <= r_1^g_2;
	end
 end

 assign r_2 = r2;
 
endmodule
