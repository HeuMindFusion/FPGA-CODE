`timescale 1ns / 1ps

module qpsk_decode(
       input clk, 
       input rst,
       input x, 
       output y         //QPSK解调输出信号
               );
reg [7:0] temp;         // 先记录下8个时钟周期的信号，然后供下一次判决
reg [7:0] temp2;
reg [2:0] cnt;           //0-7
wire [1:0] y1;

always @(posedge clk) 
begin
   if (!rst)
	 begin
	    cnt <= 0;
		 temp<=0;
		 temp2<=0;
	 end
	else 
	 begin
	    temp2 <= {temp2[6:0], x};	
	    cnt <= cnt +1;
		 if (cnt<7)
		    temp <= temp2;
		 else
		    temp <= temp;
    end
end

assign y1 = (rst == 0) ? 2'b00 : 
           (temp == 8'b11110000) ? 2'b00 :
           (temp == 8'b11000011)	? 2'b01 :
           (temp == 8'b00001111)	? 2'b10 :	
           (temp == 8'b00111100)	? 2'b11 : 2'b00;		

assign y = (cnt[2] == 0) ? y1[1] : y1[0];			  

endmodule
