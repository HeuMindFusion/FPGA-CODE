`timescale 1ns / 1ps


module top(
    input [7:0] data,
	 input rst,
	 input clk,
	 input [2:0] opcode,
	 input [12:0] ir_addr,
	 //output [15:0] opc_irad,
	 output [2:0] opcode1,
	 output [12:0] ir_addr1,
	 output rd,
	 output wr,
	 output halt,
	 output [7:0] data1,
	 output [12:0] addr,
	 output [7:0] accum_out,
	 output [7:0] aluoo,
	 output [12:0] pcaddrout
	 //output load_acc
    );
    
clk           clkgen(.clk(clk),
                     .rst(rst),
                     .clk1(clk1),
							.fetch(fetch),
							.alu_clk(alu_clk)
							);
register      register(.clk1(clk1),
                       .rst(rst),
							  .r_ena(load_ir1),
							  .r_data(data),
							  .opcode1(opcode1),
							  .ir_addr1(ir_addr1)
							  );
	  
accuml         accuml(.ac_data(aluoo),
                      .a_ena(load_acc),
						    .clk1(clk1),
						    .rst(rst),
						    .accum_out(accum_out)
						    );
alu           alu(.al_data(data),
                  .al_accum(accum_out),
						.alu_c(alu_clk),
						.opcode(opcode),
						.alu_out(aluoo),
						.zero(zero)
						);
datactl       datactl(.in(aluoo),
                      .data_ena(datactl_ena),
							 .data1(data1)
							 );
adr           adr( .fetch(fetch),
                   .ir_addr(ir_addr),
						 .pc_addr(pcaddrout),
						 .addr(addr)
						 );
counter       counter(.irc_addr(ir_addr),
                      .load(load_pc),
							 .clock(inc_pc),
							 .rst(rst),
							 .pcc_addr(pcaddrout)
							 );
control       control(.clk1(clk1),
                      .ct_zero(zero),
							 .fetch(fetch),
							 .rst(rst),
							 .opcode_c(opcode),
							 .inc_pc(inc_pc),
							 .load_acc(load_acc),
							 .load_pc(load_pc),
							 .mem_rd(rd),
							 .mem_wr(wr),
							 .load_ir1(load_ir1),
							 .halt(halt),
							 .datactl_ena(datactl_ena)
							 );

endmodule
