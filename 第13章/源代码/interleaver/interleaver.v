module interleaver(
     input clk,
     input rst,
     input[15:0] x,
     output[15:0] y,
	output f
     );
reg [7:0] addra; 
reg [7:0] addrb;               //RAM�Ŀ��Ƶ�ַ
reg [3:0] cnt;                 //12��һת�е�ͷλ�ÿ�ʼ��
reg [3:0] addr0;              //�ж�ȡ�ĳ�ʼλ��
reg wd;                     //��д������Ч
reg rd;                     //�ɶ�������Ч

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
	   if(addra<191)		      //дx
		begin
		 addra<=addra + 1;
		end
      else
		 begin
	     addra <=192;
        wd<=1;                //д�꣬��ʼ��
       end			
	 end
end

always @(posedge clk)        //��y
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
always @(posedge clk)        //flag��Ҫ��Ϊ����Ϊ��turbo�붥��ģ��֪��ʲôʱ����꣬��д����
begin
 if(addrb==191)
  flag<=1;
 else
  flag<=0;
end
assign f = flag;
block_ram block_ram(            //˫��RAM��IP�˵���
	.addra(addra),
	.addrb(addrb),
	.clka(clk),
	.clkb(clk),
	.dina(x),
	.doutb(y),
	.wea(rst)
	);
endmodule
