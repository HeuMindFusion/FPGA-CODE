`timescale 1ns/1ps
module testcon1;

wire wr,
	  enin,
	  enout1,
	  enout2;
wire [10:0] address;
reg rd,
	 CLK,
	 reset,
	 start;
wire nbusy;
wire nconvst;
wire[7:0] indata;
wire[7:0] outdata;
integer i;

parameter HALF_PERIOD=10;

//产生10MHZ的时钟

initial
	begin
		rd=1;
		i=0;
		CLK=1;
		forever #HALF_PERIOD CLK=~CLK;
	end
	//产生置位信号
	initial
	begin
		reset=1;
		#(HALF_PERIOD*2+50) reset=0;
		#(HALF_PERIOD*3) reset=1;
	end
	
	//产生开始卷积控制信号
	initial
		begin
			start=0;
			#(HALF_PERIOD*7+20) start=1;
			#(HALF_PERIOD*2) start=0;
			#(HALF_PERIOD*1000) start=1;
			#(HALF_PERIOD*2) start=0;
		end
		
		assign enin =1;
		
		
		con2 con(.address(address),.indata(indata),.outdata(outdata),.wr(wr),
		          .nconvst(nconvst),.nbusy(nbusy),.enout1(enout1),
				    .enout2(enout2),.CLK(CLK),.reset(reset),.start(start));
	
		sram ramlow(.Address(address),.Data(outdata),.SRW(wr),.SRG(rd),.SRE(enout1));
		adc adc(.nconvst(nconvst),.nbusy(nbusy),.data(indata)); 
		
		
endmodule
