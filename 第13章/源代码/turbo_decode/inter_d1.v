`timescale 1ns / 1ps


module inter_d1(
   input clk,
	input rst,
	input[29:0] w2_1,
	input[29:0] w2_2,
	input[29:0] w2_3,
	input[29:0] w2_4,
	output[29:0] z2_1,
	output[29:0] z2_2,
	output[29:0] z2_3,
	output[29:0] z2_4
    );
reg[29:0] w1;
reg[29:0] w2;
reg[29:0] w3;
reg[29:0] w4;

assign z2_1 = w1;
assign z2_2 = w2;
assign z2_3 = w3;
assign z2_4 = w4;

always @(posedge clk)
begin
 if(!rst)
  begin
   w1<=0;
	w2<=0;
	w3<=0;
	w4<=0;
  end
 else
  begin 
   w1<=w2_1;
	w2<=w2_3;
	w3<=w2_2;
	w4<=w2_4;
  end
end

endmodule
