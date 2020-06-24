%BP迭代译码算法
function Outputdecode=LDPCDecode(Sign,row,col,block,H,sigma,IterNum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear
%clc
%row=16;col=32;block=4;SNR=1;k=1;
%H=GenH(row,col,block);
%InputM=randint(1,16*4);
%PerEncode=LDPCEncode(InputM,row,col,block,H);
%[Sign,OutputCode,ErrCode,sigma]=BPSKAn(PerEncode,SNR)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PerData用于误比特判断
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rows=row*block;
cols=col*block;
LLRsigma=sigma;
IterNumLen=length(IterNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%
ErrDecode=zeros(1,IterNumLen);
%Outputdecode=zeros(IterNumLen,cols);
%Outputdecode=zeros(2,cols);

%信道初始LLR值
LLRInitial=zeros(1,cols);
for i=1:cols
    LLRInitial(1,i)=2*Sign(1,i)/(LLRsigma^2);
end
LLRQ=zeros(rows,cols);  %变量点到校验点的LLR信息
LLRR=zeros(rows,cols);  %校验点到变量点的LLR信息

%初始化LLRQ
for i=1:rows
    for j=1:cols
        if H(i,j)~=0
            LLRQ(i,j)=LLRInitial(1,j); 
        end
    end
end


%迭代过程
%maxiter=IterNum(IterNumLen);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OutputdecodeNum=zeros(maxiter,cols);
Outputdecode=zeros(1,cols);
%m=1;
for iter=1:IterNum
   
    %校验点到变量点的LLR计算
    for i=1:rows
        for j=1:cols
            if H(i,j)~=0%判断H矩阵不为0的点进行迭代计算
                
                LLRRPro=1;%计算LLRR中Beita的积
                
                %计算变量节点传向校验节点的消息
                for k=1:cols
                    if H(i,k)~=0&&k~=j%利用H矩阵对LLRQ值进行判断
                        LLRRPro=LLRRPro*tanh(LLRQ(i,k)/2);
                    end
                end
                
                %信息为0时的处理
                if LLRRPro~=0
                    LLRR(i,j)=2*atanh(LLRRPro);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %if LLRR(i,j)==inf||LLRR(i,j)==-inf
                    %    LLRR(i,j)=0;
                    %end
                else
                    LLRR(i,j)=0;
                end
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LLRR
    %变量点到校验点的LLR计算
    for i=1:cols
        for j=1:rows
            LLRMid=0;
            if H(j,i)~=0
                for k=1:rows
                    if k~=j&&H(k,i)~=0
                        LLRMid=LLRR(k,i)+LLRMid;%外信息加上除去本身的信道信息
                    end
                end
                LLRQ(j,i)=LLRMid+LLRInitial(1,i);%出过错
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LLRQ
    
    %迭代后码字判断
    LQ=zeros(1,cols);
   
    %计算后验概率
    for i=1:cols 
        LQMid=0;
        for j=1:rows
            LQMid=LLRR(j,i)+LQMid;
        end
        LQ(1,i)=LQMid+LLRInitial(1,i);
    end
    
    %估计码字
    decode=zeros(1,cols);
    %%%%%%%%%%%%%%%%%%
    %LQ
    for i=1:cols
        if LQ(1,i)<0
            decode(1,i)=1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %decode
    %SUM=sum(abs(PerData-decode(1:(length(PerData)))))
    %迭代次数判断以及译码码字和误比特输出
    %if IterNum(1,m)==iter
      %  ErrDecode(1,m)=sum(abs(PerData-decode(1:(length(PerData)))));
        %if ErrDecode(1,m)>200&&m==maxiter
           % Outputdecode=decode;
            %(1,:)=decode;
            %Outputdecode(2,:)=[PerData,ones(1,length(PerData))];
       % end
      %  m=m+1;
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %if ErrDecode(1,IterNumLen)>200
    %    break
    %end
    
    
    %码字检测
    check=[];
    check=H*decode';
    mark=0;%迭代译码结束标志
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %sumerr=sum(mod(check,2))

    
    for i=1:rows
        if mod(check(i,1),2)==1
            mark=1;
            break
        end
    end
    
    if mark==0
        break
    end
end
Outputdecode=decode;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DeNum=sum(abs(decode-PerEncode));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%判断迭代译码后的码字是否正确
%if mod(sum(check),2)~=0
%        ErrDecode=1;
%    end
%end 



