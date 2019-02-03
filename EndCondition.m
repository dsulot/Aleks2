function [result] = EndCondition(xk,yk,x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
result= "false";
if ((x==xk) || (x==(xk-1)) || (x==(xk+1)))
    if (y==yk) || (y==(yk-1)) || (y==(yk+1))
        result="true";
    end

end

