`timescale 1ns / 1ps


module mux_13(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_12,
	 output[7:0] r_13
    );
wire[7:0] a_13;
reg[7:0] g_13;
reg[7:0] r13;

assign a_13 = mr;

 always @(posedge clk)                            //g13和m+r的值相乘
  begin
  if(!rst)
   begin
	g_13<=0;
	r13<=0;
	end
  else
   begin
    g_13[0]<=a_13[0]^a_13[2]^a_13[3]^a_13[6];	
	 g_13[1]<=a_13[0]^a_13[1]^a_13[3]^a_13[4];	
	 g_13[2]<=a_13[0]^a_13[1]^a_13[3]^a_13[4]^a_13[5]^a_13[6]^a_13[7];	
    g_13[3]<=a_13[1]^a_13[3]^a_13[4]^a_13[5]^a_13[6]^a_13[7];	
    g_13[4]<=a_13[3]^a_13[4]^a_13[5]^a_13[6];	
	 g_13[5]<=a_13[0]^a_13[4]^a_13[5]^a_13[6]^a_13[7];	
	 g_13[6]<=a_13[0]^a_13[1]^a_13[5]^a_13[6]^a_13[7];	
	 g_13[7]<=a_13[1]^a_13[2]^a_13[6]^a_13[7];
	 r13<=r_12^g_13;
	end
 end
 
 assign 	 r_13=r13;

endmodule
