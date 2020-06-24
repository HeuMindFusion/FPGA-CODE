`timescale 1ns / 1ps


module inter2(
    input clk,
	 input rst,
	 input[15:0] x_1,
	 input[15:0] x_2,
	 input[15:0] x_3,
	 input[15:0] x_4,
    output[15:0] x_i1,
    output[15:0] x_i2,
    output[15:0] x_i3,
    output[15:0] x_i4
    );
reg[15:0] x1;
reg[15:0] x2;
reg[15:0] x3;
reg[15:0] x4;

assign x_i1 = x1;
assign x_i2 = x2;
assign x_i3 = x3;
assign x_i4 = x4;

always @(posedge clk)
begin
 if(!rst)
  begin
   x1<=0;
	x2<=0;
	x3<=0;
	x4<=0;
  end
 else
  begin
   x1<=x_1;
	x2<=x_3;
	x3<=x_2;
	x4<=x_4;
  end
end
endmodule
