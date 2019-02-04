function [ img, header, errmsg ] = readImage( filename )
%reakImage - read images 
global reply
reply = 0;
header_size_org = 2048;
r='';
img = 0;
errmsg = 'None';
header='';

fp = fopen(filename, 'r');
if fp == -1
   errmsg='File not found';
   return;
end

h = fread(fp, header_size_org, 'char');
h=setstr(h)';
header_size=getparameter(h, 'Data length',1);

frewind(fp);

header = fread(fp, header_size, 'char');
header = setstr(header)';

il=findstr(header, 'image list');
bs=findstr(header, '\*');
p=[];
for i=1:length(il)
  p=[p bs(max(find(bs<il(i))))];
end
p=[p find(header==26)];
p=unique(p);
nimages=length(p)-1;

if nimages==2
  type1=getparameter(header, 'Image data',1);
  type2=getparameter(header, 'Image data',2);
      answer = questdlg('|    Which one do you want to load? |', ...
        '', ...
        'Image1','Image2','Cancel');
    % Handle response
    switch answer
        case 'Image1'
            reply = 1;
        case 'Image2'
            reply = 2;
        case 'Cancel'
            reply = 0;
    end
elseif nimages>2
    type1=getparameter(header, 'Image data',1);
    type2=getparameter(header, 'Image data',2);
    type3=getparameter(header, 'Image data',3);
            answer = questdlg('|    Which one do you want to load? |', ...
        '', ...
        'Image1','Image2','Image3','Cancel');
    % Handle response
    switch answer
        case 'Image1'
            reply = 1;
        case 'Image2'
            reply = 2;
        case 'Image3'
            reply = 3;
        case 'Cancel'
            reply = 0;
    end
end
    
    

if reply==0
  fclose(fp);
  return;
elseif reply==1
    ni=1;
elseif reply==2
    ni=2;
elseif reply==3
    ni=3;
end
if nimages>1
  nh=[header(1:p(1)-1) header(p(ni):p(ni+1)-1)];
  header=[nh zeros(1,length(header)-length(nh))];
end

offset=getparameter(header, 'Data offset',inf);


s1=getparameter(header, 'Samps/line',inf);
if size(s1,2)==1
  s2=getparameter(header, 'Number of lines',inf);
  msize=[s1 s2];
else
  msize=s1;
end

fseek(fp, offset, -1);
img = fread(fp, msize, 'short', 'n');
img = rot90(img);

fclose(fp);

end

