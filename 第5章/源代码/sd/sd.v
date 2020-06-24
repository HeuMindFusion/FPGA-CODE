`timescale 1ns / 1ps


module sd(
    input x,
	 input clk,
	 input rst,
	 output y
    );
	 
 

 reg[2:0] state;    //状态寄存器
	 

parameter    IDLE = 3'd0,
	   
              A = 3'd1,
			
	      B = 3'd2,
	
	      C = 3'd3,

	      D = 3'd4,

	      E = 3'd5,

	      F = 3'd6,

	      G = 3'd7;

						 
 assign  y = (state==D&&x==0)?1:0;//状态为D时又收到了0，表明10010收到应有输出Y为高
	 

	
 always @(posedge clk or negedge rst)
	 
    if(!rst)

      begin
	
        state<=IDLE;
		
      end
			 

    else
 case(state)
			     
              IDLE:if(x==1)
			
	        state<=A;       //用状态变量记住高电平（x==1）来过
	
		    else
		
		 state<=IDLE;    //输入是低电平，不符合要求所以状态保留不变
			
	  A:   if(x==0)
				       
 state<=B;       //用状态变量记住第2位正确，低电平（x==0）来过
		
 else
					
	  state<=A;       //输入是高电平，不符合要求，状态保持不变
				  
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

