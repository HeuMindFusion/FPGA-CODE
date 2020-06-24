`timescale 1ns / 1ps


module MS_LDPC(
    input clk,
    input ce,
    output over
    );
wire resultmem_we;
wire[7:0] srcmem_addr;
wire[7:0] resultmem_addr;
wire[7:0] srcmem_din;
wire[7:0] resultmem_dout;

wire vnp_f;
wire cnp_f;
wire cnp_on;
wire last_iteration;
wire[7:0] mess_m2n;
wire[7:0] mess_n2m;
wire[7:0] vnp_mess_dout;
wire[7:0] cnp_mess_dout;
wire[9:0] vnp_mess_addra;
wire[9:0] vnp_mess_addrb;
wire[9:0] cnp_mess_addra;
wire[9:0] cnp_mess_addrb;

wire[9:0] mess_addra;
wire[9:0] mess_addrb;
wire[9:0] cnp_mess_addra_inter;
wire[9:0] cnp_mess_addrb_inter;

wire vnp_mess_web;
wire cnp_mess_web;
wire mess_web;

assign mess_n2m = cnp_on?cnp_mess_dout:vnp_mess_dout;          //决定谁来操作mess_mem，给谁的地址 
assign mess_addra = cnp_on?cnp_mess_addra_inter:vnp_mess_addra;
assign mess_addrb = cnp_on?cnp_mess_addrb_inter:vnp_mess_addrb;

assign mess_web = ce?(cnp_on?cnp_mess_web:vnp_mess_web):0;     //决定B是否写值

control #(.max_inter_num(10)) m0(
        .ce(ce),
		  .over(over),
		  .vnp_f(vnp_f),
		  .cnp_f(cnp_f),
		  .cnp_on(cnp_on),
		  .last_iteration(last_iteration)
		  );
		  
vnp    m1(
          .clk(clk),
			 .ce(ce),
			 .cnp_on(cnp_on),
			 .process_finish(vnp_f),
			 .last_iteration(last_iteration),
			 .srcmem_addr(srcmem_addr),
			 .srcmem_din(srcmem_din),
			 .resultmem_addr(resultmem_addr),
			 .resultmem_dout(resultmem_dout),
			 .resultmem_we(resultmem_we),
			 .mess_din(mess_m2n),
			 .mess_dout(vnp_mess_dout),
			 .mess_addra(vnp_mess_addra),
			 .mess_addrb(vnp_mess_addrb),
			 .mess_web(vnp_mess_web)
			 );
			 
cnp    m2(
          .clk(clk),
			 .ce(ce),
			 .cnp_on(cnp_on),
			 .process_finish(cnp_f),
			 .mess_din(mess_m2n),
			 .mess_dout(cnp_mess_dout),
			 .mess_addra(cnp_mess_addra),
			 .mess_addrb(cnp_mess_addrb),
			 .mess_web(cnp_mess_web)
			 );
			 
mess_mem m3(                            //中间信息存储器，双端口RAM，A只读，B只写，容量位位宽8，深度24
            .addra(mess_addra),
				.addrb(mess_addrb),
				.clka(clk),
				.clkb(clk),
				.dinb(mess_n2m),
				.douta(mess_m2n),
				.web(mess_web)
				);
				 
src_mem m4(                             //初始数据寄8,8
           .addra(srcmem_addr),
			  .clka(clk),
			  .douta(srcmem_din)
			  );
			  
result_mem m5(                         //译码结果存储器，位宽和深度同上
              .addr(resultmem_addr),
				  .clk(clk),
				  .din(resultmem_dout),
				  .dout(),
				  .we(resultmem_we)
				  );
				
inter_rom m6(
             .addra(cnp_mess_addra),
				 .addrb(cnp_mess_addrb),
				 .clka(clk),
				 .clkb(clk),
				 .douta(cnp_mess_addra_inter),
				 .doutb(cnp_mess_addrb_inter));

endmodule
