`timescale 1ns / 1ps


module linearcoder(
    input reset,
	 input[3:0] u,
	 output[6:0] c
    );
	 assign c[6:3] = reset? 4'b0000:u[3:0];
	 assign c[2] = reset? 0:(u[2]^u[1]^u[0]);
	 assign c[1] = reset? 0:(u[3]^u[2]^u[0]);
	 assign c[0] = reset? 0:(u[3]^u[1]^u[0]);
endmodule
