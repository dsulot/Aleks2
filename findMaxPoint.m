function [max_point] = findMaxPoint(xs, ys, img_crop, zakazany)
 % Funkcja do znajdowania s¹siaduj¹cego punktu o najwiêkszej wartoœci
 % Arg. wej.: 
 % xs, ys - wspó³rzêdne x i y punktu pocz¹tkowego
 % im_crop - obraz na którym szukamy punktów
 % Arg. wyj.:
 % max_point - wspó³rzêdne punktu o najwiêkszej wartoœci, nie wystêpuj¹cego
 % wczeœniej
 if ~exist('zakazany', 'var')
    zakazany = [0 0];
end
 max_point = [0 0];
 
 
      
     pa1_ind = [xs(end)+1, ys(end)];
         
    if pa1_ind(1) > size(img_crop, 2) || pa1_ind(2) > size(img_crop, 1) ...
            || pa1_ind(1) <= 0 || pa1_ind(2) <= 0
        pa1 = 0;
    else
        pa1 = img_crop(pa1_ind(2), pa1_ind(1));
    end
    
    pa2_ind = [xs(end)+1, ys(end)-1];
    if pa2_ind(1) > size(img_crop, 2) || pa2_ind(2) > size(img_crop, 1) ...
             || pa2_ind(1) <= 0 || pa2_ind(2) <= 0
        pa2 = 0;
    else
        pa2 = img_crop(pa2_ind(2), pa2_ind(1));
    end
    
    pa3_ind = [xs(end), ys(end)-1];
    if pa3_ind(1) > size(img_crop, 2) || pa3_ind(2) > size(img_crop, 1) ...
             || pa3_ind(1) <= 0 || pa3_ind(2) <= 0
        pa3 = 0;
    else
        pa3 = img_crop(pa3_ind(2), pa3_ind(1));
    end
        
    pa4_ind = [xs(end)-1, ys(end)-1];
    if pa4_ind(1) > size(img_crop, 2) || pa4_ind(2) > size(img_crop, 1) ...
             || pa4_ind(1) <= 0 || pa4_ind(2) <= 0
        pa4 = 0;
    else
        pa4 = img_crop(pa4_ind(2), pa4_ind(1));
    end
        
    pa5_ind = [xs(end)-1, ys(end)];
    if pa5_ind(1) > size(img_crop, 2) || pa5_ind(2) > size(img_crop, 1) ...
             || pa5_ind(1) <= 0 || pa5_ind(2) <= 0
        pa5 = 0;
    else
        pa5 = img_crop(pa5_ind(2), pa5_ind(1));
    end
        
    pa6_ind = [xs(end)+1, ys(end)+1];
    if pa6_ind(1) > size(img_crop, 2) || pa6_ind(2) > size(img_crop, 1) ...
             || pa6_ind(1) <= 0 || pa6_ind(2) <= 0
        pa6 = 0;
    else
        pa6 = img_crop(pa6_ind(2), pa6_ind(1)); 
    
    pa7_ind = [xs(end)-1, ys(end)+1];
    if pa7_ind(1) > size(img_crop, 2) || pa7_ind(2) > size(img_crop, 1) ...
             || pa7_ind(1) <= 0 || pa7_ind(2) <= 0
        pa7 = 0;
    else
        pa7 = img_crop(pa7_ind(2), pa7_ind(1));
    end
    
    pa8_ind = [xs(end), ys(end)+1];
    if pa8_ind(1) > size(img_crop, 2) || pa8_ind(2) > size(img_crop, 1) ...
             || pa8_ind(1) <= 0 || pa8_ind(2) <= 0
        pa8 = 0;
    else
        pa8 = img_crop(pa8_ind(2), pa8_ind(1));
    end
    
    % wektor punktów
    points_around = [pa1, pa2, pa3, pa4, pa5, pa6, pa7, pa8];

    % zmienna mówi¹ca czy znaleziony punkt wystêpowa³ ju¿ wczeœniej
    is_changed = 1;
    count = 0;
    % pêtla szukaj¹ca punktu, który nie wsytêpowa³ wczeœniej
    while is_changed == 1
        
        is_changed = 0;
        
        % szukanie maksimum
        [~, ind] = max(points_around);
        max_point = eval(['pa', num2str(ind), '_ind']);
        prev_pointsx_ind = find(xs == max_point(1));
        prev_pointsx = xs(prev_pointsx_ind);
        prev_pointsy = ys(prev_pointsx_ind);
        prev_points = [prev_pointsx', prev_pointsy'];
        
        % je¿eli punkt wystêpuje w poprzednich punktach
        if ~isempty(prev_points)
            for i = 1:length(prev_points(:,1))
                if max_point(1) == prev_points(i, 1) && max_point(2) == prev_points(i, 2)
                    points_around(ind) = NaN;
                    count = count+1;
                    is_changed = 1;
                end
            end
        end
        if count > 10
             warning("Problem with finding path through two given points");
            max_point = [0 0];
            break;
        end
        
         if is_changed == 0
         if ~isempty(zakazany)
             for i = 1:length(zakazany(1,:))
                if max_point(1) == zakazany(1,i) && max_point(2) == zakazany(2,i)
                    points_around(ind) = NaN;
                    is_changed = 1;
                end
             end
         end
    end
        
    end
    
   
    


end

