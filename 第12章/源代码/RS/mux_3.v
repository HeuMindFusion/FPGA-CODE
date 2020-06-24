`timescale 1ns / 1ps


module mux_3(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_2,
	 output[7:0] r_3
    );
	 
wire[7:0] a_3;
reg[7:0] g_3;
reg[7:0] r3;

assign a_3 = mr;

 always @(posedge clk)                            //g3和m+r的值相乘
  begin
  if(!rst)
   begin
	g_3<=0;
	r3<=0;
	end
  else
   begin
    g_3[0]<=a_3[2]^a_3[3];	
	 g_3[1]<=a_3[3]^a_3[4];	
	 g_3[2]<=a_3[0]^a_3[2]^a_3[3]^a_3[4]^a_3[5];	
    g_3[3]<=a_3[1]^a_3[2]^a_3[4]^a_3[5]^a_3[6];	
    g_3[4]<=a_3[5]^a_3[6]^a_3[7];	
	 g_3[5]<=a_3[0]^a_3[6]^a_3[7];	
	 g_3[6]<=a_3[0]^a_3[1]^a_3[7];	
	 g_3[7]<=a_3[1]^a_3[2];
	 r3 <= r_2^g_3;
	end
 end

assign 	 r_3 = r3;

endmodule
