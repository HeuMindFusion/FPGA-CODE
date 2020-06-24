`timescale 1ns / 1ps




module turbo_t;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] m;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	turbo_en uut (
		.clk(clk), 
		.rst(rst), 
		.m(m), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		m = 0;

		// Wait 100 ns for global reset to finish
		#50;
      rst = 1;
		// Add stimulus here

	end
	
	always #5 clk =~ clk;
	
	always @(posedge clk)
	 begin
	  if(!rst)
	   begin
		 m<=0;
		end
	  else
	   begin
		if(m<15)
		 m<=m+1;
		else
		 m<=15;
		end
	end
      
endmodule

