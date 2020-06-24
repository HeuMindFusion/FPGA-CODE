module Mux_8( addr,in1, in2, in3, in4, in5, in6, in7, in8, Mout, ncs);
input [2:0] addr;
input [width-1] in1, in2, in3, in4, in5, in6, in7, in8;
output reg [width-1] Mout;
parameter width = 8;
always @ (addr or in1 or in2 or in3 or in4 or in5 or in6 or in7 or in8)
  begin
      if (!ncs)
         case(addr)
         3¡¯b000: Mout = in1;
         3¡¯b001: Mout = in2;
         3¡¯b010: Mout = in3;
         3¡¯b011: Mout = in4;
         3¡¯b100: Mout = in5;
         3¡¯b101: Mout = in6;
         3¡¯b110: Mout = in7;
         3¡¯b111: Mout = in8;
      endcase
  else
        Mout = 0;
  end 
endmodule
