clear all
clc
close all

% wczytanie pliku
filename = 'D:\Mela\ALEX_NASZ\DominikaSulot\AFM obrazy DNA\DNA\080409.004';
[img, header, errmsg] = readImage(filename);

% wyœwietlanie obrazu AFM
figure; 
imagesc(img);
c = AdvancedColormap('AFM');
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

% wyœwietlanie przyciêtego obrazu w nowym oknie
figure; imagesc(img_crop); 
c = AdvancedColormap('AFM');
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

while xs(end) ~= xk && ys(end) ~= yk
    pa1 = img_crop(xs(end)+1, ys(end));
    pa2 = img_crop(xs(end)+1, ys(end)-1);
    pa3 = img_crop(xs(end), ys(end)-1);
    pa4 = img_crop(xs(end)-1, ys(end)-1);
    pa5 = img_crop(xs(end)-1, ys(end));
    pa6 = img_crop(xs(end)+1, ys(end)+1); 
    pa7 = img_crop(xs(end)-1, ys(end)+1);
    pa8 = img_crop(xs(end), ys(end)+1);
    points_around = [pa1, pa2, pa3, pa4, pa5, pa6, pa7, pa8];
    
    [val, ind] = max(points_around);
    
    
end




% delete(h); %deletes plotted items from current plot
% refresh(h)