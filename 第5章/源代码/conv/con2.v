`timescale 1ns / 1ps


module con2(address,indata,outdata,wr,nconvst,nbusy,enout1,enout2,CLK,reset,start);

   input   CLK,	                              //采用10MHZ的时钟
	        reset,	                              //复位信号
	        start,	                              //因为RAM的空间是有限的，当RAM存满后采样和卷积都会停止。此时给一个start的高电平脉冲将会开始下一次的卷积。
		     nbusy;	                              //从A/D转换器来的信号表示转换器的忙或闲
   output  wr,	                                 //RAM写控制信号
		     enout1,
		     enout2,	                           //enout1是存储卷积低字节结果RAM的片选信号enout2是存储卷积高字节结果RAM的片选信号
		     nconvst,	                           //给A/D转换器的控制信号，命令转换器开始工作，低电平有效	
		     address;	                           //地址输出
		
	input[7:0] indata;	                        //从A/D转换器来的数据总线
	output[7:0] outdata;	                        //写到RAM去的数据总线
	
	wire nbusy;
	reg wr,
	    nconvst,
	    enout1,
	    enout2,
       high,
		 EOC;
	reg[7:0]  outdata;
	reg[10:0] address;
	reg[8:0]  state;
	reg[15:0] result;
	reg[23:0] line;
	reg[11:0] counter;
	reg[4:0]  j;



	
	parameter h1=1,
	          h2=2,
				 h3=3;	                 //假设的系统系数
	
	parameter	  IDLE=9'b000000001,  
	             START=9'b000000010,  
				  NCONVST=9'b000000100,
			        READ=9'b000001000,  
					 CALCU=9'b000010000,   
				  WRREADY=9'b000100000,
			          WR=9'b001000000,  
					 WREND=9'b010000000,  
				  WAITFOR=9'b100000000;
			
	parameter FMAX=20;	//因为A/D转换的时间是随机的，为保证按一定的频率采样，A/D转换控制信号应以一定频率给出。这里采样频率ü鼺MAX刂?				//为500KHZ。
	
	
	always @(posedge CLK)
			if(!reset)
			   begin 
				state<=IDLE;
				nconvst<=1'b1;
				enout1<=1;
				enout2<=1;
				counter<=12'b0;
				high<=0;
				wr<=1;
				line<=24'b0;
				address<=11'b0;
			   end
			else
					case(state)
						IDLE:if(start==1)
							    begin
								  counter<=0;	             //counter是一个计数器，记录已用的RAM空间
								  line<=24'b0;
								  state<=START;
							    end
						     else
								state<=IDLE;
					                                 //START状态控制A/D开始转换		
						START:if(EOC)
								 begin
									nconvst<=0;
									high<=0;
									state<=NCONVST;
								 end
							   else
								state<=START;
						                             //NCONVST状态是A/D转换保持阶段				
						NCONVST:begin
								    nconvst<=1;
								    state<=READ;
							     end
						                             //READ状态读取A/D转换结果，计算卷积结果	
						READ: begin
							if(EOC)
							     begin
								   line<={line[15:0],indata};
								   state<=CALCU;
							     end 
						    else state<=READ;
							end
						CALCU: begin
							     result<=line[7:0]*h1+line[15:8]*h2+line[23:16]*h3;
							     state<=WRREADY;
							    end

//将卷积结果写入RAM时，先写入低字节，再写入高字节WRREADY状态是写RAM准备状态，建立地址和数据信号

						WRREADY:begin
								address<=counter;
								if(!high)   outdata<=result[7:0];
								else        outdata<=result[15:8];
								state<=WR;
							end
//WR状态产生片选和写脉冲	
						
						WR: begin
							 if(!high) enout1<=0;
							 else 	  enout2<=0;
							 wr<=0;
							 state<=WREND;
						    end
							
//WREND状态结束一次写操作，若还未写入高字节则转絎RREADY状态开始高字节写入	
						WREND:begin
							     wr<=1;
							     enout1<=1;
							     enout2<=1;
							      if(!high)
							        begin
								      high<=1;
								      state<=WRREADY;
							        end
							      else	state<=WAITFOR;
						       end
//WAITFOR状态控制采样频率并判断RAM是否已被写满			
						WAITFOR:begin
							   if(j==FMAX-1)
								begin
								    counter<=counter+1;
								    if(!counter[11])	state<=START;
								    else
									 begin
										state<=IDLE;
										$display($time,"The ram is used up.");
										$stop;
									 end
								end
							   else	state<=WAITFOR;		
							end
						default:state<=IDLE;
					endcase																
//assign rd=1;	//RAM的读信号始终保持为高				
								
//j记录时钟，与FMAX共同控制采样频率	,由于直接用CLK的上沿对nbusy判断以决定某些操作是否运行时，会因为两个信号				
//的跳变沿相隔太近而令状态机不能正常工作。因此利用CLK的下降沿建立EOC信号与nbusy同步，相位相差180度，然后用CLK的上升沿判断操作是否进行。										
				always @(negedge CLK)
					begin
						EOC<=nbusy;
						if(!reset||state==START)
							j<=1;
						else
							j<=j+1;
					end						
endmodule 