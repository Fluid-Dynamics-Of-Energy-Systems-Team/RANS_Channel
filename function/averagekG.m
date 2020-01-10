function [ kG ] = averagekG(wvl,wvr,wvc,wq,kq,Tdns,Tnb)
%AVERAGEKG Summary of this function goes here
%   Detailed explanation goes here
    ktemp = zeros(length(Tnb),1);
    % calculating the integral for each temperature
    for t=1:length(Tnb)
        num = 0;
        den = 0;
        for nb = 1:length(wvl)
            for g = 1:length(wq)
                num = num + (wvr(nb) - wvl(nb))*wq(g)*kq(g,nb,t)^2/7*atan(7./kq(g,nb,t))*I_black(wvc,Tnb(t));
                den = den + (wvr(nb) - wvl(nb))*wq(g)*kq(g,nb,t)/7*atan(7./kq(g,nb,t))*I_black(wvc,Tnb(t));
            end
        end
        ktemp(t) = num/den;
    end
    kG = interp1(Tnb,ktemp,Tdns,'spline');
end

