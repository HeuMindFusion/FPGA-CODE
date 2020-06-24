`timescale 1ns / 1ps


module b2c2(
   input clk,
	input rst,
   input[3:0] b2c_in,
	output b2c_out,
	output b2c_en
    );
reg[63:0] middle = 0;
reg[5:0] cnt_x = 0;         //0-63
reg[3:0] m_cnt = 0;
reg x = 0;
reg b2c_over = 0;

assign b2c_en = b2c_over;
assign b2c_out = x;
 
always @(posedge clk)
 begin
  if(!rst)
   begin
	 m_cnt <= 0;
	 middle <= 0;
	 x <= 0;
	 cnt_x <= 0;
	 b2c_over <= 0;
	end
  else
   begin
	 if(m_cnt<15)
	  begin
		middle <= {middle[59:0],b2c_in};     //Ñ­»·ÓÒÒÆ
	   m_cnt <= m_cnt+1;
	  end
	 else
	  begin
		m_cnt <= 15;
		b2c_over <= 1;
		if(cnt_x<63)
	    begin 
	     x <= middle[cnt_x];
		  cnt_x <= cnt_x+1;
	    end
	   else
	    begin
	     x <= 0;
		  cnt_x <= 63;
		  b2c_over<=0;
	    end
	 end
	end
 end

endmodule
