`timescale 1ns / 1ps


module conv(
      input clk,
      input reset,
      input x,
      output reg y
            );
parameter s0 = 2'b00,            //ËÄ¸ö×´Ì¬
          s1 = 2'b01, 
			 s2 = 2'b10,
			 s3 = 2'b11;
reg clk1;                       //
reg [1:0] state;
reg [1:0] next_state;
reg [1:0] enc_out;

always @(posedge clk)
 begin
	if(!reset)
 	begin
		state <= s0;
		clk1 <= 0;
		next_state <= s0;
		enc_out <= 2'b00;
	end
	else 
	 begin
	   clk1 <= !clk1;
		if(clk1==1)
		begin
			state <= next_state;
			y <= enc_out[1];
		end
		else 
		begin
		   state <= state;
			y <= enc_out[0];
		end
		case(state)
			s0: if(x==0)
			    begin
					next_state <= s0;
					enc_out <= 2'b00;
				 end
				 else 
				 begin
					next_state <= s1;	
					enc_out <= 2'b11;
				 end
			s1: if(x==0) 
			    begin
					next_state <= s2;
					enc_out <= 2'b10;
				 end
				 else 
				 begin
				   next_state <= s3;	
					enc_out <= 2'b01;
				 end
			s2: if(x==0)
      		 begin
					next_state <= s0;
					enc_out <= 2'b11;
				 end
				 else 
				 begin
				   next_state <= s1;	
					enc_out <= 2'b00;
				 end
			s3: if(x==0)
             begin
					next_state <= s2;
					enc_out <= 2'b01;
				 end
				 else 
				 begin
				   next_state <= s3;	
					enc_out <= 2'b00;
			    end
			default : if(x==0) 
			          begin
							next_state <= s0;
							enc_out <= 2'b11;
						 end
						 else 
						 begin
							next_state <= s2;	
							enc_out <= 2'b01;
						 end
		endcase
	end
end

endmodule
