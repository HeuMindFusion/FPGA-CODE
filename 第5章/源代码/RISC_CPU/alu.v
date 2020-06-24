`timescale 1ns / 1ps


module alu(
    input [7:0] al_data,
	 input [7:0] al_accum,
	 input [2:0] opcode,
	 input alu_c,
	 output reg[7:0] alu_out,
	 output zero
    );
	
	 
	 parameter  HLT = 3'b000,
	            SKZ = 3'b001,
					ADD = 3'b010,
				  ANDD = 3'b011,
				  XORR = 3'b100,
				   LDA = 3'b101,
					STO = 3'b110,
					JMP = 3'b111;	
	
	  assign zero=(!al_accum);
	  
	 always @(posedge alu_c)
		  begin
		   case(opcode)
			 HLT:alu_out<=al_accum;
			 SKZ:alu_out<=al_accum;
			 ADD:alu_out<=al_data+al_accum;
			 ANDD:alu_out<=al_data&al_accum;
			 XORR:alu_out<=al_data^al_accum;
			 LDA:alu_out<=al_data;
			 STO:alu_out<=al_accum;
			 JMP:alu_out<=al_accum;
			 default:alu_out<=8'bxxxxxxxx;
			endcase
		  end
endmodule
