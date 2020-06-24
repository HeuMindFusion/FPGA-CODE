`timescale 1ns / 1ps

module control(
    input clk,
	 input rst,
	 input[7:0] m,
	 input[7:0] r_15,                      //�Ĵ���
	 output [7:0] mr,                    //����ģ�������m��r15�����ֵ�����뵽ϵ���˷���
	 output [7:0] c
    );
 
reg[7:0] cnt;
	 
always @(posedge clk)                      //�����������ļ�������
 begin
  if(!rst)
	begin
	 cnt<=0;
   end
  else
   begin
	 if(cnt<8'd240)                        //֮ǰ�������������Ϣ���ݣ�֮�����У������
	  begin
	   cnt<=cnt+1;
	  end
	 else
	  begin
      cnt<=cnt;	  
	  end
	end
 end
 
 assign c = (cnt==8'd240) ? r_15 : m;    //���У�������������
 
 assign mr = (!rst) ? m : (cnt==240)? 0 : m^r_15;  //mr���ֵ�����
 
endmodule
