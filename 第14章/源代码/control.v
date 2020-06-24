`timescale 1ns / 1ps

module control(
    input ce,                //1��ʼ������0��ʼ����
	 input vnp_f,             //vnp�������
	 input cnp_f,             //cnp�������
	 output reg cnp_on,
	 output last_iteration,
    output reg over              //�ߵ�ƽ��ʾ���в������
    );
reg[6:0] inter_num;             //��������
wire var;

parameter  max_inter_num = 10;  //����������

assign var = vnp_f|cnp_f;       //cnp_f��vnp_f��������״̬�仯
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
