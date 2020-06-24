`timescale 1ns / 1ps




module RS_t;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] m;

	// Outputs
	wire [7:0] c;

	// Instantiate the Unit Under Test (UUT)
	RS_top uut (
		.clk(clk), 
		.rst(rst), 
		.m(m), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		m = 0;

		// Wait 10 ns for global reset to finish
		#10;
		rst = 1;
		#20;
		rst = 0;
		#10;
		rst = 1;
        
		// Add stimulus here

	end
	
	always #5 clk =~ clk;
	always @(posedge clk)
	 begin
	  if(!rst)
	   begin
		m<=0;
		end
	  else
	   begin
	   m<=m+1;
		end
	end
      
endmodule

