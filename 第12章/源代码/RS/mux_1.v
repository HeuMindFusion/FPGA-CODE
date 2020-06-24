`timescale 1ns / 1ps

module mux_1(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_0,
	 output[7:0] r_1
    );
 wire[7:0] a_1;
 reg[7:0] g_1;
 reg[7:0] r1;

 assign a_1 = mr;  

 always @(posedge clk)
  begin
  if(!rst)
   begin
	g_1<=0;
	r1<=0;
   end
  else
   begin
    g_1[0]<=a_1[3]^a_1[5]^a_1[6]^a_1[7];	
	 g_1[1]<=a_1[4]^a_1[6]^a_1[7];	
	 g_1[2]<=a_1[0]^a_1[3]^a_1[6];	
    g_1[3]<=a_1[0]^a_1[1]^a_1[3]^a_1[4]^a_1[5]^a_1[6];	
    g_1[4]<=a_1[1]^a_1[2]^a_1[3]^a_1[4];	
	 g_1[5]<=a_1[0]^a_1[2]^a_1[3]^a_1[4]^a_1[5];	
	 g_1[6]<=a_1[1]^a_1[3]^a_1[4]^a_1[5]^a_1[6];	
	 g_1[7]<=a_1[2]^a_1[4]^a_1[5]^a_1[6]^a_1[7];
	 r1<=r_0^g_1;
	end
 end
 
 assign r_1=r1;

endmodule
