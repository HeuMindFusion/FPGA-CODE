`timescale 1ns / 1ps




module path_test;

	// Inputs
	reg clk;
	reg rst;
	reg [29:0] v_1;
	reg [29:0] v_2;
	reg [29:0] v_3;
	reg [29:0] v_4;
	reg [29:0] v_5;
	reg [29:0] v_6;
	reg [29:0] v_7;
	reg [29:0] v_8;
	reg [29:0] v_9;
	reg [29:0] v_10;
	reg [29:0] v_11;
	reg [29:0] v_12;
	reg [29:0] v_13;
	reg [29:0] v_14;

	// Outputs
	wire [3:0] c_survive;
	wire path_end;

	// Instantiate the Unit Under Test (UUT)
	path uut (
		.clk(clk), 
		.rst(rst), 
		.v_1(v_1), 
		.v_2(v_2), 
		.v_3(v_3), 
		.v_4(v_4), 
		.v_5(v_5), 
		.v_6(v_6), 
		.v_7(v_7), 
		.v_8(v_8), 
		.v_9(v_9), 
		.v_10(v_10), 
		.v_11(v_11), 
		.v_12(v_12), 
		.v_13(v_13), 
		.v_14(v_14), 
		.c_survive(c_survive), 
		.path_end(path_end)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		v_1 = 4900;
		v_2 = 56900;
		v_3 = 42500;
		v_4 = 2500;
		v_5 = 22500;
		v_6 = 62500;
		v_7 = 40000;
		v_8 = 0;
		v_9 = 40000;
		v_10 = 80000;
		v_11 = 0;
		v_12 = 40000;
		v_13 = 80000;
		v_14 = 40000;

		// Wait 100 ns for global reset to finish
		#20;
      rst = 1;  
		// Add stimulus here

	end
   
always #5 clk =~ clk;
   
endmodule

