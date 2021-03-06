clear all
clc
close all

% wczytanie pliku
filename = '010807.003';
[img, header, errmsg] = readImage(filename);
% img = img./max(img);
img=(img-min(img(:)))/(max(img(:))-min(img(:)));
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
img_crop = im2double(img_crop);
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

global kierunekx kieruneky

if abs(xp-xk)>abs(yp-yk)
    kierunek = 1; %(bardziej w x)
else
    kierunek = 2; % y
end

if xp-xk > 0
    kierunekx = 1; %dodatni
else
    kierunekx = 0; %ujemny
end

if yp-yk > 0
    kieruneky = 1; %dodatni
else
    kieruneky = 0; %ujemny
end



[xs,ys] = FindPath(xs,ys,xk,yk,img_crop,kierunekx, kieruneky);

[size_y, ~] = size(img_crop);

figure; imagesc(img_crop); 
c = AdvancedColormap('AFM');
colormap('pink');
hold on;
plot(xs,ys,'.r', 'MarkerSize', 20)
hold off

global H I
H = header;
I = img;

[X,Y] = ind2nm(xs,ys);
DnaLength = llength(X,Y)
% delete(h); %deletes plotted items from current plot
% refresh(h)