`timescale 1ns / 1ps


module fifo_interface(
         in_data,	//对用户的输入数据总线
			out_data,	//对用户的输出数据总线，
			fiford,		//FIFO读控制信号，低电平有效
			fifowr,		//FIFO写控制信号，低电平有效
			nfull,
			nempty,
			address,	//到SRAM的地址总线
			sram_data,	//到SRAM的双向数据总线
			rd,		//SRAM读使能，低电平有效
			wr,		//SRAM写使能，低电平有效
			clk,		//系统时钟信号
			rst);		//全局复位信号，低电平有效

	
	//来自 用户的控制输入信号
	input		fiford,fifowr,clk,rst;

	//来自用户的数据信号
	input[7:0]		in_data;
	output[7:0]		out_data;


	reg[7:0]		in_data_buf,		//输入数据缓冲区
				   out_data_buf;		//输出数据缓冲区
	
	//输出到用户的状态指示信号				
	output			nfull,nempty;
	reg			   nfull,nempty;
	
	//输出到SRAM的控制信号
	output			rd,wr;
	
	//到SRAM的双向数据总线
	input[7:0]		sram_data;
	
	//输出到SRAM的地址总线
	output[10:0]	address;
	reg[10:0]	   address;
	
	//Internal Register
	reg[10:0]		fifo_wp,		//FIFO写指针
				      fifo_rp;		//FIFO读指针
					
	
	reg[10:0]		fifo_wp_next,		//fifo_wp的下一个值
				      fifo_rp_next;		//fifo_rp的下一个值
	
	reg			   near_full,near_empty;
	
	
	reg[3:0]		   state;		//SRAM操作状态机寄存器
	
	
	parameter		idle	     =4'b0000,
				      read_ready =4'b0100,
				      read	     =4'b0101,
				      read_over  =4'b0111,
				      write_ready=4'b1000,
				      write	     =4'b1001,
				      write_over =4'b1011,
                  SRAM_SIZE  = 8;
					
	
	//SRAM操作状态机				
	always @(posedge clk or negedge rst)
		if(~rst)
			state<=idle;
		else
			case(state)
			   idle:					//等待对FIFO的操作控制信号
				if(fifowr==0&&nfull)			//用户发出写FIFO申请，且FIFO未满
					state<=write_ready;
				else if(fiford==0 && nempty)		//用户发出读FIFO申请，且FIFO未空
					state<=read_ready;
				else					//没有对FIFO操作的申请
					state<=idle;
						
				read_ready:				//建立SRAM操作所需地址和数据
						state<=read;
						
				read:					//等待用户结束当前操作
					 if(fiford==1)
						state<=read_over;
					   else
						state<=read;
							
							
				read_over:				//继续给出SRAM地址以保证数据稳定
					state<=idle;
							
				write_ready:				//建立SRAM操作所需地址和数据
					state<=write;
								
				write:					//等待用户结束当前写操作
					if(fifowr==1)
						state<=write_over;
					else
						state<=write;
						
				write_over:				//继续给出SRAM地址和写入数据以保证数据稳定
					state<=idle;
								
							
				default:state<=idle;

				endcase
				
			//产生SRAM操作相关信号

			assign rd=~state[2];	//state为read_ready或read或read_over
			assign wr=(state==write)?fifowr:1'b1;
			
			
			always @(posedge clk)
				if(~fifowr)
					in_data_buf<=in_data;
					
			assign sram_data=(state[3])?in_data_buf:8'hz;	 //state为write_ready或wrrite或write_over
			
			always @(state or fiford or fifowr or fifo_wp or fifo_rp)
				if(state[2]||~fiford)
					address=fifo_rp;
				else if(state[3]||~fifowr)
					address=fifo_wp;
				else
					address='bz;
					
			//产生FIFO数据
		
			assign out_data=(state[2])?sram_data:8'bz;
			
			always @(posedge clk)
				if(state==read)
					out_data_buf<=sram_data;
			
			//计算FIFO读写指针		
			always @(posedge clk or negedge rst)
				if(~rst)
					fifo_rp<=0;
				else if(state==read_over)
					fifo_rp<=fifo_rp_next;
			
			always @(fifo_rp)
				if(fifo_rp==SRAM_SIZE-1)
					fifo_rp_next=0;
				else
					fifo_rp_next=fifo_rp+1;
					
			always @(posedge clk or negedge rst)
				if(~rst)
					fifo_wp<=0;
				else if(state==write_over)
					fifo_wp<=fifo_wp_next;
					
			always @(fifo_wp)
				if(fifo_wp==SRAM_SIZE-1)
					fifo_wp_next=0;
				else
					fifo_wp_next=fifo_wp+1;
					
			always @(posedge clk or negedge rst)
					if(~rst)
						near_empty<=1'b0;
					else if(fifo_wp==fifo_rp_next)
						near_empty<=1'b1;
					else
						near_empty<=1'b0;
			
			always @(posedge clk or negedge rst)
				if(~rst)
					nempty<=1'b0;
				else if(near_empty && state==read)
					nempty<=1'b0;
				else if(state==write)
					nempty<=1'b1;
					
			always @(posedge clk or negedge rst)
				if(~rst)
					near_full<=1'b0;
				else if(fifo_rp==fifo_wp_next)
					near_full<=1'b1;
				else
					near_full<=1'b0;
					
			always @(posedge clk or negedge rst)
				if(~rst)
					nfull<=1'b1;
				else if(near_full && state==write)
					nfull<=1'b0;
				else if(state==read)
					nfull<=1'b1;


endmodule
