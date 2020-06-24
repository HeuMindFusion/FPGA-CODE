`timescale 1ns / 1ps


module QPSK(
      input clk, 
		input rst,
      input x,
      output y               //QPSK��������ź�
		);                
 
reg [2:0] cnt;    
reg [1:0] x_middle;          //x���м�Ĵ���
reg [3:0] carriers;          //4·�ز��ź�
reg [1:0] y_middle;

always @(posedge clk)        // ģ��ʱ�ӷ�Ƶ������
begin   
  if(!rst)
     cnt<=0;
  else
     cnt<=cnt+1;
end

always @(posedge clk)        //�Ĵ�����
begin
  if(!rst)
     x_middle<=0;
  else
   begin
      if(cnt[1:0]==2'b11)
         x_middle<={x_middle[0],x};  //����
		else
		   x_middle <= x_middle;       //����
	end
end

always @(posedge clk)              // �����ز��ź�
begin
  if(!rst)
   begin
     carriers<=4'b0000;
	  y_middle<=0;
	end
  else 
   begin
     case(cnt) 
			3'b000:begin
			        y_middle<=x_middle;
					  carriers<=4'b1100;	       				
			       end
			3'b010: carriers<=4'b1001;							
			3'b100: carriers<=4'b0011;	
			3'b110: carriers<=4'b0110;
	     default: carriers<=carriers;
	  endcase
   end
end

assign y = (y_middle == 2'b00) ? carriers[3] :
           (y_middle == 2'b01) ? carriers[2] :
			  (y_middle == 2'b10) ? carriers[1] :
			  (y_middle == 2'b11) ? carriers[0] : 0;

endmodule
