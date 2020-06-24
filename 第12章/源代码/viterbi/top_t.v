`timescale 1ns / 1ps




module top_t;

	// Inputs
	reg clk;
	reg clk_div2;
	reg rst;
	reg x;

	// Outputs
	wire y;
	wire c;
	wire rd;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.clk_div2(clk_div2), 
		.rst(rst), 
		.x(x), 
		.y(y), 
		.c(c), 
		.rd(rd), 
		.ready(ready)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_div2 = 0;
		rst = 0;
		x = 0;

		// Wait 100 ns for global reset to finish
		#30;
		rst = 1;
		x=1;
		#10;
		x=1;
		#10;
		x=1;
		#10;
		x=0;
		#10;
		x=1;
		#10;
		x=1;
		#10;
		x=1;
		#10;
		x=1;
		#10;
		x=0;
		#10;
		x=1;
		#10;
		x=0;
		#10;
		x=1;
		#10;
		x=1;
		#10;
		x=1;
		
		// Add stimulus here

	end
	
	always #5 clk =~ clk;
	always #10 clk_div2 =~ clk_div2;
      
endmodule

