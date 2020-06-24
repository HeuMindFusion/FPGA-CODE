%----------------------------------
%QCEncode.m---------------------
%
%IEEE802.16e��׼LDPC��Ŀ��ٱ��룺��һ�ֵ��������㷨
%
%-----------------------------------
%�������˵����
%InputK��������Ϣ
%qcH��У�����
%HbNew����չǰ���º�Ļ�У�����
%----------------------------------
function QCCode=QCEncode(InputB,qcH,Hb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear 
%clc
%Nbit=576;
%Rate=0.5;
%[qcH,Hb]=QCLDPCBaseH(Nbit,Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mb,nb]=size(Hb);
[rqc,cqc]=size(qcH);
kb=nb-mb;
z=cqc/nb;
%InputB=randint(1,z*kb);
CheckB=zeros(mb*z,1);



ZhInverse=zeros(z);%Hb2��hb����������͵���

ZhInverse=qcH(1:z,z*kb+1:z*kb+z)+qcH(z*5+1:z*5+z,z*kb+1:z*kb+z)+...
    qcH(z*(mb-1)+1:z*mb,z*kb+1:z*kb+z);

%����Hb2��hb������������ͬ����Ӻ���ģ2���������������ý��Ϊ��λ��
%�������ҲΪ��λ��
ZhInverse=mod(ZhInverse,2);

%��p1
ZSum=zeros(z,1);
for j=1:kb
    ZMid=zeros(z,1);
    ZHb=zeros(z);
    for i=1:mb
        if Hb(i,j)>=0
            ZHb=qcH(z*(i-1)+1:z*i,z*(j-1)+1:z*j);
            ZMid=ZMid+ZHb*InputB(z*(j-1)+1:z*j)';
        end
    end
    ZSum=ZMid+ZSum;
end
ZSum=mod(ZSum,2);
CheckB(1:z,1)=mod(ZhInverse*ZSum,2);

%��p2
ZSum2=zeros(z,1);
for k=1:kb
    if Hb(1,k)>=0
        ZSum2=ZSum2+qcH(1:z,z*(k-1)+1:z*k)*InputB(1,z*(k-1)+1:z*k)';
    end
end
CheckB(z+1:2*z,1)=mod(ZSum2+qcH(1:z,z*kb+1:z*(kb+1))*CheckB(1:z,1),2);

%�����r+1���piֵ
for m=3:mb
    ZSumR=zeros(z,1);
    if m~=7
        for k=1:kb
            if Hb(m-1,k)>=0
                ZSumR=ZSumR+qcH(z*(m-2)+1:z*(m-1),z*(k-1)+1:z*k)*...
                    InputB(1,z*(k-1)+1:z*k)';
            end
        end
        CheckB(z*(m-1)+1:z*m,1)=CheckB(z*(m-2)+1:z*(m-1),1)+...
            ZSumR;
    else
        for k=1:kb
            if Hb(m-1,k)>=0
                ZSumR=ZSumR+qcH(z*(m-2)+1:z*(m-1),z*(k-1)+1:z*k)*...
                    InputB(1,z*(k-1)+1:z*k)';
            end
        end
        CheckB(6*z+1:7*z,1)=CheckB(5*z+1:6*z,1)+ZSumR+...
            qcH(5*z+1:6*z,z*kb+1:z*(kb+1))*CheckB(1:z,1);
    end
end
CheckB=mod(CheckB,2);
QCCode=[InputB,CheckB'];
%a=mod(qcH*QCCode',2);






    


