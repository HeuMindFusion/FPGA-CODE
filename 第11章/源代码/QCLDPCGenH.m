%----------------------------------
%QCLDPCGenH.m---------------------
%
%��IEEE802.16e��׼��QC-LDPC����������������Ⱥ�����οյİ취����
%�����������Ⱥ����һ����������
%�ٹ���һ�����������һ���ȷֲ��ľ���
%
%-----------------------------------
%�������˵����
%SubSize����λ����ά��
%BasisColNum�������������(��802.16e��׼Ĭ��Ϊ24)
%Rate������(Ĭ��Ϊ0.5)
%----------------------------------
function [qcH,Hb]=QCLDPCGenH(SubSize,BasisColNum,Rate)
%nb,mbΪ��У����������������
%��IEEE802.16e��׼�У�BasisColNum��ֵΪ24
%SubSizeΪ��չ���ӣ�����λ����ά��
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

%����һ����СΪ(j,k)��ѭ���Ӿ��󣬴�С��BasisColNum,Rate����
%a,bΪС��SubSize���������һ��ء�ȡa=2,b=3
%����GF(q),q=SubSize,�µ�У�����
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






