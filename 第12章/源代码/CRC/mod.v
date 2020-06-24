`timescale 1ns / 1ps


module mod(
    input clk,
	 input rst,
	 input[15:0] r,
	 output[15:0] crc_m
    );
	 reg[15:0] crc_tmp;
	 
	always @(posedge clk)
	 begin
	  if(!rst)
	   begin
	   crc_tmp<=0;
	   end
	  else
	   begin
	    crc_tmp[0] <= r[12]^r[11]^r[8]^r[4]^r[0];
	    crc_tmp[1] <= r[13]^r[12]^r[9]^r[5]^r[1];
	    crc_tmp[2] <= r[14]^r[13]^r[10]^r[6]^r[2];
	    crc_tmp[3] <= r[15]^r[14]^r[11]^r[7]^r[3];
	    crc_tmp[4] <= r[15]^r[12]^r[8]^r[4];
	    crc_tmp[5] <= r[13]^r[12]^r[11]^r[9]^r[8]^r[5]^r[4]^r[0];
	    crc_tmp[6] <= r[14]^r[13]^r[12]^r[10]^r[9]^r[6]^r[5]^r[1];
	    crc_tmp[7] <= r[15]^r[14]^r[13]^r[11]^r[10]^r[7]^r[6]^r[2];
	    crc_tmp[8] <= r[15]^r[14]^r[12]^r[11]^r[8]^r[7]^r[3];
	    crc_tmp[9] <= r[15]^r[13]^r[12]^r[9]^r[8]^r[4];
	    crc_tmp[10] <= r[14]^r[13]^r[10]^r[9]^r[5];
	    crc_tmp[11] <= r[15]^r[14]^r[11]^r[10]^r[6];
	    crc_tmp[12] <= r[15]^r[8]^r[7]^r[4]^r[0];
	    crc_tmp[13] <= r[9]^r[8]^r[5]^r[1];
	    crc_tmp[14] <= r[10]^r[9]^r[6]^r[2];
	    crc_tmp[15] <= r[11]^r[10]^r[7]^r[3];
      end
	end
		
	assign crc_m = crc_tmp;

endmodule
