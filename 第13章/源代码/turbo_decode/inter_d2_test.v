`timescale 1ns / 1ps


module inter_d2_test;

	// Inputs
	reg clk;
	reg rst;
	reg [30:0] soft_in1;
	reg [30:0] soft_in2;
	reg [30:0] soft_in3;
	reg [30:0] soft_in4;

	// Outputs
	wire [29:0] how_1;
	wire [29:0] how_2;
	wire [29:0] how_3;
	wire [29:0] how_4;
	wire [3:0] d;

	// Instantiate the Unit Under Test (UUT)
	inter_d2 uut (
		.clk(clk), 
		.rst(rst), 
		.soft_in1(soft_in1), 
		.soft_in2(soft_in2), 
		.soft_in3(soft_in3), 
		.soft_in4(soft_in4), 
		.how_1(how_1), 
		.how_2(how_2), 
		.how_3(how_3), 
		.how_4(how_4), 
		.d(d)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		soft_in1 = 1073784324;
		soft_in2 = 60000;
		soft_in3 = 60000;
		soft_in4 = 1073821824;

		// Wait 100 ns for global reset to finish
		#20;
      rst = 1;
		// Add stimulus here

	end
always #5 clk =~ clk;
      
endmodule

