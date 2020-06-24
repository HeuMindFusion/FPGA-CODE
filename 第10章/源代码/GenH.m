%构造非规则低密度校验矩阵，其中参考了密度进化和Block-LDPC的研究结果
%校验矩阵H的维数：(rows*block)*(cols*block)，block为矩阵块维数
%度的分布为：DegreeCol(x),DegreeRow(y),DegreeCol0为列重最大值
%码率暂时定为1/2
function H=GenH(rows,cols,block)
judge=1;
while judge==1
    DegreeCol=[0 0.33241 0.24632 0.11014 0.31112];%节点度数从2到5
    DegreeRow=[0.76611 0.23389];%校验节点为6和7

    %将百分比转换为整数
    ColFlag=int16(cols*DegreeCol);
    RowFlag=int16(rows*DegreeRow);
    
    %对各行各列的度数进行记录
    ColCount=zeros(1,5);
    RowCount=zeros(1,rows);
    Degree=length(ColFlag);%节点度数从大到小选
    ParityCheck=zeros(rows*block,block);%对中间变量矩阵赋值
    MidH=[];
    MidM=[];


    Degree=length(ColFlag);%节点度数从大到小选
    step=1;%后rows-1列中随机矩阵用到的一个参数
    for k=1:cols 
        
        %判断已用节点度数的个数是否超过度分布规定的个数
        if ColCount(Degree)<ColFlag(Degree)
            ColCount(Degree)=ColCount(Degree)+1;%记录已用度数的个数
        elseif Degree>=2
            Degree=Degree-1;
            ColCount(Degree)=ColCount(Degree)+1;
        end
      
        GirthFourNum=0;
        Mark=1;
        iternum=100;
        while iternum>=1
            %判断i所处的位置，不同位置采取相应的随机序列
            if k<=(cols-rows)+1
                RandomRow=RandomSeqence(rows,Degree,RowCount);%从rows中选取Degree个行并大小排序
            else
                RandomRow=RandomTriangleSeqence(rows,Degree,step,RowCount);
                %step=step+1;
            end
            
            ParityCheck=zeros(rows*block,block);
            ParityCheck=ColBlockMatrix(RandomRow,rows,cols,block,k);%构造一列的块矩阵
            
            %先判断是否为第一列块矩阵，是则给MidH，否则右拼该列
            if k==1
                MidH=ParityCheck;
                MidM=ParityCheck;
            else
                MidM=horzcat(MidH,ParityCheck);
            end
            
            %有无四环判断,进行调整
            move=0;
            for i=1:rows-1
                [RM,CM]=size(MidM);
                GirthFourNum=GirthFourH(MidM,RM,CM);
                if GirthFourNum==0
                    Mark=0;
                    break
                else
                    if k<=(cols-rows)+1
                        ParityCheck=circshift(ParityCheck,[block,1]);
                        MidM=horzcat(MidH,ParityCheck);
                        move=move+1;
                    else
                        break
                    end
                end
            end
            if Mark==0
                
                break
            end
            iternum=iternum-1;
        end
        
        %T矩阵下三角的构造中的一个参数
        %%%%%%%%%%%%%%5
        if k>(cols-rows)+1
            step=step+1;
        end
        
        %记录已使用的行的个数
        for m=1:Degree
            if move~=0
                if RandomRow(m)<=move
                    RandomRow(m)=RandomRow(m)+rows-move;
                else
                    RandomRow(m)=RandomRow(m)-move;
                end
            end
            RowCount(RandomRow(m))=RowCount(RandomRow(m))+1;
        end

        MidH=MidM;
    end
    H=MidH;
    
    %判断构造的LDPC是否符合要求
    for i=1:rows*block
        for j=1:cols*block
            if j<=(cols-rows)*block
                if i<=(rows-1)*block
                    A(i,j)=H(i,j);
                else 
                    C(i-(rows-1)*block,j)=H(i,j);
                end
            elseif j>(cols-rows)*block&j<=(cols-rows+1)*block
                if i<=(rows-1)*block
                    B(i,j-(cols-rows)*block)=H(i,j);
                else 
                    D(i-(rows-1)*block,j-(cols-rows)*block)=H(i,j);
                end
            else
                if i<=(rows-1)*block
                    T(i,j-(cols-rows+1)*block)=H(i,j);
                else 
                    E(i-(rows-1)*block,j-(cols-rows+1)*block)=H(i,j);
                end
            end
        end
    end
    MidM=-E*inv(T)*B+D; 
    det(MidM)
    if det(MidM)~=0&&abs(det(MidM))<3
        judge=0;
        break
    else
        judge=1;
    end
end






