%LDPC的编码程序
function PerEncode=LDPCEncode(InputM,rows,cols,block,H)

%求出H中的A,B,C,D,E,T矩阵
for i=1:rows*block
    for j=1:cols*block
        if j<=(cols-rows)*block
            if i<=(rows-1)*block
                A(i,j)=H(i,j);
            else 
                C(i-(rows-1)*block,j)=H(i,j);
            end
        elseif j>(cols-rows)*block&j<=(cols-rows+1)*block
            if i<=(rows-1)*block
                B(i,j-(cols-rows)*block)=H(i,j);
            else 
                D(i-(rows-1)*block,j-(cols-rows)*block)=H(i,j);
            end
        else
            if i<=(rows-1)*block
                T(i,j-(cols-rows+1)*block)=H(i,j);
            else 
                E(i-(rows-1)*block,j-(cols-rows+1)*block)=H(i,j);
            end
        end
    end
end
MidM=-E*inv(T)*B+D;
EncodeOne=InputM;
EncodeTwoT=mod(inv(MidM)*(-E*inv(T)*A+C)*EncodeOne',2);
EncodeThrT=mod(inv(T)*(A*EncodeOne'+B*EncodeTwoT),2);
PerEncode=[EncodeOne EncodeTwoT' EncodeThrT'];
PerEncode=double(PerEncode);
mod(H*PerEncode',2);



    



