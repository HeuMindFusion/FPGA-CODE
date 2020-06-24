`timescale 1ns/1ps
//--------------------------adc.v-------------------------
module adc (nconvst,nbusy,data);
input	nconvst;		//A/D启动脉冲ST，即上图中
output	nbusy;			//A/D工作标志，即上图中	
output	data;			//数据总线，从AD.DATA文件中读取数据后经端口输出
reg[7:0]	databuf,i;	//内部寄存器
reg	nbusy;
wire[7:0]	data;
reg[7:0]	data_mem[0:255];
reg	link_bus;
integer	tconv,
	t5,
	t8,
	t9,
	t12;
integer wideth1,
	wideth2,
	wideth;

//时间参数定义(依据AD7886手册)
always @(negedge nconvst)
	begin
	     tconv=9500+{$random}%500;	//(type 950,max 1000) Conversion Time
	     t5={$random}%1000;	//(max 100)  CONVST to BUSY Propagation Dlay	
				//CL=10pf
	     t8=200;		//(min 20) CL=20pf Data Setup Time Prior to BUSY
				//(min 10) CL=100pf
	     t9=100+{$random}%900;	//(min 10,max 100) Bus Relinquish Time After CONVST
	     t12=2500;	//(type) BUSY High to CONVST Low,SHA Acquisition Time
end

initial
	begin
	$readmemh("adc.dat",data_mem);	//从数据文件adc.dat中读取数据
	i=0;
	nbusy=1;
		link_bus=0;
	end

assign data=link_bus? databuf:8'bzz;	//三态总线
/*----------------------------------------------------------------
在信号nconvst的负跳降沿到来后，隔t5秒nbusy信号置为低，tconv是AD将模
拟信号转换为数字信号的时间，在信号nconvst的正跳降沿到来后经过tconv时间后，
输出nbusy信号变为高。
-----------------------------------------------------------------*/

always @(negedge nconvst)
	fork
	#t5 nbusy=0;
		@(posedge nconvst)
			begin
			   #tconv nbusy=1;
			end
		join
/*----------------------------------------------------------------
nconvst 信号的下降沿触发，经过t9延时后，把数据总线输出关闭置为高阻态，如图示。
nconvst信号的上升沿到来后，经过(tconv-t8)时间，输出一个字节(8位数据)到databuf，
该数据来自于data_mem。而data_mem中的数据是初始化时从数据募AD.DATA中读取?耸应启动总线的三态输出?-----------------------------------------------------------------*/


always @(negedge nconvst)
	begin
	  @(posedge nconvst)
		begin
		 #(tconv-t8)	databuf=data_mem[i];
		end

		if(wideth<10000 && wideth>500)
		  begin
			if(i==255) i=0;
			else i=i+1;
		  end
		else i=i;
	end
	//在模拟转换期间关闭三态输出，转换结束时启动三态输出

always @(negedge nconvst)
  fork
	#t9 link_bus=1'b0;	//关闭三态输出，不允许总线输出
	@(posedge nconvst)
		begin
		#(tconv-t8)	link_bus=1'b1;
		end
	join

/*----------------------------------------------------------------
当nconvst输入信号的下一个转换的下降沿与nbusy信号上升沿之间时间延迟小于t12时，
将会出现警告信号，通知设计者请求转换的输入信号频率太快，A/D器件转换速度跟不上。
仿真模型不仅能够实现硬件电路的输出功能，同时能够对输入信号进行检测，当输入信号不符合手册要求时，显示警告信号。
----------------------------------------------------------------*/

//检查A/D启动信号的频率是否太快

always @(posedge nbusy)
  begin
	#t12;
	if(!nconvst)
	   begin
		$display("Warning!   SHA Acquisition Time is too short!");
	   end
	//else $display("SHA Acquisition Time is enough!");
  end

//检查A/D启动信号的负脉冲宽度是否够和太宽
always @(negedge nconvst)
  begin
	wideth=$time;
	@(posedge nconvst)	wideth=$time-wideth;
	if(wideth<=500 || wideth>10000)
	  begin

	    $display("nCONVST Pulse Wideth =%d",wideth);

	    $display("Warning! nCONVST Pulse Wideth is too narrow or too wide!");
	    //$stop
	    end
	end
endmodule

