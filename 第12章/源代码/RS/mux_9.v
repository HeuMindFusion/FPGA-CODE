`timescale 1ns / 1ps


module mux_9(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_8,
	 output[7:0] r_9
    );
wire[7:0] a_9;
reg[7:0] g_9;
reg[7:0] r9;

assign a_9 = mr;

 always @(posedge clk)                            //g9和m+r的值相乘
  begin
  if(!rst)
   begin
	g_9<=0;
	r9<=0;
	end
  else
   begin
    g_9[0]<=a_9[0]^a_9[1]^a_9[3]^a_9[4]^a_9[6]^a_9[7];	
	 g_9[1]<=a_9[0]^a_9[1]^a_9[2]^a_9[4]^a_9[5];	
	 g_9[2]<=a_9[2]^a_9[4]^a_9[5]^a_9[7];	
    g_9[3]<=a_9[0]^a_9[1]^a_9[4]^a_9[5]^a_9[7];	
    g_9[4]<=a_9[0]^a_9[3]^a_9[4]^a_9[5]^a_9[7];	
	 g_9[5]<=a_9[0]^a_9[1]^a_9[3]^a_9[4]^a_9[5]^a_9[6];	
	 g_9[6]<=a_9[1]^a_9[2]^a_9[4]^a_9[5]^a_9[7];	
	 g_9[7]<=a_9[0]^a_9[2]^a_9[3]^a_9[5]^a_9[6]^a_9[7];
	 r9 <= r_8^g_9;
	end
 end
 
assign 	 r_9 = r9;

endmodule
