`timescale 1ns / 1ps


module mux_0(
    input clk,
	 input rst,
	 input[7:0] mr,
	 output[7:0] r_0
    );	 
 wire[7:0] a_0;
 reg[7:0] g_0; 
 reg[7:0] r0;
 
 assign a_0 = mr; 
 
 always @(posedge clk)
  begin
  if(!rst)
   begin
	g_0<=0;
	r0<=0;
	end
  else
   begin
    g_0[0]<=a_0[0]^a_0[2]^a_0[5];	
	 g_0[1]<=a_0[0]^a_0[1]^a_0[3]^a_0[6];	
	 g_0[2]<=a_0[0]^a_0[1]^a_0[4]^a_0[5]^a_0[7];	
    g_0[3]<=a_0[0]^a_0[1]^a_0[6];	
    g_0[4]<=a_0[1]^a_0[5]^a_0[7];	
	 g_0[5]<=a_0[2]^a_0[6];	
	 g_0[6]<=a_0[0]^a_0[3]^a_0[7];	
	 g_0[7]<=a_0[1]^a_0[4];
	 r0<= g_0;
	end
 end

 assign r_0 = r0;

endmodule
