%BP���������㷨
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
%   PerData����������ж�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rows=row*block;
cols=col*block;
LLRsigma=sigma;
IterNumLen=length(IterNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%
ErrDecode=zeros(1,IterNumLen);
%Outputdecode=zeros(IterNumLen,cols);
%Outputdecode=zeros(2,cols);

%�ŵ���ʼLLRֵ
LLRInitial=zeros(1,cols);
for i=1:cols
    LLRInitial(1,i)=2*Sign(1,i)/(LLRsigma^2);
end
LLRQ=zeros(rows,cols);  %�����㵽У����LLR��Ϣ
LLRR=zeros(rows,cols);  %У��㵽�������LLR��Ϣ

%��ʼ��LLRQ
for i=1:rows
    for j=1:cols
        if H(i,j)~=0
            LLRQ(i,j)=LLRInitial(1,j); 
        end
    end
end


%��������
%maxiter=IterNum(IterNumLen);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OutputdecodeNum=zeros(maxiter,cols);
Outputdecode=zeros(1,cols);
%m=1;
for iter=1:IterNum
   
    %У��㵽�������LLR����
    for i=1:rows
        for j=1:cols
            if H(i,j)~=0%�ж�H����Ϊ0�ĵ���е�������
                
                LLRRPro=1;%����LLRR��Beita�Ļ�
                
                %��������ڵ㴫��У��ڵ����Ϣ
                for k=1:cols
                    if H(i,k)~=0&&k~=j%����H�����LLRQֵ�����ж�
                        LLRRPro=LLRRPro*tanh(LLRQ(i,k)/2);
                    end
                end
                
                %��ϢΪ0ʱ�Ĵ���
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
    %�����㵽У����LLR����
    for i=1:cols
        for j=1:rows
            LLRMid=0;
            if H(j,i)~=0
                for k=1:rows
                    if k~=j&&H(k,i)~=0
                        LLRMid=LLRR(k,i)+LLRMid;%����Ϣ���ϳ�ȥ������ŵ���Ϣ
                    end
                end
                LLRQ(j,i)=LLRMid+LLRInitial(1,i);%������
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LLRQ
    
    %�����������ж�
    LQ=zeros(1,cols);
   
    %����������
    for i=1:cols 
        LQMid=0;
        for j=1:rows
            LQMid=LLRR(j,i)+LQMid;
        end
        LQ(1,i)=LQMid+LLRInitial(1,i);
    end
    
    %��������
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
    %���������ж��Լ��������ֺ���������
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
    
    
    %���ּ��
    check=[];
    check=H*decode';
    mark=0;%�������������־
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
%�жϵ��������������Ƿ���ȷ
%if mod(sum(check),2)~=0
%        ErrDecode=1;
%    end
%end 



