`timescale 1ns / 1ps
/

module vnp(
   input clk,
	input ce,
	input cnp_on,                          //0ʱ��vnp������1������
	input last_iteration,                  //����Ч�����һ�ε���ָʾ
	input[7:0] srcmem_din,
	input[7:0] mess_din,                    //��mess_mem��������
	output process_finish,                  //����Ч��ֹͣ����
	output resultmem_we,
	output mess_web,
	output[7:0] resultmem_dout,
	output[7:0] srcmem_addr,
	output[7:0] resultmem_addr,
	output[9:0] mess_addra,                 //ֻ��
	output[9:0] mess_addrb,                 //ֻд
	output[7:0] mess_dout                   //��mess_mem
	);
reg[1:0] cycle;              //���ڼ���ÿ�������ڵ������
reg[8:0] cnt_v;                //���ڼ��������ڵ�
reg[9:0] calc_a;
reg[9:0] calc_b;             //����λ��չ���洢���ݵĺ�
reg[7:0] mess_buff_a[0:2];   //���ڴ洢ÿ�ζ��������
reg[7:0] mess_buff_b[0:2];   //��������洢����ͬһʱ�̣�һ�����һ��д
reg flag;

parameter N=8;             //�����ڵ���

assign resultmem_we = last_iteration?(cnt_v>0&&cnt_v<(N+1)):0;
assign resultmem_addr = last_iteration?(cnt_v-1):0;
assign srcmem_addr = last_iteration?0:cnt_v;
assign resultmem_dout = last_iteration?(!cnt_v[0]?limit(calc_b):limit(calc_a)):0;
//mess_mem����ַΪ(3*cnt+cycle),�������Ǵ���һ��ʱ�ӵ��ӳ٣���˼���1
assign mess_addra = flag?0:(cnt_v+cnt_v+cnt_v+cycle+1'd1);
//mess_mem����ַΪ(3*cnt+cycle-3),��(mess_addra-3'd4)
assign mess_addrb = mess_addra-3'd4;

assign mess_dout = last_iteration ? 0 :(!cnt_v[0]?(limit(calc_b-{mess_buff_b[cycle][7],mess_buff_b[cycle][7],mess_buff_b[cycle]}))
:(limit(calc_a-{mess_buff_a[cycle][7],mess_buff_a[cycle][7],mess_buff_a[cycle]})));

assign mess_web = !ce ? 0 : (!(cnt_v==0||cnt_v==(N+1)));
assign process_finish = !ce?0:(cnt_v==(N+1));

always @(posedge clk)
 begin
  if(cnp_on||!ce)
   begin
	 flag<=1;
	 cycle<=0;
	 cnt_v<=0;
	 calc_a<=0;
	 calc_b<=0;
	 mess_buff_a[0]<=0;
	 mess_buff_a[1]<=0;
	 mess_buff_a[2]<=0;
	 mess_buff_b[0]<=0;
	 mess_buff_b[1]<=0;
	 mess_buff_b[2]<=0;
	end
  else
   if(cnt_v==0&&flag==1)
	 begin
	  cnt_v<=0;
	  flag<=0;
	 end
	else
	 if(cnt_v==(N+1))
	  begin
	   cnt_v<=0;
		flag<=1;
	  end
	 else
	  case(cycle)
	   2'b00: begin
		        if(!cnt_v[0])
				   begin
					 calc_a<={mess_din[7],mess_din[7],mess_din};
					 mess_buff_a[0]<=mess_din;
					end
				  else
				   begin
					 calc_b<={mess_din[7],mess_din[7],mess_din};
					 mess_buff_b[0]<=mess_din;
					end
				  cycle<=cycle+1;
				 end
		2'b01: begin         //�ڵ�2�����ڼ��ŵ���Ϣ�ssrcmem _din
		        if(!cnt_v[0])
				   begin
					 calc_a<=calc_a+{mess_din[7],mess_din[7],mess_din}+{srcmem_din[7],srcmem_din[7],srcmem_din};
					 mess_buff_a[1]<=mess_din;
					end
				  else
				   begin
					 calc_b<=calc_b+{mess_din[7],mess_din[7],mess_din}+{srcmem_din[7],srcmem_din[7],srcmem_din};
					 mess_buff_b[1]<=mess_din;
					end
				  cycle<=cycle+1;
				 end
		2'b10: begin
		        if(!cnt_v[0])
				   begin
					 calc_a<=calc_a+{mess_din[7],mess_din[7],mess_din};
					 mess_buff_a[2]<=mess_din;
					 calc_b<=0;
					end
				  else
				   begin
					 calc_b<=calc_b+{mess_din[7],mess_din[7],mess_din};
					 mess_buff_b[2]<=mess_din;
					 calc_a<=0;
					end
				  cnt_v<=cnt_v+1;
				 end
		endcase
end

function [7:0] limit;       //���ݽضϺ���?0��ؽض��?����
 input[9:0] data;
 limit = data[9]?(!data[8]&&data[7]?8'b10000000:data[7:0]):(data[8]|data[7]?8'b01111111:data[7:0]);
endfunction

endmodule