`timescale 1ns / 1ps

 Company: 
// Engineer: 
// 
// Create Date:    19:00:19 02/19/2012 
// Design Name: 
// Module Name:    datactl 
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
module datactl(
    input [7:0] in,
	 input data_ena,
	 output [7:0] data1
    );
	 
   assign data1 = (data_ena)?in:8'bzzzzzzzz;

endmodule
