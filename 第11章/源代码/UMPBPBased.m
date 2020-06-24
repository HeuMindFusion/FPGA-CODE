%UMP BP-Based�㷨��UMP(Uniformly Most Powerful),���㷨�����ŵ�����
function Outputdecode=UMPBPBased(Sign,row,col,block,H,sigma,IterNum)
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
    LLRInitial(1,i)=Sign(1,i);
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
                LLRH(1,:)=H(i,:);
                LLRCol(1,:)=LLRQ(i,:);
                LLRH(1,j)=0;
                LLRCol(1,j)=0;
                RSign=1;%LLRCol�еķ��Ż�
                LLRMin=sort(abs(LLRCol));
                RMin=LLRMin(1,cols);%Ԥ�����ֵ
                for k=1:cols
                    if LLRH(1,k)~=0
                        RSign=RSign*sign(LLRCol(1,k));
                        if RMin>abs(LLRCol(1,k))
                            RMin=abs(LLRCol(1,k));
                        end
                    end
                end
                LLRR(i,j)=RSign*RMin;
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

