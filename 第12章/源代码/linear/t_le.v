`timescale 1ns / 1ps




module t_le;

	// Inputs
	reg reset;
	reg [6:0] y;

	// Outputs
	wire [6:0] x;

	// Instantiate the Unit Under Test (UUT)
	linearencoder uut (
		.reset(reset), 
		.y(y), 
		.x(x)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always #10 y<=y+22;
      
endmodule

