%----------------------------------
%QCEncode.m---------------------
%
%IEEE802.16e标准LDPC码的快速编码：是一种迭代编码算法
%
%-----------------------------------
%输入参数说明：
%InputK：输入信息
%qcH：校验矩阵
%HbNew：扩展前更新后的基校验矩阵
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



ZhInverse=zeros(z);%Hb2中hb的三个方阵和的逆

ZhInverse=qcH(1:z,z*kb+1:z*kb+z)+qcH(z*5+1:z*5+z,z*kb+1:z*kb+z)+...
    qcH(z*(mb-1)+1:z*mb,z*kb+1:z*kb+z);

%由于Hb2中hb中两个方阵相同，相加后由模2运算抵消，因此所得结果为单位阵
%其逆矩阵也为单位阵
ZhInverse=mod(ZhInverse,2);

%求p1
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

%求p2
ZSum2=zeros(z,1);
for k=1:kb
    if Hb(1,k)>=0
        ZSum2=ZSum2+qcH(1:z,z*(k-1)+1:z*k)*InputB(1,z*(k-1)+1:z*k)';
    end
end
CheckB(z+1:2*z,1)=mod(ZSum2+qcH(1:z,z*kb+1:z*(kb+1))*CheckB(1:z,1),2);

%求除开r+1外的pi值
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






    


