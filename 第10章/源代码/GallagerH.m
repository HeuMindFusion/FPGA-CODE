function GaH=GallagerH(CodeLength,dv,dc)
%%%%%%%
%CodeLength=20,dv=3,dc=4;%用于测试
%%%%%%%
%水平子矩阵中再划分子矩阵行和列的大小，如图10.1中“1”所示子矩阵
SubRow=CodeLengthdc;
SubCol=dc;
%最小子矩阵的初始化
SubH=zeros(SubRow,SubCol);
%将第一行全部赋值为1
SubH(1,:)=ones(1,SubCol);
%将这个子矩阵赋值给第一个水平子矩阵，再利用拼接函数拼接
SubOneH=SubH;
%将水平子矩阵的第一个子矩阵循环下移得到其余子矩阵，循环一次，拼接一次
for i=2:SubRow
    MidH=circshift(SubH,[i-1,0]);
    SubOneH=horzcat(SubOneH,MidH);
end
%将拼接到的第一个水平子矩阵赋给GallagerH
GallagerH=SubOneH;
% SubReH为循环构造中构造其余水平子矩阵的中间变量矩阵
SubReH=zeros(SubRow,CodeLength);
%根据构造方法，将得到的第一个水平子矩阵中的行打乱得到其余水平子矩阵，同样的方法循环一次，拼接一次
for j=2:dv
    randomV=randperm(CodeLength);
    for k=1:CodeLength
        SubReH(:,k)=SubOneH(:,randomV(1,k));
    end
    GallagerH=vertcat(GallagerH,SubReH);
end
GaH=GallagerH;
