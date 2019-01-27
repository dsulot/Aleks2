function [max_point] = findMaxPoint(xs, ys, img_crop)
 % Funkcja do znajdowania s�siaduj�cego punktu o najwi�kszej warto�ci
 % Arg. wej.: 
 % xs, ys - wsp�rz�dne x i y punktu pocz�tkowego
 % im_crop - obraz na kt�rym szukamy punkt�w
 % Arg. wyj.:
 % max_point - wsp�rz�dne punktu o najwi�kszej warto�ci, nie wyst�puj�cego
 % wcze�niej

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
    
    % wektor punkt�w
    points_around = [pa1, pa2, pa3, pa4, pa5, pa6, pa7, pa8];

    % zmienna m�wi�ca czy znaleziony punkt wyst�powa� ju� wcze�niej
    is_changed = 1;
    
    % p�tla szukaj�ca punktu, kt�ry nie wsyt�powa� wcze�niej
    while is_changed == 1
        
        is_changed = 0;
        
        % szukanie maksimum
        [~, ind] = max(points_around);
        max_point = eval(['pa', num2str(ind), '_ind']);
        prev_pointsx_ind = find(xs == max_point(1));
        prev_pointsx = xs(prev_pointsx_ind);
        prev_pointsy = ys(prev_pointsx_ind);
        prev_points = [prev_pointsx', prev_pointsy'];
        
        % je�eli punkt wyst�puje w poprzednich punktach
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

