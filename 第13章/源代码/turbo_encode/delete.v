`timescale 1ns / 1ps


module delete(
   input clk,
	input delete_start,          //ɾ�࿪ʼ
	input[3:0] delete_in1,
	input[3:0] delete_in2,
	output[3:0] delete_out,
	output delete_over
    );	 
reg cnt;
reg delete_o;
reg[3:0] cnt_over;

assign delete_over = delete_o;
always @(posedge clk)
 begin
  if(delete_start==0)
   begin
	 cnt<=0;
	 cnt_over<=0;
	 delete_o<=0;
	end
  else
   begin
	 cnt<=cnt+1;
	  if(cnt_over<15)
	   begin
		 cnt_over<=cnt_over+1;
		end
	  else
	   begin
		 cnt_over<=15;
	    delete_o<=1;
		end
	end
 end
 
assign delete_out = (delete_start&&(!delete_over)) ? ((cnt==0) ? delete_in1 : delete_in2) : 0;
endmodule
