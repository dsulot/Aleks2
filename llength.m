function len=llength(x,y,z)
%LLENGTH Length of a line.
%
%        LLENGTH(X,Y,Z) return the length of the line 
%        described by X Y and Z.
%        The length is calculated as the sum of the
%        distances between two consecutive points.
%        
%        Claudio 6 September 1994.
%

%
% Copyright (c) 1995 by Claudio Rivetti and Mark Young
% claudio@alice.uoregon.edu,    mark@alice.uoregon.edu
%

if nargin==2
	z=x*0;
end

if length(x) ~= length(y) | length(x) ~= length(z) 
  error('Vectors must have the same length.')
end

n=length(x);
xi  = x(1:n-1);
xii = x(2:n);
yi  = y(1:n-1);
yii = y(2:n);
zi  = z(1:n-1);
zii = z(2:n);
len = sum(sqrt((xi-xii).^2 + (yi-yii).^2 + (zi-zii).^2)); 

return;

