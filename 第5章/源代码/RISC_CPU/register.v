`timescale 1ns / 1ps


module register(
    input [7:0] r_data,
	 input clk1,
	 input r_ena,
	 input rst,
	 output [2:0] opcode1,
	 output [12:0] ir_addr1
    );
	 reg state;
	 reg [15:0] opc_irad;
	 
    assign  opcode1[2:0] = opc_irad[2:0];
	 assign  ir_addr1[12:0] = opc_irad[15:3];
	  
	 always @(posedge clk1)
	  begin
	   if(rst)
		 begin
		  opc_irad<=16'b0000000000000000;
		  state<=1'b0;
		 end
		else
		 begin
		  if(r_ena)
		   begin
			 case(state)
			  1'b0:
			   begin
				 opc_irad[15:8]<=r_data;
				 state<=1;
				end
			  1'b1:
			   begin
				 opc_irad[7:0]<=r_data;
				 state<=0;
				end
			  default:
			   begin
				 opc_irad[15:0]<=16'bxxxxxxxxxxxx;
				 state<=1'bx;
				end
			 endcase
			end
		else
		 state<=1'b0;
	 end
end
endmodule
