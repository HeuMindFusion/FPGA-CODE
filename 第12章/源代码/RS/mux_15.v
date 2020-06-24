`timescale 1ns / 1ps


module mux_15(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_14,
	 output[7:0] r_15
    );
wire[7:0] a_15;
reg[7:0] g_15;
//reg[7:0] r15;

assign a_15 = mr;

 always @(posedge clk)                            //g15和m+r的值相乘
  begin
  if(!rst)
   begin
	g_15<=0;
	//r15<=0;
	end
  else
   begin
    g_15[0]<=a_15[2]^a_15[3]^a_15[4]^a_15[7];	
	 g_15[1]<=a_15[0]^a_15[3]^a_15[4]^a_15[5];	
	 g_15[2]<=a_15[0]^a_15[1]^a_15[2]^a_15[3]^a_15[5]^a_15[6]^a_15[7];	
    g_15[3]<=a_15[1]^a_15[6];	
    g_15[4]<=a_15[0]^a_15[3]^a_15[4];	
	 g_15[5]<=a_15[0]^a_15[1]^a_15[4]^a_15[5];	
	 g_15[6]<=a_15[0]^a_15[1]^a_15[2]^a_15[5]^a_15[6];	
	 g_15[7]<=a_15[1]^a_15[2]^a_15[3]^a_15[6]^a_15[7];
	 //r15<=r_14^g_15;
	end
 end

assign 	 r_15=r_14^g_15;

endmodule
