`timescale 1ns / 1ps


module inter1(
    input clk,
	 input rst,
	 input[29:0] w1_1,
	 input[29:0] w1_2,
	 input[29:0] w1_3,
	 input[29:0] w1_4,
    output[29:0] z1_1,
    output[29:0] z1_2,
    output[29:0] z1_3,
    output[29:0] z1_4	 
    );
reg[29:0] z1;
reg[29:0] z2;
reg[29:0] z3;
reg[29:0] z4;

assign z1_1 = z1;
assign z1_2 = z2;
assign z1_3 = z3;
assign z1_4 = z4;

always @(posedge clk)
begin
 if(!rst)
  begin
   z1<=0;
	z2<=0;
	z3<=0;
	z4<=0;
  end
 else
  begin
   z1<=w1_1;
	z2<=w1_3;
	z3<=w1_2;
	z4<=w1_4;
  end
end
	
endmodule
