`timescale 1ns / 1ps

module control(
    input clk,
	 input rst,
	 //input z2_en,
	 input[29:0] z21,
	 input[29:0] z22,
	 input[29:0] z23,
	 input[29:0] z24,
	 input[15:0] x1,
	 input[15:0] x2,
	 input[15:0] x3,
	 input[15:0] x4,
	 input[15:0] y1_1,
	 input[15:0] y1_2,
	 input[15:0] y1_3,
	 input[15:0] y1_4,
	 input[29:0] soft_out1,
	 input[29:0] soft_out2,
	 input[29:0] soft_out3,
	 input[29:0] soft_out4,
	 input[29:0] v_1,
	 input[29:0] v_2,
	 input[29:0] v_3,
	 input[29:0] v_4,
	 input[29:0] v_5,
	 input[29:0] v_6,
	 input[29:0] v_7,
	 input[29:0] v_8,
	 input[29:0] v_9,
	 input[29:0] v_10,
	 input[29:0] v_11,
	 input[29:0] v_12,
	 input[29:0] v_13,
	 input[29:0] v_14,
	 output[29:0] w1_1,
	 output[29:0] w1_2,
	 output[29:0] w1_3,
	 output[29:0] w1_4,
	 output[29:0] v1_n,
	 output[29:0] v2_n,
	 output[29:0] v3_n,
	 output[29:0] v4_n,
	 output[29:0] v5_n,
	 output[29:0] v6_n,
	 output[29:0] v7_n,
	 output[29:0] v8_n,
	 output[29:0] v9_n,
	 output[29:0] v10_n,
	 output[29:0] v11_n,
	 output[29:0] v12_n,
	 output[29:0] v13_n,
	 output[29:0] v14_n,
	 output[15:0] m1_1,
	 output[15:0] m2_1,
	 output[15:0] m3_1,
	 output[15:0] m4_1,
	 output[15:0] m1_2,
	 output[15:0] m2_2,
	 output[15:0] m3_2,
	 output[15:0] m4_2
    );
//------------------初始化
reg[2:0] cnt_it;
reg[29:0] w11;                  //外信息寄存器
reg[29:0] w12;
reg[29:0] w13;
reg[29:0] w14;
reg[29:0] v1_new;               //更新的欧式距离寄存器
reg[29:0] v2_new;
reg[29:0] v3_new;
reg[29:0] v4_new;
reg[29:0] v5_new;
reg[29:0] v6_new;
reg[29:0] v7_new;
reg[29:0] v8_new;
reg[29:0] v9_new;
reg[29:0] v10_new;
reg[29:0] v11_new;
reg[29:0] v12_new;
reg[29:0] v13_new;
reg[29:0] v14_new;
reg[15:0] m11;
reg[15:0] m21;                 //欧氏距离计算公式的输入序列
reg[15:0] m31;
reg[15:0] m41;
reg[15:0] m12;
reg[15:0] m22;
reg[15:0] m32;
reg[15:0] m42;
reg[1:0] cnt_m;

//-----------------迭代控制
always @(posedge clk)
begin
 if(!rst)
  begin
   cnt_it<=0;                   //迭代计数器
  end
 else
  begin
   if(x1&&x2&&x3&&x4==0)                     //全为零，说明输入x后迭代开始
	 begin
	  cnt_it<=cnt_it+1;
	 end
	else
	 begin
	  cnt_it<=cnt_it;
	 end
  end
end
//----------------控制输出外信息
always @(posedge clk)
begin
 if(!rst)
  begin
   w11<=0;
   w12<=0;
   w13<=0;
   w14<=0;
  end
 else
  begin
   w11<=soft_out1[29:0]-4*x1-z21;
   w12<=soft_out2[29:0]-4*x2-z22;
   w13<=soft_out3[29:0]-4*x3-z23;
   w14<=soft_out4[29:0]-4*x4-z24;
  end
end
assign w1_1 = w11;
assign w1_2 = w12;
assign w1_3 = w13;
assign w1_4 = w14;
//---------------先验信息z2来更新欧氏距离,更新完后输入到幸存路径计算模块
always @(posedge clk)
begin
 if(!rst)
  begin
   v1_new<=0;
   v2_new<=0;
   v3_new<=0;
   v4_new<=0;
   v5_new<=0;
   v6_new<=0;
   v7_new<=0;
   v8_new<=0;
   v9_new<=0;
   v10_new<=0;
   v11_new<=0;
   v12_new<=0;
   v13_new<=0;
   v14_new<=0;
  end
 else
  begin
  if(cnt_it==0)
   begin
   v1_new<=v_1;
   v2_new<=v_2;
   v3_new<=v_3;
   v4_new<=v_4;
   v5_new<=v_5;
   v6_new<=v_6;
   v7_new<=v_7;
   v8_new<=v_8;
   v9_new<=v_9;
   v10_new<=v_10;
   v11_new<=v_11;
   v12_new<=v_12;
   v13_new<=v_13;
   v14_new<=v_14;
	end
  else
   begin 
	 v1_new<=v_1-z21;
    v2_new<=v_2-z21;
    v3_new<=v_3-z22;
    v4_new<=v_4-z22;
    v5_new<=v_5-z22;
    v6_new<=v_6-z22;
    v7_new<=v_7-z23;
    v8_new<=v_8-z23;
    v9_new<=v_9-z23;
    v10_new<=v_10-z23;
    v11_new<=v_11-z24;
    v12_new<=v_12-z24;
    v13_new<=v_13-z24;
    v14_new<=v_14-z24;
	end
 end
end
assign v1_n = v1_new;
assign v2_n = v2_new;
assign v3_n = v3_new;
assign v4_n = v4_new;
assign v5_n = v5_new;
assign v6_n = v6_new;
assign v7_n = v7_new;
assign v8_n = v8_new;
assign v9_n = v9_new;
assign v10_n = v10_new;
assign v11_n = v11_new;
assign v12_n = v12_new;
assign v13_n = v13_new;
assign v14_n = v14_new;
//------------输入系统码元和校验码元
always @(posedge clk)
begin
 if(!rst)
  begin
   m11<=0;
   m21<=0;
   m31<=0;
   m41<=0;
   m12<=0;
   m22<=0;
   m32<=0;
   m42<=0;
	cnt_m<=0;
  end
 else
  begin
	case(cnt_m)
	 0: begin
	     m11<=y1_1;
	     m21<=y1_2;
	     m31<=y1_3;
	     m41<=y1_4;
		  cnt_m<=cnt_m+1;
		 end
	 1: begin
	     m12<=y1_1;
	     m22<=y1_2;
	     m32<=y1_3;
	     m42<=y1_4;
		  cnt_m<=cnt_m+1;
		 end
	  default : begin
	     m11<=m11;
	     m21<=m21;
	     m31<=m31;
	     m41<=m41;
	     m12<=m12;
	     m22<=m22;
	     m32<=m32;
	     m42<=m42;
		         end
	endcase
  end
end
assign m1_1 = m11;
assign m2_1 = m21;
assign m3_1 = m31;
assign m4_1 = m41;
assign m1_2 = m12;
assign m2_2 = m22;
assign m3_2 = m32;
assign m4_2 = m42;
	  
endmodule
