`timescale 1ns / 1ps




module sd_t;

	// Inputs
	wire x;
	reg clk;
	reg rst;
	
	reg[23:0] data;//

	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	sd uut (
		.x(x), 
		.clk(clk), 
		.rst(rst), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
      #5 rst = 0;
      #40 rst = 1;
      data = 20'b1100_1001_0000_1001_0100;		
		// Wait 100 ns for global reset to finish
        
		// Add stimulus here

	end
	
	always #10 clk =~ clk;
	
	always @(posedge clk)
	  data<={data[22:0],data[23]};
	
	assign x = data[23];
      
endmodule

