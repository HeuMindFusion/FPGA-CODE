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
     input rst,            //��ʼд
     input[3:0] m3,
     output[3:0] y,
	  output f                 //��ʼ��
     );
reg [4:0] addra; 
reg [3:0] addrb;               //RAM�Ŀ��Ƶ�ַ
reg [1:0] cnt;                 //12��һת�е�ͷλ�ÿ�ʼ��
reg [1:0] addr0;               //�ж�ȡ�ĳ�ʼλ��
reg r_en;                        //�ɶ�������Ч

assign f = r_en;                 //��ʼ��

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
	  if(addra<15)		      //д��x
		begin
		 addra<=addra + 1;
		end
     else
		 begin
	     addra <=16;
        r_en<=1;                //д�꣬��ʼ��
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
