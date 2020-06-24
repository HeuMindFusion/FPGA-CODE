`timescale 1ns / 1ps


module machine(
    input clk,
	 input zero,
	 input ena,
	 input [2:0] opcode_c,
	 output reg inc_pc,
	 output reg load_acc,
	 output reg load_pc,
	 output reg rd,
	 output reg wr,
	 output reg load_ir,
	 output reg datactl_ena,
	 output reg halt
    );
	 reg [2:0] state;
	 
	 parameter   HLT = 3'b000,
	            SKZ = 3'b001,
					ADD = 3'b010,
				  ANDD = 3'b011,
				  XORR = 3'b100,
				   LDA = 3'b101,
					STO = 3'b110,
					JMP = 3'b111;

   always @(negedge clk)
     begin
      if(!ena)
          begin
           state<=3'b000;
           {inc_pc,load_acc,load_pc,rd}<=4'b0000;
           {wr,load_ir,datactl_ena,halt}<=4'b0000;
          end
       else
          ctl_cycle;
     end
	  
    task ctl_cycle;
      begin
       case(state)
       	3'b000:
			   begin
				 {inc_pc,load_acc,load_pc,rd}<=4'b0001;
				 {wr,load_ir,datactl_ena,halt}<=4'b0100;
				 state<=3'b001;
				end
			3'b001:
			   begin
				 {inc_pc,load_acc,load_pc,rd}<=4'b1001;
				 {wr,load_ir,datactl_ena,halt}<=4'b0100;
				 state<=3'b010;
				end
			3'b010:
			   begin
				 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
				 {wr,load_ir,datactl_ena,halt}<=4'b0000;
				 state<=3'b011;
				end
			3'b011:
			 begin
			  if(opcode_c==HLT)
			   begin
				 {inc_pc,load_acc,load_pc,rd}<=4'b1000;
				 {wr,load_ir,datactl_ena,halt}<=4'b0001;
				 end
				else
				 begin
				  {inc_pc,load_acc,load_pc,rd}<=4'b1000;
				  {wr,load_ir,datactl_ena,halt}<=4'b0000;
				 end
				state<=3'b100;
			  end
			3'b100:
			    begin
				  if(opcode_c==JMP)
				   begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b0010;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
					else
					 if(opcode_c==ADD||opcode_c==ANDD||opcode_c==XORR||opcode_c==LDA)
					   begin
						 {inc_pc,load_acc,load_pc,rd}<=4'b0001;
						 {wr,load_ir,datactl_ena,halt}<=4'b0000;
						end
					  else
                  if(opcode_c==STO)
                     begin
							 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
							 {wr,load_ir,datactl_ena,halt}<=4'b0010;
							 end
						else
						  begin
						    {inc_pc,load_acc,load_pc,rd}<=4'b0000;
							 {wr,load_ir,datactl_ena,halt}<=4'b0000;
						  end
						state<=3'b101;
				end
         3'b101:
   			begin
				 if(opcode_c==ADD||opcode_c==ANDD||opcode_c==XORR||opcode_c==LDA)
				  begin
				   {inc_pc,load_acc,load_pc,rd}<=4'b0101;
					{wr,load_ir,datactl_ena,halt}<=4'b0000;
				  end
				 else
				  if(opcode_c==SKZ&&zero==1)
				   begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b1000;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
             else
              if(opcode_c==JMP)				 
					begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b1010;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
				 else
				  if(opcode_c==STO)
				   begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
					 {wr,load_ir,datactl_ena,halt}<=4'b1010;
					end
				 else
				   begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
			   state<=3'b110;
			end
	  3'b110:
	        begin
			   if(opcode_c==STO)
				 begin
				  {inc_pc,load_acc,load_pc,rd}<=4'b0000;
				  {wr,load_ir,datactl_ena,halt}<=4'b0010;
				 end
				else
				 if(opcode_c==ADD||opcode_c==ANDD||opcode_c==XORR||opcode_c==LDA)
					begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b0001;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
				 else
				   begin
					 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
					 {wr,load_ir,datactl_ena,halt}<=4'b0000;
					end
				state<=3'b111;
			end
	  3'b111:
	        begin
			   if(opcode_c==SKZ&&zero==1)
				 begin
				  {inc_pc,load_acc,load_pc,rd}<=4'b1000;
				  {wr,load_ir,datactl_ena,halt}<=4'b0000;
				 end
				else
				 begin
				  {inc_pc,load_acc,load_pc,rd}<=4'b0000;
				  {wr,load_ir,datactl_ena,halt}<=4'b0000;
				 end
				state<=3'b000;
		     end
	 default:
	         begin
				 {inc_pc,load_acc,load_pc,rd}<=4'b0000;
				 {wr,load_ir,datactl_ena,halt}<=4'b0000;
            state<=3'b000;				
				end
		endcase
	  end
	 endtask
endmodule
