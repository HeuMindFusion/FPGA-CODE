`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:29:54 07/29/2012
// Design Name:   top
// Module Name:   E:/xilinx project/qpsk_j/top_t.v
// Project Name:  qpsk_j
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_t;

	// Inputs
	reg clk;
	reg rst;
	reg x;

	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	top uut (
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
		#50;
      rst = 1;
		x=1;
		#50;
		x=0;
		#50;
		x=1;
		#50;
		x=0;
		#50;
		x=1;
		#50;
		x=0;
	end
	always #5 clk =~ clk;
      
endmodule

