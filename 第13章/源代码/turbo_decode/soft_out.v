`timescale 1ns / 1ps


module soft_out(
   input clk,
	input rst,
	input[3:0] c_survive,
	input[29:0] v_1, 
	input[29:0] v_2, 
	input[29:0] v_3, 
	input[29:0] v_4, 
	input[29:0] v_5, 
	input[29:0] v_6, 
	input[29:0] v_7, 
	input[29:0] v_8, 
	input[29:0] v_9, 
	input[29:0] v_10, 
	input[29:0] v_11, 
	input[29:0] v_12, 
	input[29:0] v_13, 
	input[29:0] v_14,
	output[30:0] soft_out1,
	output[30:0] soft_out2,
	output[30:0] soft_out3,
	output[30:0] soft_out4
    );
reg[29:0] t2_0;                          //����ڵ�Ϊ2ʱֵΪ0�����·��
reg[29:0] t2_1;
reg[29:0] t3_0;
reg[29:0] t3_1;
reg[29:0] t4_0;
reg[29:0] t4_1;
reg[29:0] t1_compete1;                   //����·��1����tʱ��ȫ��Ϊ0��·��
reg[29:0] t1_compete2;                   //����·��2����tʱ��ȫ��Ϊ1��·��
reg[29:0] t2_compete1;
reg[29:0] t2_compete2;
reg[29:0] t3_compete1;
reg[29:0] t3_compete2;
reg[29:0] t4_compete1;
reg[29:0] t4_compete2;
reg[29:0] u10;                            //t1ʱ�̾���·���Ķ���
reg[29:0] u11;                            //t1ʱ���Ҵ�·���Ķ���
reg[29:0] u20;
reg[29:0] u21;
reg[29:0] u30;
reg[29:0] u31;
reg[29:0] u40;
reg[29:0] u41;
reg[29:0] t2_t1;
reg[29:0] t2_t2;
reg[29:0] t2_t3;
reg[29:0] t2_t4;
reg[29:0] t3_t1;
reg[29:0] t3_t2;
reg[29:0] t3_t3;
reg[29:0] t3_t4;
reg[29:0] t4_t1;
reg[29:0] t4_t2;
reg[29:0] t4_t3;
reg[29:0] t4_t4;

reg[4:0] cnt_r;
reg[2:0] cnt_lu;
reg[3:0] cnt_soft;
reg ready;
reg mr;
reg m_compete1;                   //������Ԫ
reg m_compete2; 
reg m_compete3; 
reg m_compete4; 

reg[30:0] soft1;
reg[30:0] soft2;
reg[30:0] soft3;
reg[30:0] soft4;
assign soft_out1 = soft1;
assign soft_out2 = soft2;
assign soft_out3 = soft3;
assign soft_out4 = soft4;

//-----------------------------Ϊ��������Ϣ��ǰ��׼������
always @(posedge clk)
begin
 if(!rst)
  begin
   t2_0<=0;
   t2_1<=0;
   t3_0<=0;
   t3_1<=0;
   t4_0<=0;
   t4_1<=0;
	u11<=0;
	u21<=0;
	u31<=0;
	u41<=0;
	cnt_r<=0;
	ready<=0;
  end
 else
  begin
	case(cnt_r)
	 0: begin
	     if(v_1>v_2)
		   begin
			 u11<=v_2;
			end
		  else
		   begin
			 u11<=v_1;
			end
			cnt_r<=cnt_r+1;
		end
	1: begin                  //t2Ϊ0ֵʱ�����·��
	     t2_t1<=v_1+v_3;
		  t2_t2<=v_2+v_4;
		  cnt_r<=cnt_r+1;
		end
	2: begin
	    if(t2_t1>t2_t2)
		   begin
			 t2_0<=t2_t2;
			end
		  else
		   begin
			 t2_0<=t2_t1;
			end
			cnt_r<=cnt_r+1;
		end
	3: begin               //t2Ϊ1ֵʱ�����·��
	    t2_t3<=v_1+v_5;
		 t2_t4<=v_2+v_6;
		 cnt_r<=cnt_r+1;
		end
	4: begin
	    if(t2_t3>t2_t4)
		  begin
		   t2_1<=t2_t4;
		  end
		 else
		  begin
		   t2_1<=t2_t3;
		  end
		  cnt_r<=cnt_r+1;
		end
	5: begin              //���㵽t2���Ҵ�·��
	    if(t2_0>t2_1)
		  begin
		   u21<=t2_1;
		  end
		 else
		  begin
		   u21<=t2_0;
		  end
		  cnt_r<=cnt_r+1;
	   end
	6: begin                //t3Ϊ0,���õ�t2ʱ�̵����ֵ������
	    t3_t1<=t2_0+v_7;
		 t3_t2<=t2_1+v_8;
		 cnt_r<=cnt_r+1;
		end
	7: begin
	    if(t3_t1>t3_t2)
		  begin
		   t3_0<=t3_t2;
		  end
		 else
		  begin
		   t3_0<=t3_t1;
		  end
		  cnt_r<=cnt_r+1;
		end
	8: begin                //t3Ϊ1
	    t3_t3<=t2_0+v_9;
		 t3_t4<=t2_1+v_10;
		 cnt_r<=cnt_r+1;
		end
	9: begin
	     if(t3_t3>t3_t4)
		  begin
		   t3_1<=t3_t4;
		  end
		 else
		  begin
		   t3_1<=t3_t3;
		  end
		  cnt_r<=cnt_r+1;
		end
  10: begin                    //���㵽t3���Ҵ�·��
	    if(t3_0>t3_1)
		  begin
		   u31<=t3_1;
		  end
		 else
		  begin
		   u31<=t3_0;
		  end
		  cnt_r<=cnt_r+1;
		end
  11: begin
	    t4_t1<=t3_0+v_11;
	    t4_t2<=t3_1+v_12;
		 cnt_r<=cnt_r+1;
		end
  12: begin
       if(t4_t1>t4_t2)
		  begin
		   t4_0<=t4_t2;
		  end
		 else
		  begin
		   t4_0<=t4_t1;
		  end
		  cnt_r<=cnt_r+1;
		end
  13: begin
	    t4_t3<=t3_0+v_13;
	    t4_t4<=t3_1+v_14;
		 cnt_r<=cnt_r+1;
		end
  14: begin
       if(t4_t3>t4_t4)
		  begin
		   t4_1<=t4_t4;
		  end
		 else
		  begin
		   t4_1<=t4_t3;
		  end
		  cnt_r<=cnt_r+1;
		end
	15: begin
	    if(t4_0>t4_1)
		  begin
		   u41<=t4_1;
			ready<=1;
		  end
		 else
		  begin
		   u41<=t4_0;
			ready<=1;
		  end
		  cnt_r<=16;
	   end
	endcase
  end
end

//-----------------------------���㾺��·������ֵ
always @(posedge clk)
begin
 if(!ready)
  begin
   cnt_lu<=0;
	t1_compete1<=0;
	t1_compete2<=0;
	t2_compete1<=0;
	t2_compete2<=0;
	t3_compete1<=0;
	t3_compete2<=0;
	t4_compete1<=0;
	t4_compete2<=0;
	mr<=0;
  end
 else
  begin
	case(cnt_lu)
	 0: begin
	     if(c_survive[0]==1)             //t=1ʱ���Ҵ���ԪΪ1 
		   begin
		    m_compete1<=0;                   //������ԪΪ0
			 t1_compete1<=v_1+v_3;
			 t1_compete2<=v_2+v_4;
			end
		  else
		   begin                          //t=1ʱ���Ҵ���ԪΪ0
			 m_compete1<=1;                  //������ԪΪ1
			 t1_compete1<=v_2+v_4;
			 t1_compete2<=v_1+v_3;
			end
			cnt_lu<=cnt_lu+1;
		end
	1: begin
	    if(c_survive[1]==1)
		  begin
		   m_compete2<=0;
			t2_compete1<=v_1+v_3+v_7;
			t2_compete2<=v_2+v_6+v_8;
		  end
		 else
		  begin
		   m_compete2<=1;
			t2_compete1<=v_2+v_6+v_8;
			t2_compete2<=v_1+v_3+v_7;
		  end
		  cnt_lu<=cnt_lu+1;
		end
	2: begin
	    if(c_survive[2]==1)
		  begin
		   m_compete3<=0;
			t3_compete1<=t2_0+v_7+v_11;
			t3_compete2<=t2_1+v_10+v_12;
		  end
		 else
		  begin
		   m_compete3<=1;
			t3_compete1<=t2_1+v_10+v_12;
			t3_compete2<=t2_0+v_7+v_11;
		  end
		  cnt_lu<=cnt_lu+1;
		end
	3: begin
	    if(c_survive[3]==1)
		  begin
		   m_compete4<=0;
			t4_compete1<=t3_0+v_13;
			t4_compete2<=t3_1+v_14;
			mr<=1;
		  end
		 else
		  begin
		   m_compete4<=1;
			t4_compete1<=t3_1+v_14;
			t4_compete2<=t3_0+v_13;
			mr<=1;
		  end
		  cnt_lu<=4;
		end
	endcase
  end
end
//----------------------��ʼ���������Ȼ����
always @(posedge clk)
 begin
  if(!mr)
   begin
	 cnt_soft<=0;
	 u10<=0;
	 u20<=0;
	 u30<=0;
	 u40<=0;
	 soft1<=0;
	 soft2<=0;
	 soft3<=0;
	 soft4<=0;
	end
  else
   begin
	case(cnt_soft)
	0: begin
	    if(t1_compete1>t1_compete2)   //ѡ����·����Сֵ
	     begin
	      u10<=t1_compete2;
		  end
		 else
		  begin
		   u10<=t1_compete1;
		  end
		  cnt_soft<=cnt_soft+1;
		end
	1: begin
	     if(m_compete1==0)              //������ԪΪ0�����Ҵ���ԪΪ1
		   begin
			 if(u10>u11)
			   begin
				 soft1[30]<=0;              //��30λ��Ϊ������־λ��1Ϊ����0Ϊ��
		       soft1[29:0]<=u10-u11;
				end
			  else
			   begin
				soft1[30]<=1;
				soft1[29:0]<=u11-u10;       //���ź󣬼��������Ӧ��Ϊ��
			   end
	      end
		  else
		   begin
			 if(u10>u11)
			   begin
				 soft1[30]<=1;
		       soft1[29:0]<=u10-u11;
				end
			  else
			   begin
				soft1[30]<=0;
				soft1[29:0]<=u11-u10;
			   end
			end
		  cnt_soft<=cnt_soft+1;
		end
	2: begin
	    if(t2_compete1>t2_compete2)
		  begin
		   u20<=t2_compete2;
		  end
		 else
		  begin
		   u20<=t2_compete1;
		  end
		 cnt_soft<=cnt_soft+1;
		end
	3: begin
	    if(m_compete2==0)
		  begin
		   if(u20>u21)
			   begin
				 soft2[30]<=0;
		       soft2[29:0]<=u20-u21;
				end
			  else
			   begin
				soft2[30]<=1;
				soft2[29:0]<=u21-u20;
			   end
		  end
		 else
		  begin
		   if(u20>u21)
			   begin
				 soft2[30]<=1;
		       soft2[29:0]<=u20-u21;
				end
			  else
			   begin
				soft2[30]<=0;
				soft2[29:0]<=u21-u20;
			   end
		  end
		  cnt_soft<=cnt_soft+1;
		end
	4: begin
	    if(t3_compete1>t3_compete2)
		  begin
		   u30<=t3_compete2;
		  end
		 else
		  begin
		   u30<=t3_compete1;
		  end
		  cnt_soft<=cnt_soft+1;
		end
	5: begin
	    if(m_compete3==0)
		  begin
		   if(u30>u31)
			   begin
				 soft3[30]<=0;
		       soft3[29:0]<=u30-u31;
				end
			  else
			   begin
				soft3[30]<=1;
				soft3[29:0]<=u31-u30;
			   end
		  end
		 else
		  begin
		   if(u30>u31)
			   begin
				 soft3[30]<=1;
		       soft3[29:0]<=u30-u31;
				end
			  else
			   begin
				soft3[30]<=0;
				soft3[29:0]<=u31-u30;
			   end
		  end
		 cnt_soft<=cnt_soft+1;
		end
	6: begin
	    if(t4_compete1>t4_compete2)
		  begin
		   u40<=t4_compete2;
		  end
		 else
		  begin
		   u40<=t4_compete1;
		  end
		 cnt_soft<=cnt_soft+1;
		end
	7: begin
	    if(m_compete4==0)
		  begin
		   if(u40>u41)
			   begin
				 soft4[30]<=0;
		       soft4[29:0]<=u40-u41;
				end
			  else
			   begin
				soft4[30]<=1;
				soft4[29:0]<=u41-u40;
			   end
		  end
		 else
		  begin
		   if(u40>u41)
			   begin
				 soft4[30]<=1;
		       soft4[29:0]<=u40-u41;
				end
			  else
			   begin
				soft4[30]<=0;
				soft4[29:0]<=u41-u40;
			   end
		  end
		 cnt_soft<=8;
		end
	endcase
  end
end
	 
endmodule
