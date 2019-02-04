function [scansize, unit]=scansize(header)
%SCANSIZE Return the image scan size

%
% Copyright (c) 1995 by Claudio Rivetti and Mark Young
% claudio@alice.uoregon.edu,    mark@alice.uoregon.edu
%


ss=getparameter(header, 'Scan size',1);
if isstr(ss)
	[scan_num,unit]=strtok(ss, ' ');
	scansize= str2num(scan_num);
else
	scansize=ss;
	unit='';
end

return
