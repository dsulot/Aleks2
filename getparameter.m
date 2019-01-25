function [value] = getparameter(header, parameter, index)
%GETPARAMETER	Return the value of a specified header parameter. 
%
%	PARAMETERS: 1) The header from which to read the parameter value
%		    2) The parameter name as a string.
%		    3) If the parameter appears more than once, index specifies
%		       the "indexth" such parameter in the header (1, 2, 3, 4,....)
%
%	RETURN:     If found, return the parameter value as a string,
%		    a number, or a matrix, else return inf.
%
%		    
%	Claudio  6 May 1994.

%
% Copyright (c) 1995 by Claudio Rivetti and Mark Young
% claudio@alice.uoregon.edu,    mark@alice.uoregon.edu
%

er=nargchk(2,3,nargin);
if ~isempty(er)
  error(er);
end

value = inf;
v=[];
EOF = 26;
NEWLINE = 13;


if isempty(header)
  return;
end

cs=findstr(header, ': ');
nl=find(header == NEWLINE);

p1=findstr(upper(header), upper(['\' parameter ': ']));


if isempty(p1)
    parameter = strrep(parameter, ':', '');
    parameter = strrep(parameter, '\', '');
    parameter = strtrim(parameter);
    p1=findstr(upper(header), upper(['\' parameter ': ']));
end


if ~isempty(p1)
  str_value='';
  for i=1:length(p1)
	  p2=min(find(cs>p1(i)));
	  p3=min(find(nl>p1(i)));
	  p2=cs(p2)+2;
	  p3=nl(p3)-1;
	  str_value=str2mat(str_value, header(p2:p3));
  end
  str_value=str_value(2:size(str_value,1), :);
  
  if find((str_value < abs('.') | str_value > abs('9')) & str_value ~= abs(' ') & str_value ~= abs('-') & str_value ~= abs('e'))
  	v=str_value;
  else
    v=zeros(size(str_value,1),10)*nan;
	c=0;
    for i=1:size(str_value,1)
	  line = sprintf('vx = [%s];', str_value(i,:));
	  eval(line);
	  c=max(c, size(vx,2));
	  v(i,1:size(vx,2))=vx;
	end
	v=v(:,1:c);
  end
  
  if nargin==3 & ~isempty(v)
	index=min(index,size(v,1));
	v=v(index,:);
  end   
  
  value=v;
end
return

