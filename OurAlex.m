clear all
clc
close all

% wczytanie pliku
filename = 'D:\Mela\ALEX_NASZ\DominikaSulot\AFM obrazy DNA\DNA\080409.004';
[img, header, errmsg] = readImage(filename);

% wy�wietlanie obrazu AFM
figure; 
imagesc(img);
c = AdvancedColormap('AFM');
colormap('pink');
hold on;

% liczba punkt�w jakie u�ytkownik zaznacza
PointsNumber = 2;

% tablice do przechowywania wsp�rz�dnych zaznaczonych punkt�w
x_crop = zeros(1,PointsNumber);
y_crop = zeros(1, PointsNumber);

% pobieranie wsp�rz�dnych i zaznaczanie punkt�w na wykresie
for i = 1:PointsNumber
    [x_crop(i), y_crop(i)] = ginput(1);
    h = plot(x_crop(i),y_crop(i),'.r', 'MarkerSize', 10);
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

% wy�wietlanie przyci�tego obrazu w nowym oknie
figure; imagesc(img_crop); 
c = AdvancedColormap('AFM');
colormap('pink');
hold on;

% wybieranie punktu pocz�tkowego i ko�cowego DNA
PointsNumber = 2;
x = zeros(1,PointsNumber);
y = zeros(1, PointsNumber);
for i = 1:PointsNumber
    [x(i), y(i)] = ginput(1);
    h = plot(x(i),y(i),'.r', 'MarkerSize', 12);
end
hold off;

% zaokr�glanie punkt�w do warto�ci ca�kowitych
x = round(x, 0);
y = round(y, 0);

xp = x(1); yp = y(1);
xk = x(2); yk = y(2); 

xs = xp;
ys = yp;

% while xs(end) ~= xk || ys(end) ~= yk
for i = 1:5000
    % punkty dooko�a zaznaczonego punktu
    max_point = findMaxPoint(xs, ys, img_crop);
    xs = [xs, max_point(1)];
    ys = [ys, max_point(2)];
end

[size_y, ~] = size(img_crop);

figure; imagesc(img_crop); 
c = AdvancedColormap('AFM');
colormap('pink');
hold on;
plot(xs,ys,'.r', 'MarkerSize', 20)
hold off

% delete(h); %deletes plotted items from current plot
% refresh(h)