`timescale 1ns / 1ps

module counter(
    input [12:0] irc_addr,
	 input load,
	 input clock,
	 input rst,
	 output reg [12:0] pcc_addr
    );

   always @(posedge clock or posedge rst)
	    begin
		   if(rst)
			   pcc_addr<=13'b0000000000000;
			else
			 if(load)
			   pcc_addr<=irc_addr;
			else
			   pcc_addr<=pcc_addr+1;
		 end	 

endmodule
