function [nm1,nm2]=ind2nm(ind1,ind2)
%IND2NM Converts the matrix indexes into coordinates (nm).
%
%	NM=IND2NM(IND)
%
%	INDs are the vector of the matrixes x-y indexes.
%	NMs  are the vector of the indexes espressed in nm;
%
%	See also NM2IND
%
%	Claudio Apr 15, 1995
%

%
% Copyright (c) 1995 by Claudio Rivetti and Mark Young
% claudio@alice.uoregon.edu,    mark@alice.uoregon.edu
%

global I H

ss=scansize(H);
%xoff = xoffset(H);
%yoff = yoffset(H);
px=size(I,1);

nm1=(ind1)*ss/px - (ss/px)/2; %+xoff - (ss/px)/2;
nm2=(ind2)*ss/px - (ss/px)/2; %+yoff - (ss/px)/2;
return;
