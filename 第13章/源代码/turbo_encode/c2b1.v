`timescale 1ns / 1ps


module c2b1(
    input clk,
	 input c2b_en,
	 input c2b_in,
	 output[3:0] c2b_out
    );
reg[3:0] cnt_rsc1 = 0;
reg[3:0] rsc1 = 0;
reg[63:0] middle = 0;
reg[5:0] in_cnt = 0;

assign c2b_out = rsc1;

always @(posedge clk)
 begin
  if(!c2b_en)
   begin
	 in_cnt<=0;
	 middle<=0;
	 cnt_rsc1<=0;
	 rsc1<=0;
   end
  else
   begin
	 if(in_cnt<63)
	  begin
		middle<={middle[62:0],c2b_in};
		in_cnt<=in_cnt+1;
	  end
	 else
	  begin
		in_cnt<=63;
		if(cnt_rsc1<15)                     //4*16=64
	    begin
	     rsc1<=middle[63:60];
	     middle<={middle[59:0],middle[63:60]};
	     cnt_rsc1<=cnt_rsc1+1;
	    end
	   else
	    begin
	     cnt_rsc1<=15;
	    end
	  end
	end
end
 
endmodule
