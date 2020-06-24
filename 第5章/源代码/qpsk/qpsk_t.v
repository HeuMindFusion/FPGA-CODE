`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:42:55 07/29/2012
// Design Name:   QPSK
// Module Name:   E:/xilinx project/qpsk_j/qpsk_t.v
// Project Name:  qpsk_j
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: QPSK
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:S
// 
////////////////////////////////////////////////////////////////////////////////

module qpsk_t;

	// Inputs
	reg clk;
	reg rst;
	reg x;

	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	QPSK uut (
		.clk(clk), 
		.rst(rst), 
		.x(x), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		x = 0;

		// Wait 100 ns for global reset to finish
		#10;
      rst = 1;
      x = 1;
      #50;
      x = 0;
      #35;
      x = 1;
      #55;
      x = 0;
      #75;
      x = 1;		
		// Add stimulus here

	end
      
	always #5 clk =~ clk;
	
endmodule

