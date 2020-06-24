`timescale 1ns / 1ps


module control_turbo(
    input clk,
	 input rst,
	 input[3:0] m1,
	 input[3:0] m2,
	 input d_over,
	 input d_start,
	 input f,                      //可以写入交织器了，高有效
	 input[3:0] delete_in,         //删余器输入到复接器
	 output[3:0] m2_o,             //m2输出码字
	 output[3:0] out                 //输出码字
    );
reg[3:0] m2_middle[15:0];        //第二路信息序列中间存储器
reg[3:0] m1_middle[15:0];
reg[3:0] d_middle[15:0];
reg[3:0] cnt_w;
reg[3:0] cnt_r;
reg[4:0] cnt_m1;
reg[3:0] cnt_din;
reg[3:0] m2_out;
reg clk_2;

assign m2_o = m2_out;              //m2串行输出 
assign out = (d_over==1) ? ( clk_2 ? m1_middle[cnt_m1] : d_middle[cnt_m1]) : 0;  //复接器
             
always @(posedge clk)              //模块总控制
begin
 if(!rst)
  begin
   cnt_r<=0;
	cnt_w<=0;
	cnt_m1<=0;
	cnt_din<=0;
	m2_out<=0;
	clk_2<=0;
  end
 else
  begin                          //第一、二路信息序列RSC1的时间要和RSC2一样，同步
  clk_2<=!clk_2;
  if(!f)                        //写入交织器时，同时把m1,m2写入m2_middle
    begin
     if(cnt_w<15)                //先写入
	   begin
	    m2_middle[cnt_w]<=m2;
	    m1_middle[cnt_w]<=m1;
	    cnt_w<=cnt_w+1;
		end
	  else
	   begin
	    cnt_w<=15;
	   end
    end
  else                          //f==1是开始   
	begin
     if(cnt_r<15)
      begin
	    m2_out<=m2_middle[cnt_r];
	    cnt_r<=cnt_r+1;
      end
     else
      begin
	    cnt_r<=15;
	   end
	if(d_start&&(!d_over))                 //复接器删余输入部分寄存
	 begin
	  if(cnt_din<15)
	   begin
		 d_middle[cnt_din]<=delete_in;
		 cnt_din<=cnt_din+1;
		end
	  else
	   begin
		 cnt_din<=15;
		end
	 end
	else
	 if(d_over)
	  if(cnt_m1<31)
	   if(clk_2)               //复接器计数
	     begin
	      cnt_m1<=cnt_m1+1;
	     end
	   else
	    begin
	     cnt_m1<=cnt_m1;
	    end
	  else
	   cnt_m1<=31;
	 else
	  cnt_m1<=0;
    end
  end
end

endmodule
