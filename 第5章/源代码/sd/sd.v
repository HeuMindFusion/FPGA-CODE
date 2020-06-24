`timescale 1ns / 1ps


module sd(
    input x,
	 input clk,
	 input rst,
	 output y
    );
	 
 

 reg[2:0] state;    //״̬�Ĵ���
	 

parameter    IDLE = 3'd0,
	   
              A = 3'd1,
			
	      B = 3'd2,
	
	      C = 3'd3,

	      D = 3'd4,

	      E = 3'd5,

	      F = 3'd6,

	      G = 3'd7;

						 
 assign  y = (state==D&&x==0)?1:0;//״̬ΪDʱ���յ���0������10010�յ�Ӧ�����YΪ��
	 

	
 always @(posedge clk or negedge rst)
	 
    if(!rst)

      begin
	
        state<=IDLE;
		
      end
			 

    else
 case(state)
			     
              IDLE:if(x==1)
			
	        state<=A;       //��״̬������ס�ߵ�ƽ��x==1������
	
		    else
		
		 state<=IDLE;    //�����ǵ͵�ƽ��������Ҫ������״̬��������
			
	  A:   if(x==0)
				       
 state<=B;       //��״̬������ס��2λ��ȷ���͵�ƽ��x==0������
		
 else
					
	  state<=A;       //�����Ǹߵ�ƽ��������Ҫ��״̬���ֲ���
				  
B:   if(x==0)
				       
 state<=C;
						
 else
						
  state<=F;
				 
 C:   if(x==1)
				       
 state<=D;
						
 else
						  
state<=G;
				
  D:   if(x==0)
				        
state<=E;
						 
else
						
  state<=A;
				 
 E:   if(x==0)
				     
   state<=C;
						
 else
						 
 state<=A;
				
  F:   if(x==1)
                  
  state<=A;
                  
 else
                   
 state<=B;
             
 G:   if(x==1)
                   
 state<=F;
                  
 else
                    
state<=B;
						  
      
  default: state<=IDLE;						  
		
endcase
endmodule

