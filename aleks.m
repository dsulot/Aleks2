[w,h] = size(seg_I);
for i = 1:w
    for j = 1:h
        if seg_I(i,j)==1 
            seg_2(i,j)=1 ;
        else
            seg_2(i,j)=0;
        end
    end
end