`timescale 1ns / 1ps

module control(
    input clk,
	 input rst,
	 input[7:0] m,
	 input[7:0] r_15,                      //寄存器
	 output [7:0] mr,                    //控制模块输出的m和r15的异或值，输入到系数乘法器
	 output [7:0] c
    );
 
reg[7:0] cnt;
	 
always @(posedge clk)                      //整个除法器的计数控制
 begin
  if(!rst)
	begin
	 cnt<=0;
   end
  else
   begin
	 if(cnt<8'd240)                        //之前都在输出输入信息数据，之后输出校验数据
	  begin
	   cnt<=cnt+1;
	  end
	 else
	  begin
      cnt<=cnt;	  
	  end
	end
 end
 
 assign c = (cnt==8'd240) ? r_15 : m;    //输出校验或是输入码字
 
 assign mr = (!rst) ? m : (cnt==240)? 0 : m^r_15;  //mr异或值的输出
 
endmodule
