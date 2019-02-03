function [img_crop, xs,ys] = Measure(img, cmap)
% OURALEKS in funtion


c=cmap;
% img = img./max(img);
img=(img-min(img(:)))/(max(img(:))-min(img(:)));
% wyœwietlanie obrazu AFM
imagesc(img );
colormap(c);
hold on;

% liczba punktów jakie u¿ytkownik zaznacza
PointsNumber = 2;

% tablice do przechowywania wspó³rzêdnych zaznaczonych punktów
x_crop = zeros(1,PointsNumber);
y_crop = zeros(1, PointsNumber);

% pobieranie wspó³rzêdnych i zaznaczanie punktów na wykresie
for i = 1:PointsNumber
    [x_crop(i), y_crop(i)] = ginput(1);
    h = plot(x_crop(i),y_crop(i),'.r','MarkerSize', 10);
end
hold off;

% przycinanie obrazu
if x_crop(1) <= x_crop(2)
    if y_crop(1) <= y_crop(2)
        r = [x_crop(1), y_crop(1), x_crop(2)-x_crop(1), y_crop(2)-y_crop(1)];
    else
        r = [x_crop(1), y_crop(2), x_crop(2)-x_crop(1), y_crop(1)-y_crop(2)];
    end
else
    if y_crop(1) <= y_crop(2)
        r = [x_crop(2), y_crop(1), x_crop(1)-x_crop(2), y_crop(2)-y_crop(1)];
    else 
        r = [x_crop(2), y_crop(2), x_crop(1)-x_crop(2), y_crop(1)-y_crop(2)];
    end
end
img_crop = imcrop(img, r);
img_crop = im2double(img_crop);
% wyœwietlanie przyciêtego obrazu w nowym oknie
 imagesc(img_crop); 
colormap(c);
hold on;

% wybieranie punktu pocz¹tkowego i koñcowego DNA
PointsNumber = 2;
x = zeros(1,PointsNumber);
y = zeros(1, PointsNumber);
for i = 1:PointsNumber
    [x(i), y(i)] = ginput(1);
    h = plot(x(i),y(i),'.r', 'MarkerSize', 12);
end
hold off;

% zaokr¹glanie punktów do wartoœci ca³kowitych
x = round(x, 0);
y = round(y, 0);

xp = x(1); yp = y(1);
xk = x(2); yk = y(2); 

xs = xp;
ys = yp;

% while xs(end) ~= xk || ys(end) ~= yk
while 1
    % punkty dooko³a zaznaczonego punktu
    max_point = findMaxPoint(xs, ys, img_crop);
    xs = [xs, max_point(1)];
    ys = [ys, max_point(2)];
    if EndCondition(xk,yk, max_point(1), max_point(2)) == "true"
        % czasami przez to sie blokuje bo nie dochodzi to jego konca nigdy
        % ;/
        break;
    end
    
end

%[size_y, ~] = size(img_crop);

%figure; imagesc(img_crop); 
%c = AdvancedColormap('AFM');
%colormap('pink');
%hold on;
%plot(xs,ys,'.r', 'MarkerSize', 20)
%hold off

% delete(h); %deletes plotted items from current plot
% refresh(h)
end

