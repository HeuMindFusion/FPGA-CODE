`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:16 07/29/2012 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    input clk,
	 input rst,
	 input x,
	 output y
    );
wire x1;
	 
QPSK   q_encode(.clk(clk),
                .rst(rst),
					 .x(x),
					 .y(x1)
					 );

qpsk_decode   q_d(.clk(clk),
                  .rst(rst),
						.x(x1),
						.y(y)
						);


endmodule
