`timescale 1ns / 1ps




module conv_t;

	// Inputs
	reg clk;
	reg reset;
	reg x;

	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	conv uut (
		.clk(clk), 
		.reset(reset), 
		.x(x), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		//x = 0;

		// Wait 100 ns for global reset to finish
		#10;
		reset = 1;
		x = 1;
		#20;
		x = 0;
		#20;
		x = 0;
		#20;
		x = 1;
		#20;
		x = 1;
		#20;
		x = 0;
		#20;
		x = 0;
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

