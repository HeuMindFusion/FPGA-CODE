`timescale 1ns / 1ps


module linearencoder(
    input reset,
	 input[6:0] y,
	 output[6:0] x
    );
	 wire[2:0] s;//校正子
	 reg[6:0] e;//误码
	 
	 assign s[2] = reset?0:(y[5]^y[4]^y[3]^y[2]);//根据HT的位置
	 assign s[1] = reset?0:(y[6]^y[5]^y[3]^y[1]);
	 assign s[0] = reset?0:(y[6]^y[4]^y[3]^y[0]);
	 
	 always @(s[2:0] or reset)//校正子来确定误码位置
	  begin
	   if(reset)
		 e<=0;
		else
		 case(s[2:0])
		  3'b000:e<=7'b0000000;
		  3'b001:e<=7'b0000001;
		  3'b010:e<=7'b0000010;
		  3'b011:e<=7'b0000100;
		  3'b100:e<=7'b0001000;
		  3'b101:e<=7'b0010000;
		  3'b110:e<=7'b0100000;
		  3'b111:e<=7'b1000000;
		 default:e<=7'b0000000;
		 endcase
	 end

   assign x = reset?0:y^e;//接收到的序列和误码异或就纠错过来了
endmodule
