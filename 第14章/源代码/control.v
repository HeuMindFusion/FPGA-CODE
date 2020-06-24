`timescale 1ns / 1ps

module control(
    input ce,                //1开始操作，0开始清零
	 input vnp_f,             //vnp处理完成
	 input cnp_f,             //cnp处理完成
	 output reg cnp_on,
	 output last_iteration,
    output reg over              //高电平表示所有操作完成
    );
reg[6:0] inter_num;             //迭代次数
wire var;

parameter  max_inter_num = 10;  //最大迭代次数

assign var = vnp_f|cnp_f;       //cnp_f和vnp_f都会引起状态变化
assign last_iteration = (inter_num==max_inter_num);

always @(negedge ce or negedge var)
 begin
  if(!ce)
   begin
	 cnp_on<=0;
	 over<=0;
	 inter_num<=0;
	end
  else
   begin
	 if(!cnp_on)
	  if(inter_num==max_inter_num)
	   begin
		 inter_num<=0;
		 cnp_on<=0;
		 over<=1;
		end
	  else
	   begin
		 inter_num<=inter_num+1;
		 cnp_on<=1;
		 over<=0;
		end
	 else
	  cnp_on<=0;
	 end
end
endmodule
