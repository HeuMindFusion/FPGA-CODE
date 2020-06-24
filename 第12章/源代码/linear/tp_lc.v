`timescale 1ns / 1ps




module tp_lc;

	// Inputs
	reg reset;
	reg [3:0] u;

	// Outputs
	wire [6:0] c;

	// Instantiate the Unit Under Test (UUT)
	linearcoder uut (
		.reset(reset), 
		.u(u), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		u = 0;

		// Wait 100 ns for global reset to finish
		// Add stimulus here
	end
   always #10 u<=u+7;
endmodule

