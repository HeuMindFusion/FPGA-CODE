`timescale 1ns / 1ps

module c2b2(
    input clk,
	 input c2b_en,
	 input c2b_in,
	 output[3:0] c2b_out,
	 output c2b_over
    );
reg[3:0] cnt_rsc2 = 0;
reg[3:0] rsc2 = 0;
reg[63:0] middle = 0;
reg[5:0] in_cnt = 0;
reg c2b_o;

assign c2b_over = c2b_o;
assign c2b_out = rsc2;

always @(posedge clk)
 begin
  if(!c2b_en)
   begin
	 in_cnt<=0;
	 middle<=0;
	 cnt_rsc2<=0;
	 rsc2<=0;
	 c2b_o<=0;
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
		c2b_o<=1;
		if(cnt_rsc2<15)                     //4*16=64
	    begin
	     rsc2<=middle[63:60];
	     middle<={middle[59:0],middle[63:60]};
	     cnt_rsc2<=cnt_rsc2+1;
	    end
	   else
	    begin
	     cnt_rsc2<=15;
	    end
	  end
	end
end
 
endmodule
