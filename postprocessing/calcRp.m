function [S1, S2] = calcRp(CV1,CV2,case_in)

syms P R;

CD1 = 1.5;
CD2 = 0.9;
kappa = 0.39;
Cmu = 0.09;

%fun = @(R) CD1./(2*R).^(0.5) - CV1 + CD2*(2.*R).^(0.5) - kappa^2./(Cmu^(3./2))*CV2.*(2*R);
fun = @(R) CD1./(2*R).^(0.5) - CV1 + CD2 - kappa^2./(Cmu^(3./2))*CV2.*(2*R)^(0.5);

S1 = fzero(fun,0.5);
S2 = Cmu./CV2.*1./(2*S1).^(0.5);

Prtrans = case_in.mut./case_in.at;
Rrans   = case_in.t2./(2*(case_in.et - case_in.radt/2)).*case_in.e./case_in.k;

figure()
plot(case_in.y,Prtrans,case_in.y,case_in.y./case_in.y.*S2,case_in.y,case_in.y./case_in.y.*mean(Prtrans(15:end-15)));
figure()
plot(case_in.y,Rrans,case_in.y,case_in.y./case_in.y.*S1,case_in.y,case_in.y./case_in.y.*mean(Rrans(15:end-15)));

fun2 = @(R) CD1./(2*R).^(0.5) + CD2 - kappa^2./(Cmu^(3./2))*CV2.*(2*R).^(0.5);
fun3 = @(R,P) Cmu./(P.*(2.*R)^(0.5));

S1test = fun2(S1);
S2test = fun3(S1,S2);
end

