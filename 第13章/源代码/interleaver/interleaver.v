module interleaver(
     input clk,
     input rst,
     input[15:0] x,
     output[15:0] y,
	output f
     );
reg [7:0] addra; 
reg [7:0] addrb;               //RAM的控制地址
reg [3:0] cnt;                 //12个一转列的头位置开始读
reg [3:0] addr0;              //列读取的初始位置
reg wd;                     //可写，高有效
reg rd;                     //可读，高有效

always @(posedge clk)
begin
 if(!rst)
  begin
   rd<=0;
  end
 else
  begin
   rd<=1;
  end
end
always @(posedge clk) 
begin
	if(!rd) 
	 begin
		addra <= 0;
		wd<=0;
	 end
	else 
	 begin
	   if(addra<191)		      //写x
		begin
		 addra<=addra + 1;
		end
      else
		 begin
	     addra <=192;
        wd<=1;                //写完，则开始读
       end			
	 end
end

always @(posedge clk)        //读y
begin
if(!wd)
  begin
   addrb<=0;
	addr0<=1;
	cnt<=0;
  end
else
 begin
    if(cnt<11)
     begin
	   cnt<=cnt+1;
	   addrb<=addr0;
	   addrb<=addrb+16;
     end
    else
     begin
	   addr0<=addr0+1;
	   addrb<=addr0;
	   cnt<=0;
     end
 end
end
reg flag;
always @(posedge clk)        //flag主要是为了作为让turbo码顶层模块知道什么时候读完，再写数据
begin
 if(addrb==191)
  flag<=1;
 else
  flag<=0;
end
assign f = flag;
block_ram block_ram(            //双口RAM的IP核调用
	.addra(addra),
	.addrb(addrb),
	.clka(clk),
	.clkb(clk),
	.dina(x),
	.doutb(y),
	.wea(rst)
	);
endmodule
