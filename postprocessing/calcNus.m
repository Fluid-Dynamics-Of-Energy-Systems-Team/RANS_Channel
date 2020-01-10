function [diff] = calcNus(case_in)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    diff.N(1) = (case_in.SA.NuS      - case_in.SA.NuD     )/case_in.SA.NuD*100;
    diff.N(2) = (case_in.V2F.NO.NuS  - case_in.V2F.NO.NuD )/case_in.V2F.NO.NuD*100;
    diff.N(3) = (case_in.V2F.DWX.NuS - case_in.V2F.DWX.NuD)/case_in.V2F.DWX.NuD*100;
    diff.N(4) = (case_in.V2F.RAD.NuS - case_in.V2F.RAD.NuD)/case_in.V2F.RAD.NuD*100;
    
    fprintf('\nThis is the difference in Nusselt number\n');
    disp(diff.N);
    
    
    diff.T(1) = (sum(abs(case_in.SA.T-case_in.SA.Tdns)))/sum(case_in.SA.Tdns)*100;
    diff.T(2) = (sum(abs(case_in.V2F.NO.T-case_in.V2F.NO.Tdns)))/sum(case_in.V2F.NO.Tdns)*100;
    diff.T(3) = (sum(abs(case_in.V2F.DWX.T-case_in.V2F.DWX.Tdns)))/sum(case_in.V2F.DWX.Tdns)*100;
    diff.T(4) = (sum(abs(case_in.V2F.RAD.T-case_in.V2F.RAD.Tdns)))/sum(case_in.V2F.RAD.Tdns)*100;
    
    fprintf('\nThis is the difference in Temperature\n');
    disp(diff.T);
        
    diff.A(1) = (sum(abs(case_in.SA.at-case_in.SA.atdns)))/sum(case_in.SA.atdns)*100;
    diff.A(2) = (sum(abs(case_in.V2F.NO.at-case_in.V2F.NO.atdns)))/sum(case_in.V2F.NO.atdns)*100;
    diff.A(3) = (sum(abs(case_in.V2F.DWX.at-case_in.V2F.DWX.atdns)))/sum(case_in.V2F.DWX.atdns)*100;
    diff.A(4) = (sum(abs(case_in.V2F.RAD.at-case_in.V2F.RAD.atdns)))/sum(case_in.V2F.RAD.atdns)*100;
    
    fprintf('\nThis is the difference in Temperature\n');
    disp(diff.A);
            
    diff.F(1) = (sum(abs(case_in.SA.THF-case_in.SA.THFdns)))/sum(case_in.SA.THFdns)*100;
    diff.F(2) = (sum(abs(case_in.V2F.NO.THF-case_in.V2F.NO.THFdns)))/sum(case_in.V2F.NO.THFdns)*100;
    diff.F(3) = (sum(abs(case_in.V2F.DWX.THF-case_in.V2F.DWX.THFdns)))/sum(case_in.V2F.DWX.THFdns)*100;
    diff.F(4) = (sum(abs(case_in.V2F.RAD.THF-case_in.V2F.RAD.THFdns)))/sum(case_in.V2F.RAD.THFdns)*100;

    fprintf('\nThis is the difference in Temperature\n');
    disp(diff.F);

    diff.N = abs(diff.N);
    diff.A = abs(diff.A);
    diff.F = abs(diff.F);
end

