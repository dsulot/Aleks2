function [xs,ys] = FindPath(xs,ys,xk,yk,img_crop,kierunekx, kieruneky, zakazany)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if ~exist('zakazany', 'var')
    zakazany = [];
    zakazanyy=[];
    zakazanyx=[];
elseif ~isempty(zakazany)
    zakazanyy=zakazany(2,:);
    zakazanyx=zakazany(1,:);
end


wrong_way_x = 0;
wrong_way_y = 0;
wrong_way = 0;

count= length(xs);
wrong_ind =0;
prev_wrong = count;
while 1    
    % punkty dooko³a zaznaczonego punktu
    max_point = findMaxPoint(xs, ys, img_crop, zakazany);
    if max_point ~= [0 0]
         xs = [xs, max_point(1)];
         ys = [ys, max_point(2)];
    else
         if (xs(end)-xk)>0
            xs = [xs, xs(end)-1];
         else
             xs = [xs, xs(end)+1];
         end
         
         if (ys(end)-yk)>0
            ys = [ys, ys(end)-1];
         else
             ys = [ys, ys(end)+1];
         end
    end
    count=count+1;

    %sprawdzane kierunku czy nie zbacza
    if (xs(end)-xs(end-1))>0 && kierunekx == 1
        wrong_way_x = 1;
    elseif (xs(end)-xs(end-1))<0 && kierunekx ==0
        wrong_way_x = 1;
    else
        wrong_way_x = 0;
    end

    if (ys(end)-ys(end-1))>0 && kieruneky == 1
        wrong_way_y = 1;
    elseif (ys(end)-ys(end-1))<0 && kieruneky ==0
        wrong_way_y = 1;
    else
        wrong_way_y = 0;
    end

    if wrong_way_y==1 && wrong_way_x ==1
        if wrong_way == 0
            wrong_ind = count;
        end
        wrong_way = wrong_way + 1;
    else
        wrong_way=0;
    end

    if wrong_way > 1
        warning("wrong path way")
        zakazanyx = [zakazanyx,xs(wrong_ind)];
        zakazanyy = [zakazanyy,ys(wrong_ind)];
        zakazany = [zakazanyx; zakazanyy];
        zakazany = unique(zakazany', 'rows');
       % zakazany = [xs(wrong_ind), ys(wrong_ind)];
        [xs,ys] = FindPath(xs(1:wrong_ind-1),ys(1:wrong_ind-1),xk,yk,img_crop,kierunekx, kieruneky, zakazany');
        break;
    end


   
    if EndCondition(xk,yk, max_point(1), max_point(2)) == "true"
        % czasami przez to sie blokuje bo nie dochodzi to jego konca nigdy
        % ;/
        break;
    end
   
    if length(unique(xs))>150
        error("Problem with finding path through two given points");
        break;
    end 
end
end

