`timescale 1ns / 1ps




module survive_test;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] m11;
	reg [15:0] m21;
	reg [15:0] m31;
	reg [15:0] m41;
	reg [15:0] m12;
	reg [15:0] m22;
	reg [15:0] m32;
	reg [15:0] m42;

	// Outputs
	wire [29:0] v_1;
	wire [29:0] v_2;
	wire [29:0] v_3;
	wire [29:0] v_4;
	wire [29:0] v_5;
	wire [29:0] v_6;
	wire [29:0] v_7;
	wire [29:0] v_8;
	wire [29:0] v_9;
	wire [29:0] v_10;
	wire [29:0] v_11;
	wire [29:0] v_12;
	wire [29:0] v_13;
	wire [29:0] v_14;

	// Instantiate the Unit Under Test (UUT)
	survive uut (
		.clk(clk),
		.rst(rst), 
		.m11(m11), 
		.m21(m21), 
		.m31(m31), 
		.m41(m41), 
		.m12(m12), 
		.m22(m22), 
		.m32(m32), 
		.m42(m42), 
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
		.v_14(v_14)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		m11 = 0;
		m21 = 0;
		m31 = 0;
		m41 = 0;
		m12 = 0;
		m22 = 0;
		m32 = 0;
		m42 = 0;

		// Wait 100 ns for global reset to finish
		#10;
		m11 = 32798;//-0.3
		m12 = 32868;//-1
		// Add stimulus here
		m21 = 100;  //1
		m22 = 32818;//-0.5
		m31 = 100;  //1
		m32 = 32868;//-1
		m41 = 32868;//-1
		m42 = 32868;//-1
		#200;
		rst = 1;

	end
	always #5 clk =~ clk;
endmodule

