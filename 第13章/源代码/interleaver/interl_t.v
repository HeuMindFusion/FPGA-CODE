module interl_t;
	// Inputs
	reg clk;
	reg rst;
	reg[15:0] x;
	// Outputs
	wire[15:0] y;
	// Instantiate the Unit Under Test (UUT)
	interleaver uut (
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
		// Add stimulus here
	end
	
always #5 clk =~ clk;
always @(posedge clk)
 begin
 if(!rst)
  x<=0;
  else
   begin
    if(x<191)
     x<=x+1;
    else
     x<=0;
   end
 end
endmodule
