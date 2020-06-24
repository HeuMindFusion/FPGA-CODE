`timescale 1ns / 1ps


module mux_14(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_13,
	 output[7:0] r_14
    );
wire[7:0] a_14;
reg[7:0] g_14;
reg[7:0] r14;

assign a_14 = mr;

 always @(posedge clk)                            //g14和m+r的值相乘
  begin
  if(!rst)
   begin
	g_14<=0;
	r14<=0;
	end
  else
   begin
    g_14[0]<=a_14[3]^a_14[4]^a_14[6]^a_14[7];	
	 g_14[1]<=a_14[4]^a_14[5]^a_14[7];	
	 g_14[2]<=a_14[0]^a_14[3]^a_14[4]^a_14[5]^a_14[7];	
    g_14[3]<=a_14[1]^a_14[3]^a_14[5]^a_14[7];	
    g_14[4]<=a_14[0]^a_14[2]^a_14[3]^a_14[7];	
	 g_14[5]<=a_14[0]^a_14[3]^a_14[4];	
	 g_14[6]<=a_14[1]^a_14[2]^a_14[4]^a_14[5];	
	 g_14[7]<=a_14[2]^a_14[3]^a_14[5]^a_14[6];
	 r14<=r_13^g_14;
	end
 end

assign 	 r_14=r14;

endmodule
