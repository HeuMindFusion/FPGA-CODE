`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:28:55 04/25/2012
// Design Name:   dds
// Module Name:   E:/xilinx project/DDS/t_DDS.v
// Project Name:  DDS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dds
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_DDS;

	// Inputs
	reg [31:0] data;
	reg we;
	reg clk;
	reg ce;
	reg reset;

	// Outputs
	wire [15:0] sine;
	wire [15:0] cose;

	// Instantiate the Unit Under Test (UUT)
	dds uut (
		.data(data), 
		.we(we), 
		.clk(clk), 
		.ce(ce), 
		.reset(reset), 
		.sine(sine), 
		.cose(cose));

	initial begin
		// Initialize Inputs
		data = 32'Hf9987412;
		we = 0;
		clk = 0;
		ce = 0;
		reset = 1;
		#2;
		reset = 0;
		we = 1;
    ce = 1;
		// Add stimulus here

	end
	
	always #10 clk =~ clk;
endmodule

