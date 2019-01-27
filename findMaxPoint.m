function [max_point] = findMaxPoint(xs, ys, img_crop)
 % Funkcja do znajdowania s¹siaduj¹cego punktu o najwiêkszej wartoœci
 % Arg. wej.: 
 % xs, ys - wspó³rzêdne x i y punktu pocz¹tkowego
 % im_crop - obraz na którym szukamy punktów
 % Arg. wyj.:
 % max_point - wspó³rzêdne punktu o najwiêkszej wartoœci, nie wystêpuj¹cego
 % wczeœniej

    pa1_ind = [xs(end)+1, ys(end)];
    pa1 = img_crop(pa1_ind(2), pa1_ind(1));
    pa2_ind = [xs(end)+1, ys(end)-1];
    pa2 = img_crop(pa2_ind(2), pa2_ind(1));
    pa3_ind = [xs(end), ys(end)-1];
    pa3 = img_crop(pa3_ind(2), pa3_ind(1));
    pa4_ind = [xs(end)-1, ys(end)-1];
    pa4 = img_crop(pa4_ind(2), pa4_ind(1));
    pa5_ind = [xs(end)-1, ys(end)];
    pa5 = img_crop(pa5_ind(2), pa5_ind(1));
    pa6_ind = [xs(end)+1, ys(end)+1];
    pa6 = img_crop(pa6_ind(2), pa6_ind(1)); 
    pa7_ind = [xs(end)-1, ys(end)+1];
    pa7 = img_crop(pa7_ind(2), pa7_ind(1));
    pa8_ind = [xs(end), ys(end)+1];
    pa8 = img_crop(pa8_ind(2), pa8_ind(1));
    
    % wektor punktów
    points_around = [pa1, pa2, pa3, pa4, pa5, pa6, pa7, pa8];

    % zmienna mówi¹ca czy znaleziony punkt wystêpowa³ ju¿ wczeœniej
    is_changed = 1;
    
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
                    is_changed = 1;
                end
            end
        end
    end

end

