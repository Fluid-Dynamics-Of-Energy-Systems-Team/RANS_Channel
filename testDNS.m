
% close all; 
clear all;


set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');



addpath('mesh');                % functions for the mesh
addpath('function');            % functions for the solver
addpath('DNS_data');            % DNS data and function to read them


% cProp      ... constant properties: rho = 1; mu = 1/ReT
% cRets      ... constant semi-local Reynolds number, rho and mu variable
% gasLike    ... gas-like fluid behaviour
% liquidLike ... liquid-like fluid behaviour
casename = 'cRets';

height = 2;
n = 100;
discr = 'finitediff';
fact = 6;
ns = 1;


[MESH] = mesh(height, n, fact, ns, discr);
y = MESH.y;


[ReT,Qt,u_DNS,T_DNS,r_DNS,mu_DNS,mut_DNS,k_DNS,ruv_DNS,e_DNS] = readDNS(MESH,casename);
[ust,yst,uplus,yn,uvd,utau] = velTransformation(u_DNS,r_DNS,mu_DNS,MESH);
[Tst,Tplus,Tvd] = tempTransformation(T_DNS,1,r_DNS,mu_DNS,ones(n,1),utau,MESH);

Rets = sqrt(r_DNS)./mu_DNS;

% header of DNS data file (for more info see DNS file itself)
% rp,           y+,         y*,        Ret*,        Pr*,        rho,          mu,     lambda,    (1 - 8)
% u+,         <u+>,        uvd,          u*,        u*2,          T,         <T>,         T+,    (9 - 16)
% Tvd,          T*,  rho<u"u">,   rho<v"v">,  rho<w"w">,  rho<u"w">,  rho*<c"c">,  rho<u"c">,    (17 - 24)
% rho<w"c">,   eps,       tdif,        vdif.                                                     (25 - 32)
DNS = dlmread('DNS_data/constReTauStar.txt', '', 26, 0);
% constReTauStar

fs = 18;

figure(1); 
subplot(4,3,1); hold off; semilogx(DNS(:,3), DNS(:,9), 'ro', 'Markersize', 8); hold on; semilogx(y(1:end/2).*Rets(1:end/2), u_DNS(1:end/2), 'b', 'LineWidth', 2); title('u')
set(gca, 'fontsize', fs)

subplot(4,3,2); hold off; plot(DNS(:,1), DNS(:,6), 'rx', 'LineWidth', 2); hold on; plot(y, r_DNS, 'b', 'LineWidth', 2); title('rho')
set(gca, 'fontsize', fs)

subplot(4,3,3); hold off; plot(DNS(:,1), DNS(:,7), 'rx', 'LineWidth', 2); hold on; plot(y, mu_DNS, 'b', 'LineWidth', 2); title('mu')
set(gca, 'fontsize', fs)

subplot(4,3,6); hold off; plot(DNS(:,1), DNS(:,8), 'rx', 'LineWidth', 2); title('lambda');
set(gca, 'fontsize', fs)

subplot(4,3,4); hold off; semilogx(DNS(:,3), DNS(:,10), 'ro', 'Markersize', 8); hold on; semilogx(y(1:end/2).*Rets(1:end/2), u_DNS(1:end/2), 'b', 'LineWidth', 2); title('ufav')
set(gca, 'fontsize', fs)

subplot(4,3,5); hold off; semilogx(DNS(:,3), DNS(:,12), 'ro', 'Markersize', 8); hold on; semilogx(y(1:end/2).*Rets(1:end/2), ust(1:end/2), 'b', 'LineWidth', 2); title('ustar')
% subplot(3,3,5); hold off; plot(DNS(:,1), DNS(:,8), 'rx', 'LineWidth', 2);%  hold on; plot(y, mu_DNS, 'b', 'LineWidth', 2)
set(gca, 'fontsize', fs)

subplot(4,3,7); hold off; 
semilogx(DNS(:,3), DNS(:,16), 'ro', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), Tplus(1:end/2), 'b', 'LineWidth', 2); title('tplus')
set(gca, 'fontsize', fs)

subplot(4,3,8); hold off; 
semilogx(DNS(:,3), DNS(:,17), 'ro', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), Tvd(1:end/2)*ReT, 'b', 'LineWidth', 2); title('tvd')
set(gca, 'fontsize', fs)

subplot(4,3,9); hold off; 
semilogx(DNS(:,3), DNS(:,18), 'ro', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), Tst(1:end/2)*ReT, 'b', 'LineWidth', 2); title('tstar')
set(gca, 'fontsize', fs)

%---------------------------------
subplot(4,3,10); hold off; 
semilogx(DNS(:,3), 0.5*(DNS(:,19)+DNS(:,20)+DNS(:,21)), 'ro', 'Markersize', 8); hold on; 
semilogx(DNS(:,3), 0.5*DNS(:,6).*(DNS(:,26)+DNS(:,27)+DNS(:,28)), 'gx', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), r_DNS(1:end/2).*k_DNS(1:end/2), 'b', 'LineWidth', 2); title('TKE')
set(gca, 'fontsize', fs)

subplot(4,3,11); hold off; 
semilogx(DNS(:,3), DNS(:,30), 'ro', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), e_DNS(1:end/2), 'b', 'LineWidth', 2); title('eps')
set(gca, 'fontsize', fs)

subplot(4,3,12); hold off; 
semilogx(DNS(:,3), DNS(:,22), 'ro', 'Markersize', 8); hold on; 
semilogx(y(1:end/2).*Rets(1:end/2), ruv_DNS(1:end/2), 'b', 'LineWidth', 2); title('ruv')
set(gca, 'fontsize', fs)


