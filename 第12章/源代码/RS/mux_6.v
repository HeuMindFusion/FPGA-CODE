`timescale 1ns / 1ps


module mux_6(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_5,
	 output[7:0] r_6
    );
wire[7:0] a_6;
reg[7:0] g_6;
reg[7:0] r6;

assign a_6 = mr;

 always @(posedge clk)                            //g6和m+r的值相乘
  begin
  if(!rst)
   begin
	g_6<=0;
	r6<=0;
	end
  else
   begin
    g_6[0]<=a_6[3]^a_6[4]^a_6[5]^a_6[7];	
	 g_6[1]<=a_6[4]^a_6[5]^a_6[6];	
	 g_6[2]<=a_6[3]^a_6[4]^a_6[6];	
    g_6[3]<=a_6[0]^a_6[3];	
    g_6[4]<=a_6[0]^a_6[1]^a_6[3]^a_6[5]^a_6[7];	
	 g_6[5]<=a_6[0]^a_6[2]^a_6[4]^a_6[6];	
	 g_6[6]<=a_6[1]^a_6[3]^a_6[5];	
	 g_6[7]<=a_6[2]^a_6[3]^a_6[4]^a_6[6];
	 r6 <= r_5^g_6;
	end
 end

assign 	 r_6 = r6;

endmodule
