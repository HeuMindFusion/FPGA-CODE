%----------------------------------
%QCLDPCGenH.m---------------------
%
%由IEEE802.16e标准的QC-LDPC码联想采用有限域乘群构造镂空的办法构造
%先由有限域乘群构造一个索引矩阵
%再构造一个随机的满足一定度分布的矩阵
%
%-----------------------------------
%输入参数说明：
%SubSize：单位矩阵维度
%BasisColNum：基矩阵的列数(由802.16e标准默认为24)
%Rate：码率(默认为0.5)
%----------------------------------
function [qcH,Hb]=QCLDPCGenH(SubSize,BasisColNum,Rate)
%nb,mb为基校验矩阵的列数和行数
%在IEEE802.16e标准中，BasisColNum的值为24
%SubSize为扩展因子，即单位矩阵维数
%%%%%%%%%%%%%%%
% clear 
% clc
% SubSize=7;
% BasisColNum=7*2;
% Rate=0.5;
%%%%%%%%%%%%%%%%
nb=BasisColNum;
z=SubSize;
mb=nb-nb*Rate;
kb=nb-mb;
Hz=zeros(z);

%构造一个大小为(j,k)的循环子矩阵，大小由BasisColNum,Rate决定
%a,b为小于SubSize的素数，且互素。取a=2,b=3
%构造GF(q),q=SubSize,下的校验矩阵
%a=2;b=3;
Hbw=zeros(mb,kb);
Hb1=zeros(mb,kb);

%w=randperm(24);
%ww=w(1:kb);
%for i=1:mb
%    Hbw(i,:)=circshift(ww,[0,i-1]);
%end
a=2;
%ww=zeros(1,kb);
ww=2*[0:z-1]

for i=1:mb
    Hbw(i,:)=ww+(i-1);
end

[HRand,RowNum]=RandRankArray(kb,mb);
Hb1=HRand.*Hbw;
Hb1=mod(Hbw,z);

Hb2=[7	0	-1	-1	-1	-1	-1	-1	-1	-1	-1	-1;
    -1	0	0	-1	-1	-1	-1	-1	-1	-1	-1	-1;
    -1	-1	0	0	-1	-1	-1	-1	-1	-1	-1	-1;
    -1	-1	-1	0	0	-1	-1	-1	-1	-1	-1	-1;
    -1	-1	-1	-1	0	0	-1	-1	-1	-1	-1	-1;
    0	-1	-1	-1	-1	0	0	-1	-1	-1	-1	-1;
    -1	-1	-1	-1	-1	-1	0	0	-1	-1	-1	-1;
    -1	-1	-1	-1	-1	-1	-1	0	0	-1	-1	-1;
    -1	-1	-1	-1	-1	-1	-1	-1	0	0	-1	-1;
    -1	-1	-1	-1	-1	-1	-1	-1	-1	0	0	-1;
    -1	-1	-1	-1	-1	-1	-1	-1	-1	-1	0	0;
    7	-1	-1	-1	-1	-1	-1	-1	-1	-1	-1	0];

%Hb=[Hb1-1,Hb2]
Hb=[Hb1-1]
zz=randperm(z);
randz=circshift(eye(z),[0,zz(1)]);
for i=1:mb
    for j=1:kb
        if Hb(i,j)<0
            Hz=zeros(z);
        elseif Hb(i,j)==0
            Hz=eye(z);
        else
            Hz=circshift(randz,[0,Hb(i,j)]);
        end
        if j==1
            SubH=Hz;
        else
            SubH=horzcat(SubH,Hz);
        end
    end
    if i==1
        qcH=SubH;
    else
        qcH=vertcat(qcH,SubH);
    end
end

GirthFourNum=GirthFourH(qcH,z*z,z*z)






