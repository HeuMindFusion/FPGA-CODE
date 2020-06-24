`timescale 1ns / 1ps


module mux_4(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_3,
	 output[7:0] r_4
    );
wire[7:0] a_4;
reg[7:0] g_4;
reg[7:0] r4;

assign a_4 = mr;

 always @(posedge clk)
  begin
  if(!rst)
   begin
	g_4<=0;
	r4<=0;
	end
  else
   begin
    g_4[0]<=a_4[0]^a_4[3]^a_4[4]^a_4[7];	
	 g_4[1]<=a_4[1]^a_4[4]^a_4[5];	
	 g_4[2]<=a_4[2]^a_4[3]^a_4[4]^a_4[5]^a_4[6]^a_4[7];	
    g_4[3]<=a_4[5]^a_4[6];	
    g_4[4]<=a_4[0]^a_4[3]^a_4[4]^a_4[6];	
	 g_4[5]<=a_4[0]^a_4[1]^a_4[4]^a_4[5]^a_4[7];	
	 g_4[6]<=a_4[1]^a_4[2]^a_4[5]^a_4[6];	
	 g_4[7]<=a_4[2]^a_4[3]^a_4[6]^a_4[7];
	 r4 <= r_3^g_4;
	end
 end

assign 	 r_4 = r4;

endmodule
