%����һ�еĿ����
function ColParityCheck=ColBlockMatrix(ColRandomRow,rows,cols,block,i)
R=1;
%������ֳ������ֿ��ǣ������ֲ�ͬ���λ�õ�ѡȡ
%���������ǲ��ֵĻ�У�������п鹹��
if i<=(cols-rows)+1
    %���þ���ƴ�ӵķ���ʵ���п�Ĺ���
    for k=1:rows
        %��һ��λ����ֵʱ��ƴ��������ƾ�������ƴ�������
        if k==1
            if ColRandomRow(1)==1
                ColParityCheck=[];
                RIM=RandomIdentityMatrix(block);
                ColParityCheck=vertcat(ColParityCheck,RIM);
                R=R+1;
            else
                ColParityCheck=[];
                ColParityCheck=vertcat(ColParityCheck,zeros(block));
            end
        else
            if k==ColRandomRow(R)
                RIM=RandomIdentityMatrix(block);
                ColParityCheck=vertcat(ColParityCheck,RIM);
                R=R+1;
            else
                ColParityCheck=vertcat(ColParityCheck,zeros(block));
            end
        end
    end
%�����ǲ��ֵĻ�У�������п鹹��    
else
    for k=1:rows
        %�����ǲ���ƴ��ʱ����һ�����λ�õľ���Ϊ��λ�������ಿ�ֵ�ƴ�ӷ�������һ������ͬ
        if k==1
            if ColRandomRow(1)==1
                ColParityCheck=[];
                ColParityCheck=vertcat(ColParityCheck,eye(block));
                R=R+1;
            else 
                ColParityCheck=[];
                ColParityCheck=vertcat(ColParityCheck,zeros(block));
            end
        else
            if ColRandomRow(1)==k
                ColParityCheck=vertcat(ColParityCheck,eye(block));
                R=R+1;
            elseif ColRandomRow(R)==k
                RIM=RandomIdentityMatrix(block);
                ColParityCheck=vertcat(ColParityCheck,RIM);
                R=R+1;
            else
                ColParityCheck=vertcat(ColParityCheck,zeros(block));
            end
        end
    end
end

        



