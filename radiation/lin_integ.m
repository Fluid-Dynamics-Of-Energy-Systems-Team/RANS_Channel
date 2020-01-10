function [ integ ] = lin_integ( y,x,n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    integ = 0;
    for i=1:n-1
       integ = integ + (y(i) + y(i+1)) * (x(i+1) - x(i)) * 0.5;
    end
end

