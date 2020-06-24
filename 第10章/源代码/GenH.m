%����ǹ�����ܶ�У��������вο����ܶȽ�����Block-LDPC���о����
%У�����H��ά����(rows*block)*(cols*block)��blockΪ�����ά��
%�ȵķֲ�Ϊ��DegreeCol(x),DegreeRow(y),DegreeCol0Ϊ�������ֵ
%������ʱ��Ϊ1/2
function H=GenH(rows,cols,block)
judge=1;
while judge==1
    DegreeCol=[0 0.33241 0.24632 0.11014 0.31112];%�ڵ������2��5
    DegreeRow=[0.76611 0.23389];%У��ڵ�Ϊ6��7

    %���ٷֱ�ת��Ϊ����
    ColFlag=int16(cols*DegreeCol);
    RowFlag=int16(rows*DegreeRow);
    
    %�Ը��и��еĶ������м�¼
    ColCount=zeros(1,5);
    RowCount=zeros(1,rows);
    Degree=length(ColFlag);%�ڵ�����Ӵ�Сѡ
    ParityCheck=zeros(rows*block,block);%���м��������ֵ
    MidH=[];
    MidM=[];


    Degree=length(ColFlag);%�ڵ�����Ӵ�Сѡ
    step=1;%��rows-1������������õ���һ������
    for k=1:cols 
        
        %�ж����ýڵ�����ĸ����Ƿ񳬹��ȷֲ��涨�ĸ���
        if ColCount(Degree)<ColFlag(Degree)
            ColCount(Degree)=ColCount(Degree)+1;%��¼���ö����ĸ���
        elseif Degree>=2
            Degree=Degree-1;
            ColCount(Degree)=ColCount(Degree)+1;
        end
      
        GirthFourNum=0;
        Mark=1;
        iternum=100;
        while iternum>=1
            %�ж�i������λ�ã���ͬλ�ò�ȡ��Ӧ���������
            if k<=(cols-rows)+1
                RandomRow=RandomSeqence(rows,Degree,RowCount);%��rows��ѡȡDegree���в���С����
            else
                RandomRow=RandomTriangleSeqence(rows,Degree,step,RowCount);
                %step=step+1;
            end
            
            ParityCheck=zeros(rows*block,block);
            ParityCheck=ColBlockMatrix(RandomRow,rows,cols,block,k);%����һ�еĿ����
            
            %���ж��Ƿ�Ϊ��һ�п���������MidH��������ƴ����
            if k==1
                MidH=ParityCheck;
                MidM=ParityCheck;
            else
                MidM=horzcat(MidH,ParityCheck);
            end
            
            %�����Ļ��ж�,���е���
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
        
        %T���������ǵĹ����е�һ������
        %%%%%%%%%%%%%%5
        if k>(cols-rows)+1
            step=step+1;
        end
        
        %��¼��ʹ�õ��еĸ���
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
    
    %�жϹ����LDPC�Ƿ����Ҫ��
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






