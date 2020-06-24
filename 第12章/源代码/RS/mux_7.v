`timescale 1ns / 1ps


module mux_7(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_6,
	 output[7:0] r_7
    );
wire[7:0] a_7;
reg[7:0] g_7;
reg[7:0] r7;

assign a_7 = mr;

 always @(posedge clk)                            //g7和m+r的值相乘
  begin
  if(!rst)
   begin
	g_7<=0;
	r7<=0;
	end
  else
   begin
    g_7[0]<=a_7[0]^a_7[4];	
	 g_7[1]<=a_7[1]^a_7[5];	
	 g_7[2]<=a_7[2]^a_7[4]^a_7[6];	
    g_7[3]<=a_7[3]^a_7[4]^a_7[5]^a_7[7];	
    g_7[4]<=a_7[0]^a_7[5]^a_7[6];	
	 g_7[5]<=a_7[1]^a_7[6]^a_7[7];	
	 g_7[6]<=a_7[2]^a_7[7];	
	 g_7[7]<=a_7[3];
	 r7 <= r_6^g_7;
	end
 end

assign 	 r_7 = r7;

endmodule
