`timescale 1ns / 1ps
/

module survive2(
    input clk,
	 input rst,
	 input[15:0] m11,                    //分支1的第一个信息
	 input[15:0] m21,
	 input[15:0] m31,
	 input[15:0] m41,
	 input[15:0] m12,                   //分支1的第二个信息
	 input[15:0] m22,
	 input[15:0] m32,
	 input[15:0] m42,
	 output[29:0] v_1, 
	 output[29:0] v_2, 
	 output[29:0] v_3, 
	 output[29:0] v_4, 
	 output[29:0] v_5, 
	 output[29:0] v_6, 
	 output[29:0] v_7, 
	 output[29:0] v_8, 
	 output[29:0] v_9, 
	 output[29:0] v_10, 
	 output[29:0] v_11, 
	 output[29:0] v_12, 
	 output[29:0] v_13, 
	 output[29:0] v_14,
    output sur_end	 
    );
reg[29:0] v1;               //14个分支的欧氏距离存储器
reg[29:0] v2;
reg[29:0] v3;
reg[29:0] v4;
reg[29:0] v5;
reg[29:0] v6;
reg[29:0] v7;
reg[29:0] v8;
reg[29:0] v9;
reg[29:0] v10;
reg[29:0] v11;
reg[29:0] v12;
reg[29:0] v13;
reg[29:0] v14;

assign v_1 = v1;
assign v_2 = v2;
assign v_3 = v3;
assign v_4 = v4;
assign v_5 = v5;
assign v_6 = v6;
assign v_7 = v7;
assign v_8 = v8;
assign v_9 = v9;
assign v_10 = v10;
assign v_11 = v11;
assign v_12 = v12;
assign v_13 = v13;
assign v_14 = v14;

reg[14:0] zheng11;            //m1数据整数小数分离后，计算欧氏距离中存储每个分支的整数计算部分
reg[14:0] zheng21;
reg[14:0] zheng31;
reg[14:0] zheng41;
reg[14:0] zheng51;
reg[14:0] zheng61;
reg[14:0] zheng71;
reg[14:0] zheng81;
reg[14:0] zheng91;
reg[14:0] zheng101;
reg[14:0] zheng111;
reg[14:0] zheng121;
reg[14:0] zheng131;
reg[14:0] zheng141;

reg[14:0] zheng12;            //m2数据整数小数分离后，计算欧氏距离中存储每个分支的整数计算部分
reg[14:0] zheng22;
reg[14:0] zheng32;
reg[14:0] zheng42;
reg[14:0] zheng52;
reg[14:0] zheng62;
reg[14:0] zheng72;
reg[14:0] zheng82;
reg[14:0] zheng92;
reg[14:0] zheng102;
reg[14:0] zheng112;
reg[14:0] zheng122;
reg[14:0] zheng132;
reg[14:0] zheng142;

reg[14:0] xiao11;            //m1数据整数小数分离后，计算欧氏距离中存储每个种У
reg[14:0] xiao21;
reg[14:0] xiao31;
reg[14:0] xiao41;
reg[14:0] xiao51;
reg[14:0] xiao61;
reg[14:0] xiao71;
reg[14:0] xiao81;
reg[14:0] xiao91;
reg[14:0] xiao101;
reg[14:0] xiao111;
reg[14:0] xiao121;
reg[14:0] xiao131;
reg[14:0] xiao141;

reg[14:0] xiao12;            //m2数据整数小数分离后，计算欧氏距离中存储每个分支
reg[14:0] xiao22;
reg[14:0] xiao32;
reg[14:0] xiao42;
reg[14:0] xiao52;
reg[14:0] xiao62;
reg[14:0] xiao72;
reg[14:0] xiao82;
reg[14:0] xiao92;
reg[14:0] xiao102;
reg[14:0] xiao112;
reg[14:0] xiao122;
reg[14:0] xiao132;
reg[14:0] xiao142;

reg[14:0] he11;                //m1计算分支欧氏距离整数和小数的和计算
reg[14:0] he21;
reg[14:0] he31;
reg[14:0] he41;
reg[14:0] he51;
reg[14:0] he61;
reg[14:0] he71;
reg[14:0] he81;
reg[14:0] he91;
reg[14:0] he101;
reg[14:0] he111;
reg[14:0] he121;
reg[14:0] he131;
reg[14:0] he141;

reg[29:0] temp11;            //he1的平方值
reg[29:0] temp21;
reg[29:0] temp31;
reg[29:0] temp41;
reg[29:0] temp51;
reg[29:0] temp61;
reg[29:0] temp71;
reg[29:0] temp81;
reg[29:0] temp91;
reg[29:0] temp101;
reg[29:0] temp111;
reg[29:0] temp121;
reg[29:0] temp131;
reg[29:0] temp141;

reg[14:0] he12;              //m2计算分支欧氏距离整数和小数的和计算
reg[14:0] he22;
reg[14:0] he32;
reg[14:0] he42;
reg[14:0] he52;
reg[14:0] he62;
reg[14:0] he72;
reg[14:0] he82;
reg[14:0] he92;
reg[14:0] he102;
reg[14:0] he112;
reg[14:0] he122;
reg[14:0] he132;
reg[14:0] he142;

reg[29:0] temp12;           //he2的
reg[29:0] temp22;
reg[29:0] temp32;
reg[29:0] temp42;
reg[29:0] temp52;
reg[29:0] temp62;
reg[29:0] temp72;
reg[29:0] temp82;
reg[29:0] temp92;
reg[29:0] temp102;
reg[29:0] temp112;
reg[29:0] temp122;
reg[29:0] temp132;
reg[29:0] temp142;

reg[1:0] cnt;
reg[14:0] z11;             //m1提取出来的整数部分
reg[14:0] z21;
reg[14:0] z31;
reg[14:0] z41;
reg[14:0] z12;
reg[14:0] z22;
reg[14:0] z32;
reg[14:0] z42;
reg[14:0] x11;             //m1提取出来的小数部分
reg[14:0] x21;
reg[14:0] x31;
reg[14:0] x41;
reg[14:0] x12;
reg[14:0] x22;
reg[14:0] x32;
reg[14:0] x42;

reg[14:0] yu11;            //整数小数分离时计算所需的余数
reg[14:0] yu21;
reg[14:0] yu31;
reg[14:0] yu41;
reg[14:0] yu12;
reg[14:0] yu22;
reg[14:0] yu32;
reg[14:0] yu42;
reg finish;                   //输入数据整数小数分离完成，接着开始计算各分支的欧式距
reg sur_over;

assign sur_end = sur_over;

//----------------------------------------------------------------------------------
 
always @(posedge clk)          //把输入进来闹到整数和小数的分离
begin
 if(!rst)
  begin
   z11<=0;
   z21<=0;
   z31<=0;
   z41<=0;
	z12<=0;
	z22<=0;
	z32<=0;
	z42<=0;
	x11<=0;
   x21<=0;
   x31<=0;
   x41<=0;
	x12<=0;
	x22<=0;
	x32<=0;
	x42<=0;
   yu11<=m11;
   yu21<=m21;
   yu31<=m31;
   yu41<=m41;
	yu12<=m12;
	yu22<=m22;
	yu32<=m32;
	yu42<=m42;
	finish<=0;
  end
 else
  begin
	if(m11<100)                  //m11如果只有小数部分
	 begin
	  z11<=0;
	  x11<=m11;
	 end
	else                       //有整数部分
	 begin
	  if(yu11<100)               //提取小数部分
	   begin
		 z11<=m11-yu11;         //提取整数	 
		 x11<=yu11;
		 finish<=1;
		end
	  else
	   begin
		 yu11<=yu11-100;
		end
	end
	
	if(m21<100)                  //m21如果只有小数部分
	 begin
	  z21<=0;
	  x21<=m21;
	 end
	else                       //有整数部分
	 begin
	  if(yu21<100)               //提取小数部分
	   begin
		 z21<=m21-yu21;         //提取整数部分
		 x21<=yu21;
		end
	  else
	   begin
		 yu21<=yu21-100;
		end
	end
	
	if(m31<100)                  //m31如果只有小数部分
	 begin
	  z31<=0;
	  x31<=m31;
	 end
	else                       //有整数部分
	 begin
	  if(yu31<100)               //提取小数部分
	   begin
		 z31<=m31-yu31;         //提取整数部分
		 x31<=yu31;
		end
	  else
	   begin
		 yu31<=yu31-100;
		end
	end
	
	if(m41<100)                  //m41如果只有小数部分
	 begin
	  z41<=0;
	  x41<=m41;
	 end
	else                       //有整数部分
	 begin
	  if(yu41<100)               //提取小数部分
	   begin
		 z41<=m41-yu41;         //提取整数部分
		 x41<=yu41;
		end
	  else
	   begin
		 yu41<=yu41-100;
		end
	end                                                  //一帧中m1的4个数计算完毕
//---------------------------------------------------------------------------------	
	if(m12<100)                  //m12如果只有小数
	begin
	  z12<=0;
	  x12<=m12;
	 end
	else                       //有整数部分
	 begin
	  if(yu12<100)               //提取小数部分
	   begin
		 z12<=m12-yu12;         //提取整数部分
		 x12<=yu12;
		end
	  else
	   begin
		 yu12<=yu12-100;
		end
	end
	
	if(m22<100)                  //m22如果只有小数部分
	 begin
	  z22<=0;
	  x22<=m22;
	 end
	else                       //有整数部?	 
	begin
	  if(yu22<100)               //提取小数部分
	   begin
		 z22<=m22-yu22;         //提取整数部分
		 x22<=yu22;
		end
	  else
	   begin
		 yu22<=yu22-100;
		end
	end
	
	if(m32<100)                  //m32如果只有小数部分
	 begin
	  z32<=0;
	  x32<=m32;
	 end
	else                       //有整数部分
	 begin
	  if(yu32<100)               //提取小数部分
	   begin
		 z32<=m32-yu32;         //提取整数部分
		 x32<=yu32;
		end
	  else
	   begin
		 yu32<=yu32-100;
		end
	end
	
	if(m42<100)                  //m42如果只有小数部分
	 begin
	  z42<=0;
	  x42<=m42;
	 end
	else                       //有整数部分
	 begin
	  if(yu42<100)   
	  begin
		 z42<=m42-yu42;         //提取整数		 
		 x42<=yu42;
		end
	  else
	   begin
		 yu42<=yu42-100;
		end
	end
 end
end
//------------------------------------------------------------------
//------------------------------------------------------------------
always @(posedge clk)               //计算各分支欧式距离
begin
 if(!finish)
  begin
   cnt<=0;
	sur_over<=0;
  end
 else
  begin
   cnt<=cnt+1;
	case(cnt)
	      0: begin                                //从t0开始的最初两个路?			    
			    if(m11[15]==1)                       //16位中，最高位为正负标志位，1为负，0为正
				  begin
				   if(z11>1)                      //整数位有值 
					 begin
				     zheng11<=z11-100;
					  zheng21<=z11+100;
					  xiao11<=x11;
					  xiao21<=x11;
					 end
					else                              //整数位没有数，即-0.x的值
					 begin
					  zheng11<=0;
					  zheng21<=z11+100;
					  xiao11<=100-x11;
					  xiao21<=x11;
					 end
					he11<=zheng11+xiao11;
					he21<=zheng21+xiao21;
					temp11<=he11*he11;
					temp21<=he21*he21;
				  end
				 else                                //正数
				  begin
				   if(z11>1)                    //整数位有值
					 begin
				     zheng11<=z11+100;
					  zheng21<=z11-100;
				     xiao11<=x11;
					  xiao21<=x11;
					 end
					else                              //整数位没有值
					 begin
					  zheng11<=z11+100;
					  zheng21<=0;
					  xiao11<=x11;
					  xiao21<=100-x11;
					 end
					  he11<=zheng11+xiao11;
					  he21<=zheng21+xiao21;
					  temp11<=he11*he11;
					  temp21<=he21*he21;
				  end
				  //m2同上计算方法
				 if(m12[15]==1)
				  begin
				   if(z12>1)
					 begin
				     zheng12<=z12-100;
					  zheng22<=z12+100;
					  xiao12<=x12;
					  xiao22<=x12;
					 end
					else
					 begin
					  zheng12<=0;
					  zheng22<=z12+100;
					  xiao12<=100-x12;
					  xiao22<=x12;
					 end
					he12<=zheng12+xiao12;
					he22<=zheng22+xiao22;
					temp12<=he12*he12;
					temp22<=he22*he22;
				  end
				 else
				  begin
				   if(z12>1)
					 begin
				     zheng12<=z12+100;
					  zheng22<=z12-100;
				     xiao12<=x12;
					  xiao22<=x12;
					 end
					else
					 begin
					  zheng12<=z12+100;
					  zheng22<=0;
					  xiao12<=x12;
					  xiao22<=100-x12;
					 end
					  he12<=zheng12+xiao12;
					  he22<=zheng22+xiao22;
					  temp12<=he12*he12;
					  temp22<=he22*he22;
				  end
				  v1<=temp11+temp12;                          //写入分支欧氏距离寄存器里面
				  v2<=temp21+temp22;
				  //cnt<=cnt+1;
			   end
                                                          //进第二个数据
			1: begin
			    if(m21[15]==1)
				  begin
				   if(z21>1)
					 begin
				     zheng31<=z21-100;
					  zheng41<=z21+100;
					  zheng51<=z21+100;
					  zheng61<=z21-100;
					  xiao31<=x21;
					  xiao41<=x21;
					  xiao51<=x21;
					  xiao61<=x21;
					 end
					else
					 begin
					  zheng31<=0;
					  zheng41<=z21+100;
					  zheng51<=z21+100;
					  zheng61<=0;
					  xiao31<=100-x21;
					  xiao41<=x21;
					  xiao51<=x21;
					  xiao61<=100-x21;
					 end
					he31<=zheng31+xiao31;
					he41<=zheng41+xiao41;
					he51<=zheng51+xiao51;
					he61<=zheng61+xiao61;
					temp31<=he31*he31;
					temp41<=he41*he41;
					temp51<=he51*he51;
					temp61<=he61*he61;
				  end
				 else
				  begin
				   if(z21>1)
					 begin
				     zheng31<=z21+100;
					  zheng41<=z21-100;
					  zheng51<=z21-100;
					  zheng61<=z21+100;
				     xiao31<=x21;
					  xiao41<=x21;
					  xiao51<=x21;
					  xiao61<=x21;
					 end
					else
					 begin
					  zheng31<=z21+100;
					  zheng41<=0;
					  zheng51<=0;
					  zheng61<=z21+100;
					  xiao31<=x21;
					  xiao41<=100-x21;
					  xiao51<=100-x21;
					  xiao61<=x21;
					 end
					  he31<=zheng31+xiao31;
					  he41<=zheng41+xiao41;
					  he51<=zheng51+xiao51;
					  he61<=zheng61+xiao61;
					  temp31<=he31*he31;
					  temp41<=he41*he41;
					  temp51<=he51*he51;
					  temp61<=he61*he61;
				  end
				                                               //m2的计算
			if(m22[15]==1)
				  begin
				   if(z22>1)
					 begin
				     zheng32<=z22-100;
					  zheng42<=z22-100;
					  zheng52<=z22+100;
					  zheng62<=z22+100;
					  xiao32<=x22;
					  xiao42<=x22;
					  xiao52<=x22;
					  xiao62<=x22;
					 end
					else
					 begin
					  zheng32<=0;
					  zheng42<=0;
					  zheng52<=z22+100;
					  zheng62<=z22+100;
					  xiao32<=100-x22;
					  xiao42<=100-x22;
					  xiao52<=x22;
					  xiao62<=x22;
					 end
					he32<=zheng32+xiao32;
					he42<=zheng42+xiao42;
					he52<=zheng52+xiao52;
					he62<=zheng62+xiao62;
					temp32<=he32*he32;
					temp42<=he42*he42;
					temp52<=he52*he52;
					temp62<=he62*he62;
				  end
				 else
				  begin
				   if(z22>1)
					 begin
				     zheng32<=z22+100;
					  zheng42<=z22+100;
					  zheng52<=z22-100;
					  zheng62<=z22-100;
				     xiao32<=x22;
					  xiao42<=x22;
					  xiao52<=x22;
					  xiao62<=x22;
					 end
					else
					 begin
					  zheng32<=z22+100;
					  zheng42<=z22+100;
					  zheng52<=0;
					  zheng62<=0;
					  xiao32<=x22;
					  xiao42<=x22;
					  xiao52<=100-x22;
					  xiao62<=100-x22;
					 end
					  he32<=zheng32+xiao32;
					  he42<=zheng42+xiao42;
					  he52<=zheng52+xiao52;
					  he62<=zheng62+xiao62;
					  temp32<=he32*he32;
					  temp42<=he42*he42;
					  temp52<=he52*he52;
					  temp62<=he62*he62;
				  end
				  v3<=temp31+temp32;
				  v4<=temp41+temp42;
				  v5<=temp51+temp52;
				  v6<=temp61+temp62;
				  //cnt<=cnt+1;
				end
			2: begin
			    if(m31[15]==1)
				  begin
				   if(z31>1)
					 begin
				     zheng71<=z31-100;
					  zheng81<=z31+100;
					  zheng91<=z31+100;
					  zheng101<=z31-100;
					  xiao71<=x31;
					  xiao81<=x31;
					  xiao91<=x31;
					  xiao101<=x31;
					 end
					else
					 begin
					  zheng71<=0;
					  zheng81<=z31+100;
					  zheng91<=z31+100;
					  zheng101<=0;
					  xiao71<=100-x31;
					  xiao81<=x31;
					  xiao91<=x31;
					  xiao101<=100-x31;
					 end
					he71<=zheng71+xiao71;
					he81<=zheng81+xiao81;
					he91<=zheng91+xiao91;
					he101<=zheng101+xiao101;
					temp71<=he71*he71;
					temp81<=he81*he81;
					temp91<=he91*he91;
					temp101<=he101*he101;
				  end
				 else
				  begin
				   if(z31>1)
					 begin
				     zheng71<=z31+100;
					  zheng81<=z31-100;
					  zheng91<=z31-100;
					  zheng101<=z31+100;
				     xiao71<=x31;
					  xiao81<=x31;
					  xiao91<=x31;
					  xiao101<=x31;
					 end
					else
					 begin
					  zheng71<=z31+100;
					  zheng81<=0;
					  zheng91<=0;
					  zheng101<=z31+100;
					  xiao71<=x31;
					  xiao81<=100-x31;
					  xiao91<=100-x31;
					  xiao101<=x31;
					 end
					  he71<=zheng71+xiao71;
					  he81<=zheng81+xiao81;
					  he91<=zheng91+xiao91;
					  he101<=zheng101+xiao101;
					  temp71<=he71*he71;
					  temp81<=he81*he81;
					  temp91<=he91*he91;
					  temp101<=he101*he101;
				  end
				                                               //m2的计算
			if(m32[15]==1)
				  begin
				   if(z32>1)
					 begin
				     zheng72<=z32-100;
					  zheng82<=z32-100;
					  zheng92<=z32+100;
					  zheng102<=z32+100;
					  xiao72<=x32;
					  xiao82<=x32;
					  xiao92<=x32;
					  xiao102<=x32;
					 end
					else
					 begin
					  zheng72<=0;
					  zheng82<=0;
					  zheng92<=z32+100;
					  zheng102<=z32+100;
					  xiao72<=100-x32;
					  xiao82<=100-x32;
					  xiao92<=x32;
					  xiao102<=x32;
					 end
					he72<=zheng72+xiao72;
					he82<=zheng82+xiao82;
					he92<=zheng92+xiao92;
					he102<=zheng102+xiao102;
					temp72<=he72*he72;
					temp82<=he82*he82;
					temp92<=he92*he92;
					temp102<=he102*he102;
				  end
				 else
				  begin
				   if(z32>1)
					 begin
				     zheng72<=z32+100;
					  zheng82<=z32+100;
					  zheng92<=z32-100;
					  zheng102<=z32-100;
				     xiao72<=x32;
					  xiao82<=x32;
					  xiao92<=x32;
					  xiao102<=x32;
					 end
					else
					 begin
					  zheng72<=z32+100;
					  zheng82<=z32+100;
					  zheng92<=0;
					  zheng102<=0;
					  xiao72<=x32;
					  xiao82<=x32;
					  xiao92<=100-x32;
					  xiao102<=100-x32;
					 end
					  he72<=zheng72+xiao72;
					  he82<=zheng82+xiao82;
					  he92<=zheng92+xiao92;
					  he102<=zheng102+xiao102;
					  temp72<=he72*he72;
					  temp82<=he82*he82;
					  temp92<=he92*he92;
					  temp102<=he102*he102;
				  end
				  v7<=temp71+temp72;
				  v8<=temp81+temp82;
				  v9<=temp91+temp92;
				  v10<=temp101+temp102;
				  //cnt<=cnt+1;
				end
				 
			3: begin
			    if(m41[15]==1)
				  begin
				   if(z41>1)
					 begin
				     zheng111<=z41-100;
					  zheng121<=z41+100;
					  zheng131<=z41+100;
					  zheng141<=z41-100;
					  xiao111<=x41;
					  xiao121<=x41;
					  xiao131<=x41;
					  xiao141<=x41;
					 end
					else
					 begin
					  zheng111<=0;
					  zheng121<=z41+100;
					  zheng131<=z41+100;
					  zheng141<=0;
					  xiao111<=100-x41;
					  xiao121<=x41;
					  xiao131<=x41;
					  xiao141<=100-x41;
					 end
					he111<=zheng111+xiao111;
					he121<=zheng121+xiao121;
					he131<=zheng131+xiao131;
					he141<=zheng141+xiao141;
					temp111<=he111*he111;
					temp121<=he121*he121;
					temp131<=he131*he131;
					temp141<=he141*he141;
				  end
				 else
				  begin
				   if(z41>1)
					 begin
				     zheng111<=z41+100;
					  zheng121<=z41-100;
					  zheng131<=z41-100;
					  zheng141<=z41+100;
				     xiao111<=x41;
					  xiao121<=x41;
					  xiao131<=x41;
					  xiao141<=x41;
					 end
					else
					 begin
					  zheng111<=z41+100;
					  zheng121<=0;
					  zheng131<=0;
					  zheng141<=z41+100;
					  xiao111<=x41;
					  xiao121<=100-x41;
					  xiao131<=100-x41;
					  xiao141<=x41;
					 end
                 he111<=zheng111+xiao111;					  
                 he121<=zheng121+xiao121;
                 he131<=zheng131+xiao131;					  
                 he141<=zheng141+xiao141;
					  temp111<=he111*he111;
					  temp121<=he121*he121;
					  temp131<=he131*he131;
					  temp141<=he141*he141;
				  end
				                                  
             //m2的计算
			if(m42[15]==1)
				  begin
				   if(z42>1)
					 begin
				     zheng112<=z42-100;
					  zheng122<=z42-100;
					  zheng132<=z42+100;
					  zheng142<=z42+100;
					  xiao112<=x42;
					  xiao122<=x42;
					  xiao132<=x42;
					  xiao142<=x42;
					 end
					else
					 begin
					  zheng112<=0;
					  zheng122<=0;
					  zheng132<=z42+100;
					  zheng142<=z42+100;
					  xiao112<=100-x42;
					  xiao122<=100-x42;
					  xiao132<=x42;
					  xiao142<=x42;
					 end
					he112<=zheng112+xiao112;
					he122<=zheng122+xiao122;
					he132<=zheng132+xiao132;
					he142<=zheng142+xiao142;
					temp112<=he112*he112;
					temp122<=he122*he122;
					temp132<=he132*he132;
					temp142<=he142*he142;
				  end
				 else
				  begin
				   if(z42>1)
					 begin
				     zheng112<=z42+100;
					  zheng122<=z42+100;
					  zheng132<=z42-100;
					  zheng142<=z42-100;
				     xiao112<=x42;
					  xiao122<=x42;
					  xiao132<=x42;
					  xiao142<=x42;
					 end
					else
					 begin
					  zheng112<=z42+100;
					  zheng122<=z42+100;
					  zheng132<=0;
					  zheng142<=0;
					  xiao112<=x42;
					  xiao122<=x42;
					  xiao132<=100-x42;
					  xiao142<=100-x42;
					 end					  
                 he112<=zheng112+xiao112;					  
                 he122<=zheng122+xiao122;					  
                 he132<=zheng132+xiao132;	
                 he142<=zheng142+xiao142;
					  temp112<=he112*he112;
					  temp122<=he122*he122;
					  temp132<=he132*he132;
					  temp142<=he142*he142;
				  end
				  v11<=temp111+temp112;
				  v12<=temp121+temp122;
				  v13<=temp131+temp132;
				  v14<=temp141+temp142;
				  sur_over<=1;
				end
	 endcase
	end
end

endmodule
