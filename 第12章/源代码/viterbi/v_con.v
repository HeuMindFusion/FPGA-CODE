`timescale 1ns / 1ps

module v_con(
    input clk,
	 input rst,
	 input x,
	 input[13:0] a_o,
	 input[6:0] c_o,
	 output y,
	 output c,
	 output [13:0] x_out,
	 output reg rd,
	 output reg ready
    );
reg [13:0] x_t;
reg [13:0] x_t1;
reg [3:0] cnt;
reg [13:0] a_out1;
reg [6:0] c_t;

assign x_out = x_t;

always @(posedge clk) 
begin
  if(!rst) 
	begin //完成数据寄存以及时钟分频
		x_t <= 0;
		x_t1 <= 0;
		cnt <= 0;
	end
  else 
	begin
	   if(cnt == 4'b1101)
			cnt <= 4'b0000;
		else
		   cnt <= cnt +1;
		x_t1 <= {x,x_t1[13:1]};
		if(cnt == 4'b0000) 
		begin
			x_t <= x_t1;
		end
		else
		   x_t <= x_t;
	end	
end

always @(posedge clk) 
begin
   if(!rst) 
	begin
	  ready <= 0;
	  a_out1 <= 0;
	  c_t <= 0;
	  rd <= 0;
	end
   else 
	begin 
     if(cnt==0)
       rd <= 1;
     else
       rd <= 0;	  
	  if(cnt == 1)
	  begin
	     c_t <= c_o;
		  a_out1 <= a_o;
		  ready <= 1;
	  end
	  else 
	  begin
	     ready <= 0;
		  a_out1[13:0] <= {a_out1[0], a_out1[13:1]};	   //串行输出
		  if(cnt[0]==1)                                 //和clk_div2同步串行输出
		    c_t[6:0] <={c_t[5:0], c_t[6]};
		  else
		    c_t[6:0] <=c_t[6:0];		    
     end		  
	end
end

assign y = a_out1[0];
assign c = c_t[6];

endmodule
