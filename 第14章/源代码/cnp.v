`timescale 1ns / 1ps


module cnp(
  input clk,
  input cnp_on,                 //1时cnp工作，0时不工作
  input ce,
  input[7:0] mess_din,
  output process_finish,       //cnp处理过程结束，高有效
  output mess_web,
  output[9:0] mess_addra,
  output[9:0] mess_addrb,
  output[7:0] mess_dout
    );

reg[2:0] cycle;                  //每个校验节点需要处理6个周期
reg[7:0] cnt_c;                    //计数校验节点
reg sign_buff_a;
reg sign_buff_b;
reg[7:0] mess_buff_a[0:5];       //存储输入的数据
reg[7:0] mess_buff_b[0:5];
reg[7:0] min_a_1;
reg[7:0] min_b_1;
reg[7:0] min_a_2;
reg[7:0] min_b_2;
reg flag;
reg n;
reg sign_0;
reg sign_1;

parameter c=4;

assign mess_addra = flag?n:(cnt_c+cnt_c+cnt_c+cnt_c+cnt_c+cnt_c+cycle+2'd2);
//由于加入interleaver，存在两个时钟周期的延迟，地址变为(6*cnt+cycle+2)
assign mess_addrb = mess_addra-4'd7;
assign mess_web = !ce?0:((cnt_c==0||cnt_c==(c+1))?0:1);
assign process_finish = !ce ? 0: (cnt_c==(c+1));

assign mess_dout = !cnt_c[0] ? ((abs(mess_buff_b[cycle])==min_b_2)?(sign_1? ({1'b1,~mult_0_75(min_b_1[7:0])}+1'b1):{1'b0,mult_0_75(min_b_1[7:0])}):(sign_1? ({1'b1,~mult_0_75(min_b_2[7:0])}+1'b1):{1'b0,mult_0_75(min_b_2[7:0])}))
:((abs(mess_buff_a[cycle])==min_a_2)?(sign_0?({1'b1,~mult_0_75(min_a_1[7:0])}+1'b1):{1'b0,mult_0_75(min_a_2[7:0])}):(sign_0?({1'b1,~mult_0_75(min_a_2[7:0])}+1'b1):{1'b0,mult_0_75(min_a_2[7:0])}));

always @(cycle)
 begin
 if(!cnt_c[0])
  sign_1<=sign_buff_b^mess_buff_b[cycle][7];
 else
  sign_0<=sign_buff_a^mess_buff_a[cycle][7];
 end
 
always @(posedge clk)
 if(!cnp_on||!ce)
  begin
   flag<=1;
	n<=0;
	cycle<=0;
	cnt_c<=0;
	sign_buff_a<=0;
	sign_buff_b<=0;
	min_a_1<=0;
	min_a_2<=0;
	min_b_1<=0;
	min_b_2<=0;
	mess_buff_a[0]<=0;
	mess_buff_a[1]<=0;
	mess_buff_a[2]<=0;
	mess_buff_a[3]<=0;
	mess_buff_a[4]<=0;
	mess_buff_a[5]<=0;
	mess_buff_b[0]<=0;
	mess_buff_b[1]<=0;
	mess_buff_b[2]<=0;
	mess_buff_b[3]<=0;
	mess_buff_b[4]<=0;
	mess_buff_b[5]<=0;
  end
 else
  if(cnt_c==0&&flag==1)        //使用flag等待两个时钟周期
   begin
	 cnt_c<=0;
	 if(n==1)
	  begin
	   n<=0;
		flag<=0;
	  end
	 else
	  n<=1;
	end
  else
   case(cycle)
	 3'b000: begin
	          if(!cnt_c[0])
				  begin
				   sign_buff_a<=sign_buff_a^mess_din[7];
					min_a_1<=abs(mess_din);
					min_a_2<=abs(mess_din);
				  end
				 else
				  begin
				   sign_buff_b<=sign_buff_b^mess_din[7];
					min_b_1<=abs(mess_din);
					min_b_2<=abs(mess_din);
				  end
				 cycle<=cycle+1;
				end
	 3'b001: begin
	         if(!cnt_c[0])
				 begin
	           sign_buff_a<=sign_buff_a^mess_din[7];
				   if(abs(mess_din)<min_a_1)
					 if(abs(mess_din)<min_a_2)
					 begin
				     min_a_1<=min_a_2;
				     min_a_2<=abs(mess_din);
					 end
					else
					 min_a_1<=abs(mess_din);
				 mess_buff_a[1]<=mess_din;
				 end
			   else
				 begin
				  sign_buff_b<=sign_buff_b^mess_din[7];
				   if(abs(mess_din)<min_b_1)
					 if(abs(mess_din)<min_b_2)
					  begin
				      min_b_1<=min_b_2;
				      min_b_2<=abs(mess_din);
					  end
					 else
					  min_b_1<=abs(mess_din);
				   mess_buff_b[1]<=mess_din;
				 end
				cycle<=cycle+1;
			  end
	 3'b010: begin
	         if(!cnt_c[0])
				 begin
	           sign_buff_a<=sign_buff_a^mess_din[7];
				   if(abs(mess_din)<min_a_1)
					 if(abs(mess_din)<min_a_2)
					 begin
				     min_a_1<=min_a_2;
				     min_a_2<=abs(mess_din);
					 end
					else
					 min_a_1<=abs(mess_din);
				 mess_buff_a[2]<=mess_din;
				 end
			   else
				 begin
				  sign_buff_b<=sign_buff_b^mess_din[7];
				   if(abs(mess_din)<min_b_1)
					 if(abs(mess_din)<min_b_2)
					  begin
				      min_b_1<=min_b_2;
				      min_b_2<=abs(mess_din);
					  end
					 else
					  min_b_1<=abs(mess_din);
				   mess_buff_b[2]<=mess_din;
				 end
				cycle<=cycle+1;
			  end
	3'b011: begin
	         if(!cnt_c[0])
				 begin
	           sign_buff_a<=sign_buff_a^mess_din[7];
				   if(abs(mess_din)<min_a_1)
					 if(abs(mess_din)<min_a_2)
					 begin
				     min_a_1<=min_a_2;
				     min_a_2<=abs(mess_din);
					 end
					else
					 min_a_1<=abs(mess_din);
				 mess_buff_a[3]<=mess_din;
				 end
			   else
				 begin
				  sign_buff_b<=sign_buff_b^mess_din[7];
				   if(abs(mess_din)<min_b_1)
					 if(abs(mess_din)<min_b_2)
					  begin
				      min_b_1<=min_b_2;
				      min_b_2<=abs(mess_din);
					  end
					 else
					  min_b_1<=abs(mess_din);
				   mess_buff_b[3]<=mess_din;
				 end
				cycle<=cycle+1;
			  end
	3'b100: begin
	         if(!cnt_c[0])
				 begin
	           sign_buff_a<=sign_buff_a^mess_din[7];
				   if(abs(mess_din)<min_a_1)
					 if(abs(mess_din)<min_a_2)
					 begin
				     min_a_1<=min_a_2;
				     min_a_2<=abs(mess_din);
					 end
					else
					 min_a_1<=abs(mess_din);
				 mess_buff_a[4]<=mess_din;
				 end
			   else
				 begin
				  sign_buff_b<=sign_buff_b^mess_din[7];
				   if(abs(mess_din)<min_b_1)
					 if(abs(mess_din)<min_b_2)
					  begin
				      min_b_1<=min_b_2;
				      min_b_2<=abs(mess_din);
					  end
					 else
					  min_b_1<=abs(mess_din);
				   mess_buff_b[4]<=mess_din;
				 end
				cycle<=cycle+1;
			  end
	3'b101: begin
	         if(!cnt_c[0])
				 begin
	           sign_buff_a<=sign_buff_a^mess_din[7];
				   if(abs(mess_din)<min_a_1)
					 if(abs(mess_din)<min_a_2)
					 begin
				     min_a_1<=min_a_2;
				     min_a_2<=abs(mess_din);
					 end
					else
					 min_a_1<=abs(mess_din);
				 mess_buff_a[5]<=mess_din;
				 end
			   else
				 begin
				  sign_buff_b<=sign_buff_b^mess_din[7];
				   if(abs(mess_din)<min_b_1)
					 if(abs(mess_din)<min_b_2)
					  begin
				      min_b_1<=min_b_2;
				      min_b_2<=abs(mess_din);
					  end
					 else
					  min_b_1<=abs(mess_din);
				   mess_buff_b[5]<=mess_din;
				 end
				cycle<=0;
				cnt_c<=cnt_c+1;
			  end
	endcase
	
function[7:0] abs;                                    //求绝对值
  input[7:0] value;
   begin
	 abs=value[7]?({1'b0,~value[6:0]}+1'b1):value[7:0];
	end
endfunction

function[6:0] mult_0_75;                             //将输入数据乘以0.75
   input[7:0] value;
	reg[8:0] temp;
	begin
	 temp={1'b0,value}<<1;
	 mult_0_75=({2'b00,value}+{1'b0,temp})>>2;
	end
endfunction

endmodule