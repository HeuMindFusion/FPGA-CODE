%ËÄ»·¼ì²â³ÌÐò
function GirthFourNum=GirthFourH(H,rows,cols)
GirthFourNum=0;
for i=1:rows-1
    for j=1:cols-1
        if H(i,j)==1
            x1=i;y1=j;
            for j1=j+1:cols
                if H(i,j1)==1
                    x2=i;y2=j1;
                    for i1=i+1:rows
                        if H(i1,j1)==1
                            x3=i1;y3=j1;
                            if H(i1,j)==1
                                x4=i1;y4=j;
                                GirthFourNum=GirthFourNum+1;
                            end
                        end
                    end
                end
            end
        end
    end
end
GirthFourNum;