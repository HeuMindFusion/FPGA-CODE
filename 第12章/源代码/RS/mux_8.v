`timescale 1ns / 1ps

module mux_8(
    input clk,
	 input rst,
	 input[7:0] mr,
	 input[7:0] r_7,
	 output[7:0] r_8
    );
wire[7:0] a_8;
reg[7:0] g_8;
reg[7:0] r8;

assign a_8 = mr;

 always @(posedge clk)                            //g8和m+r的值相乘
  begin
  if(!rst)
   begin
	g_8<=0;
	r8<=0;
	end
  else
   begin
    g_8[0]<=a_8[1]^a_8[2]^a_8[3]^a_8[6]^a_8[7];	
	 g_8[1]<=a_8[2]^a_8[3]^a_8[4];	
	 g_8[2]<=a_8[1]^a_8[2]^a_8[4]^a_8[5]^a_8[7];	
    g_8[3]<=a_8[0]^a_8[1]^a_8[5]^a_8[6]^a_8[7];	
    g_8[4]<=a_8[3]^a_8[6];	
	 g_8[5]<=a_8[0]^a_8[4]^a_8[7];	
	 g_8[6]<=a_8[0]^a_8[1]^a_8[5];	
	 g_8[7]<=a_8[0]^a_8[1]^a_8[2]^a_8[6];
	 r8 <= r_7^g_8;                                 //
	end
 end

assign 	 r_8 = r8;

endmodule
