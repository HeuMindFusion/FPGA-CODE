module t_jic;
	// Inputs
	reg clk;
	reg en;
	reg [3:0] d;
	// Outputs
	wire [3:0] q;
	// Instantiate the Unit Under Test (UUT)
	jic uut (
		.clk(clk), 
		.en(en), 
		.d(d), 
		.q(q)
	     );

	initial 
	begin
		clk = 0;
		en = 0;
		d = 4'b1101;
      #15 en = 1;
	end 
   always #5 clk = ~clk;

endmodule
