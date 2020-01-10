function [case_in, tot] = calcdiff(case_in, tot)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


case_in.SA.diffT      = norm(case_in.SA.T      - case_in.SA.Tdns);
case_in.V2F.NO.diffT  = norm(case_in.V2F.NO.T  - case_in.SA.Tdns);
case_in.V2F.DWX.diffT = norm(case_in.V2F.DWX.T - case_in.SA.Tdns);
case_in.V2F.RAD.diffT = norm(case_in.V2F.RAD.T - case_in.SA.Tdns);

case_in.SA.diffA      = norm(case_in.SA.at      - case_in.SA.atdns);
case_in.V2F.NO.diffA  = norm(case_in.V2F.NO.at  - case_in.SA.atdns);
case_in.V2F.DWX.diffA = norm(case_in.V2F.DWX.at - case_in.SA.atdns);
case_in.V2F.RAD.diffA = norm(case_in.V2F.RAD.at - case_in.SA.atdns);

case_in.SA.diffF      = norm(case_in.SA.THF      - case_in.SA.THFdns);
case_in.V2F.NO.diffF  = norm(case_in.V2F.NO.THF  - case_in.SA.THFdns);
case_in.V2F.DWX.diffF = norm(case_in.V2F.DWX.THF - case_in.SA.THFdns);
case_in.V2F.RAD.diffF = norm(case_in.V2F.RAD.THF - case_in.SA.THFdns);

tot.SA.T      = tot.SA.T      + case_in.SA.diffT;
tot.V2F.NO.T  = tot.V2F.NO.T  + case_in.V2F.NO.diffT;
tot.V2F.DWX.T = tot.V2F.DWX.T + case_in.V2F.DWX.diffT;
tot.V2F.RAD.T = tot.V2F.RAD.T + case_in.V2F.RAD.diffT;

tot.SA.A      = tot.SA.A      + case_in.SA.diffA;
tot.V2F.NO.A  = tot.V2F.NO.A  + case_in.V2F.NO.diffA;
tot.V2F.DWX.A = tot.V2F.DWX.A + case_in.V2F.DWX.diffA;
tot.V2F.RAD.A = tot.V2F.RAD.A + case_in.V2F.RAD.diffA;

tot.SA.F      = tot.SA.F      + case_in.SA.diffF;
tot.V2F.NO.F  = tot.V2F.NO.F  + case_in.V2F.NO.diffF;
tot.V2F.DWX.F = tot.V2F.DWX.F + case_in.V2F.DWX.diffF;
tot.V2F.RAD.F = tot.V2F.RAD.F + case_in.V2F.RAD.diffF;

end

