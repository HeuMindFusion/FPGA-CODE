%��rows-1�еĶȵķֲ�
function RandomT=RandomTriangleSeqence(rows,Degree,step)
%�����Rows��ѡȡ������������һ����ѡȡ�Ľڵ����
%�����λ�ÿ����������Ǿ���T�Խ������º���������E�Ĳ���
RandomRow0=randperm(rows-step)+step;
RandomRow=RandomRow0(1:Degree-1);
%�������ǶԽ��ߵ�λ�ü�����ѡ�õ����λ����
N=length(RandomRow);
RandomRow(N+1)=step;
%����ѡȡ�����λ�ô�С��������
for k=1:N+1
    for m=(k+1):N+1
        if RandomRow(k)>RandomRow(m)
            Mid=RandomRow(k);
            RandomRow(k)=RandomRow(m);
            RandomRow(m)=Mid;
        end
    end
end
RandomRow(Degree+1)=0;
RandomT=RandomRow;
