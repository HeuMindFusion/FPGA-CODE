`timescale 1ns / 1ps


module mux_12(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_11,
	 output[7:0] r_12
    );
wire[7:0] a_12;
reg[7:0] g_12;
reg[7:0] r12;

assign a_12 = mr;

 always @(posedge clk)                            //g12ºÍm+rÄÖµÏà³?  
 begin
  if(!rst)
   begin
	g_12<=0;
	r12<=0;
	end
  else
   begin
    g_12[0]<=a_12[0]^a_12[4]^a_12[5]^a_12[6]^a_12[7];	
	 g_12[1]<=a_12[0]^a_12[1]^a_12[5]^a_12[6]^a_12[7];	
	 g_12[2]<=a_12[0]^a_12[1]^a_12[2]^a_12[4]^a_12[5];	
    g_12[3]<=a_12[0]^a_12[1]^a_12[2]^a_12[3]^a_12[4]^a_12[6]^a_12[7];	
    g_12[4]<=a_12[0]^a_12[1]^a_12[2]^a_12[3]^a_12[6]^a_12[7];	
	 g_12[5]<=a_12[1]^a_12[2]^a_12[3]^a_12[4]^a_12[7];	
	 g_12[6]<=a_12[2]^a_12[3]^a_12[4]^a_12[5];	
	 g_12[7]<=a_12[3]^a_12[4]^a_12[5]^a_12[6];
	 r12<=r_11^g_12;
	end
 end

assign 	 r_12=r12;

endmodule
