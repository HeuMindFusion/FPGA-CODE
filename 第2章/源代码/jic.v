module jic(
    input clk,
	 input en,
	 input [3:0] d,
	 output reg [3:0] q
	 );
	 always @(posedge clk or posedge en)
	   begin
		 if(en)
		  q<=0;
		 else
		  q<=d;
		end
endmodule
