`timescale 1ns / 1ps


module machinectl(
    input fetch,
	 input rst,
	 input clk,
	 output reg ena
    );
	 
	 always @(posedge clk)
	   begin
		  if(rst)
		    ena<=0;
		  else
          if(fetch)
           ena<=1;
      end
endmodule
