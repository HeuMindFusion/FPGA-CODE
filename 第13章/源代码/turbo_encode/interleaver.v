`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:32 08/12/2007 
// Design Name: 
// Module Name:    interleaver 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module interleaver(
     input clk,
     input rst,            //开始写
     input[3:0] m3,
     output[3:0] y,
	  output f                 //开始读
     );
reg [4:0] addra; 
reg [3:0] addrb;               //RAM的控制地址
reg [1:0] cnt;                 //12个一转列的头位置开始读
reg [1:0] addr0;               //列读取的初始位置
reg r_en;                        //可读，高有效

assign f = r_en;                 //开始读

always @(posedge clk) 
begin
	if(!rst) 
	 begin
		addra <= 0;
		addrb<=0;
	   addr0<=1;
	   cnt<=0;
		r_en<=0;
	 end
	else 
	 begin
	  if(addra<15)		      //写入x
		begin
		 addra<=addra + 1;
		end
     else
		 begin
	     addra <=16;
        r_en<=1;                //写完，则开始读
		  if(addrb<15)
         begin
          if(cnt<3)
           begin
	         cnt<=cnt+1;
	         addrb<=addr0;
	         addrb<=addrb+4;
           end
          else
           begin
	         addr0<=addr0+1;
	         addrb<=addr0;
	         cnt<=0;
           end
	      end
        else
         begin
      	 addrb<=15;
	      end
       end			
	 end
end
	
block_ram block_ram(
	.addra(addra),
	.addrb(addrb),
	.clka(clk),
	.clkb(clk),
	.dina(m3),
	.doutb(y),
	.wea(rst)
	);
	
endmodule
