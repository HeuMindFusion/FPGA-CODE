`timescale 1ns / 1ps
/
module path(
   input clk,
	input rst,
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
   //output[29:0] path_survive,         //幸存路径的路径度量值
   output[3:0] c_survive,	            //幸存路径的输出码字
	output path_end
    );
reg[29:0] path1;                      //16个路径的值
reg[29:0] path2;	 
reg[29:0] path3;	 
reg[29:0] path4;	 
reg[29:0] path5;	 
reg[29:0] path6;	 
reg[29:0] path7;	 
reg[29:0] path8;	 
reg[29:0] path9;	 
reg[29:0] path10;	 
reg[29:0] path11;	 
reg[29:0] path12;	 
reg[29:0] path13;	 
reg[29:0] path14;	 
reg[29:0] path15;	 
reg[29:0] path16;
reg[29:0] path_temp;
//reg[29:0] path_best;
reg best_start;	 
reg[3:0] c;
reg[3:0] c_last;
reg[4:0] cnt_best;
reg path_over;

//assign path_survive = path_best;
assign c_survive = c_last;
assign path_end = path_over;

always @(posedge clk)
begin
if(!rst)
 begin
  path1<=0;
  path2<=0;
  path3<=0;
  path4<=0;
  path5<=0;
  path6<=0;
  path7<=0;
  path8<=0;
  path9<=0;
  path10<=0;
  path11<=0;
  path12<=0;
  path13<=0;
  path14<=0;
  path15<=0;
  path16<=0;
  best_start<=0;
 end
else
 begin
 path1<=v_1+v_3+v_7+v_11;             //计算16个支路的路径度量
 path2<=v_1+v_3+v_7+v_13; 
 path3<=v_1+v_3+v_9+v_14; 
 path4<=v_1+v_3+v_9+v_12; 
 path5<=v_1+v_5+v_10+v_14; 
 path6<=v_1+v_5+v_10+v_12; 
 path7<=v_1+v_5+v_8+v_11; 
 path8<=v_1+v_5+v_8+v_13; 
 path9<=v_2+v_6+v_10+v_14; 
 path10<=v_2+v_6+v_10+v_12; 
 path11<=v_2+v_6+v_8+v_11; 
 path12<=v_2+v_6+v_8+v_13; 
 path13<=v_2+v_4+v_7+v_11; 
 path14<=v_2+v_4+v_7+v_13;
 path15<=v_2+v_4+v_9+v_14;
 path16<=v_2+v_4+v_9+v_12;
 best_start<=1;
end 
end

always @(posedge clk)                   //比较计算出最小路径度量值
begin
 if(!best_start)
  begin
   path_temp<=0;
	//path_best<=0;
	cnt_best<=0;
	c<=0;
	c_last<=0;
	path_over<=0;
  end
 else
  begin
	case(cnt_best)
	 0: begin
	     if(path1>path2)
		  begin
		   path_temp<=path2;
			c<=4'b0001;
		  end
		  else
		  begin
		   path_temp<=path1;
			c<=4'b0000;
		  end
		  cnt_best<=cnt_best+1;
		end
	1: begin
	    if(path_temp>path3)
		  begin
		  path_temp<=path3;
		  c<=4'b0010;
		  end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	2: begin
	    if(path_temp>path4)
		 begin
		  path_temp<=path4;
		  c<=4'b0011;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	3: begin
	    if(path_temp>path5)
		 begin
		  path_temp<=path5;
		  c<=4'b0100;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	4: begin
	    if(path_temp>path6)
		 begin
		  path_temp<=path6;
		  c<=4'b0101;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	5: begin
	    if(path_temp>path7)
		 begin
		  path_temp<=path7;
		  c<=4'b0110;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	6: begin
	    if(path_temp>path8)
		 begin
		  path_temp<=path8;
		  c<=4'b0111;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	7: begin
	    if(path_temp>path9)
		 begin
		  path_temp<=path9;
		  c<=4'b1000;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
	8: begin
	    if(path_temp>path10)
		 begin
		  path_temp<=path10;
		  c<=4'b1001;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
   9: begin
	    if(path_temp>path11)
		 begin
		  path_temp<=path11;
		  c<=4'b1010;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  10: begin
	    if(path_temp>path12)
		 begin
		  path_temp<=path12;
		  c<=4'b1011;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  11: begin
	    if(path_temp>path13)
		 begin
		  path_temp<=path13;
		  c<=4'b1100;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  12: begin
	    if(path_temp>path14)
		 begin
		  path_temp<=path14;
		  c<=4'b1101;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  13: begin
	    if(path_temp>path15)
		 begin
		  path_temp<=path15;
		  c<=4'b1110;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  14: begin
	    if(path_temp>path16)
		 begin
		  path_temp<=path16;
		  c<=4'b1111;
		 end
		 else
		 begin
		  path_temp<=path_temp;
		  c<=c;
		 end
		 cnt_best<=cnt_best+1;
		end
  15:begin
      //path_best<=path_temp;             //输出幸存路径值
		c_last<=c;
		path_over<=1;
		cnt_best<=16;
	  end
  endcase
 end
end

endmodule
