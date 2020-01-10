function [diff] = calcNus2(case_in)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    

    NuS = case_in.SA.CHF(1) +case_in.SA.CHF(end);
    NuD = case_in.SA.CHFdns(1)+case_in.SA.CHFdns(end);
    diff(1) = (NuS      - NuD     )/NuD*100;
    NuS = case_in.V2F.NO.CHF(1) +case_in.V2F.NO.CHF(end);
    NuD = case_in.V2F.NO.CHFdns(1)+case_in.V2F.NO.CHFdns(end);
    diff(2) = (NuS      - NuD     )/NuD*100;
    NuS = case_in.V2F.DWX.CHF(1) +case_in.V2F.DWX.CHF(end);
    NuD = case_in.V2F.DWX.CHFdns(1)+case_in.V2F.DWX.CHFdns(end);
    diff(3) = (NuS      - NuD     )/NuD*100;
    NuS = case_in.V2F.RAD.CHF(1) +case_in.V2F.RAD.CHF(end);
    NuD = case_in.V2F.RAD.CHFdns(1)+case_in.V2F.RAD.CHFdns(end);
    diff(4) = (NuS      - NuD     )/NuD*100;

    diff = abs(diff);
end

