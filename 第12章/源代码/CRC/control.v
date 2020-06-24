`timescale 1ns / 1ps

module control(
   input clk,
	input rst,
	input[15:0] d,
	input[15:0] crc_c,       //上一个CRC16的值，用来更新下一个CRC16的值
	output[15:0] r           //中间寄存器
    );
	 reg[15:0] r_c;
    
	 always @(posedge clk)
	 begin
	  if(!rst)
	   begin
		 r_c<=0;
		end
	  else
	   begin
		 r_c[0]<=d[0]^crc_c[0];
		 r_c[1]<=d[1]^crc_c[1];
		 r_c[2]<=d[2]^crc_c[2];
		 r_c[3]<=d[3]^crc_c[3];
		 r_c[4]<=d[4]^crc_c[4];
		 r_c[5]<=d[5]^crc_c[5];
		 r_c[6]<=d[6]^crc_c[6];
		 r_c[7]<=d[7]^crc_c[7];
		 r_c[8]<=d[8]^crc_c[8];
		 r_c[9]<=d[9]^crc_c[9];
		 r_c[10]<=d[10]^crc_c[10];
		 r_c[11]<=d[11]^crc_c[11];
		 r_c[12]<=d[12]^crc_c[12];
		 r_c[13]<=d[13]^crc_c[13];
		 r_c[14]<=d[14]^crc_c[14];
		 r_c[15]<=d[15]^crc_c[15];
		end
	 end
	assign r = r_c;
endmodule
