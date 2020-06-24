function RandomM=RandomSeqence(rows,Degree,RowCount)
%rows����ǰ�е�λ��
%Degree����ǰ�еĶ���
%RowCount��У��ڵ�Ķ����ۻ���
RandomRow0=zeros(1,rows);
RandomRow=zeros(1,rows);
%������Ϊ6���ϵ�У���λ�ø�ֵ0�������ε���λ�õ�ѡȡ
for i=1:rows
    if RowCount(1,i)>6
        RandomRow0(1,i)=0;
    else
        RandomRow0(1,i)=i;
    end
end
%�����õ�У��ڵ��λ���������
RandomRow0=RandomRow0(randperm(length(RandomRow0)));
%ѡȡǰDegree����Ϊ0����ֵ����Ϊ����ѡȡ�����λ��
DegreeMid=1;
for i=1:rows
    if DegreeMid<Degree+1
        if RandomRow0(i)~=0
            RandomRow(DegreeMid)=RandomRow0(i);
            DegreeMid=DegreeMid+1;
        end
    end
end      
%��ѡȡ�����λ�ô�С�����������
N=length(RandomRow);
for i=1:N
    for j=(i+1):N
        if RandomRow(i)>RandomRow(j)
            Mid=RandomRow(i);
            RandomRow(i)=RandomRow(j);
            RandomRow(j)=Mid;
        end
    end
end
RandomRow(Degree+1)=0;
RandomM=RandomRow;
