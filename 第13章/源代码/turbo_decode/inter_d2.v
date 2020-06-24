`timescale 1ns / 1ps


module inter_d2(
    input clk,
	 input rst,
	 input[30:0] soft_in1,
	 input[30:0] soft_in2,
	 input[30:0] soft_in3,
	 input[30:0] soft_in4,
	 output[29:0] how_1,
	 output[29:0] how_2,
	 output[29:0] how_3,
	 output[29:0] how_4,
	 output[3:0] d
    );
reg[30:0] s1_m;
reg[30:0] s2_m;
reg[30:0] s3_m;
reg[30:0] s4_m;
reg[29:0] how1;
reg[29:0] how2;
reg[29:0] how3;
reg[29:0] how4;
reg[3:0] d_m;

assign d = d_m;
assign how_1 = how1;
assign how_2 = how2;
assign how_3 = how3;
assign how_4 = how4;

always @(posedge clk)
 begin
  if(!rst)
   begin
	 s1_m<=0;
	 s2_m<=0;
	 s3_m<=0;
	 s4_m<=0;
	end
  else
   begin
	 s1_m<=soft_in1;
	 s2_m<=soft_in3;
	 s3_m<=soft_in2;
	 s4_m<=soft_in4;
	end
end

always @(posedge clk)
begin
 if(!rst)
  begin
   d_m<=0;
  end
 else
  begin
   if(s1_m[30]==0)          //软判决信息判决位，0为正即1，1为负即0
	 begin
	  d_m[0]<=1;
	  how1<=s1_m[29:0];      //可信度
	 end
	else
	 begin
	  d_m[0]<=0;
	  how1<=s1_m[29:0];
	 end
	 if(s2_m[30]==0)
	  begin
	   d_m[1]<=1;
		how2<=s2_m[29:0];
	  end
	 else
	  begin
	   d_m[1]<=0;
		how2<=s2_m[29:0];
	  end
	 if(s3_m[30]==0)
	  begin
	   d_m[2]<=1;
		how3<=s3_m[29:0];
	  end
	 else
	  begin
	   d_m[2]<=0;
		how3<=s3_m[29:0];
	  end
	 if(s4_m[30]==0)
	  begin
	   d_m[3]<=1;
		how4<=s4_m[29:0];
	  end
	 else
	  begin
	   d_m[3]<=0;
		how4<=s4_m[29:0];
	  end
  end
end

endmodule
