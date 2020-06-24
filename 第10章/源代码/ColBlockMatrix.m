%构造一列的块矩阵
function ColParityCheck=ColBlockMatrix(ColRandomRow,rows,cols,block,i)
R=1;
%将构造分成两部分考虑，即两种不同随机位置的选取
%除开下三角部分的基校验矩阵的列块构造
if i<=(cols-rows)+1
    %采用矩阵拼接的方法实现列块的构造
    for k=1:rows
        %第一个位置有值时，拼接随机右移矩阵，无则拼接零矩阵
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
%下三角部分的基校验矩阵的列块构造    
else
    for k=1:rows
        %下三角部分拼接时，第一个随机位置的矩阵为单位矩阵，其余部分的拼接方法和上一部分相同
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

        



