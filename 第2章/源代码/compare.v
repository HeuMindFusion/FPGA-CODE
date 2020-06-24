module compare_n ( X, Y, XGY, XSY, XEY);
input [width-1:0]  X, Y;
output  XGY,  XSY, XEY;
reg   XGY,  XSY,  XEY;
parameter width = 8;
always @ ( X or Y )                    //  每当X 或Y 变化时
 begin
          if ( X = = Y )
                   XEY = 1;         // 设置X 等于Y的信号为1
          else  XEY = 0;
          if (X > Y)
                   XGY = 1;         // 设置X 大于Y的信号为1
          else  XGY = 0;
          if (X < Y)
                     XSY = 1;       // 设置X 小于Y的信号为1
          else     XSY =  0;
 end
endmodule
