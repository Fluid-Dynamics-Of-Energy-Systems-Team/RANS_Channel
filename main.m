%**************************************************************************
%
% RANS solver for fully developed turbulent channel with varying properties
% 
%       Created on: Nov 22, 2017
%          Authors: Rene Pecnik         (R.Pecnik@tudelft.nl)
%                   Gustavo J. Otero R. (G.J.OteroRodriguez@tudelft.nl)
%                   Process & Energy Department, Faculty of 3mE
%                   Delft University of Technology, the Netherlands.
%       Literature: Otero et al., 2017. Heat and fluid flow
% Last modified on: Jan 07, 2018
%               By: Rene Pecnik 
%**************************************************************************
% 
close all
clear
clc

%--------------------------------------------------------------------------
%       Include folders
%--------------------------------------------------------------------------

addpath('mesh');                % functions for the mesh
addpath('function');            % functions for the solver
addpath('turbmodels');          % functions of the turbulence models
addpath('fluxmodels');          % functions of the turbulent flux models
addpath('radiation');           % functions for the radiative calculations

%% ------------------------------------------------------------------------
%
%    User defined inputs
%  ------------------------------------------------------------------------
%


% -----  choose turbulence model  -----
% 'Cess'... Cess, R.D., "A survery of the literature on heat transfer in 
%           turbulent tube flow", Tech. Rep. 8-0529-R24, Westinghouse, 1958.
% 'SA'  ... Spalart, A. and Allmaras, S., "One equation turbulence model for 
%           aerodynamic flows", Recherche Aerospatiale-French edition, 1994.
% 'MK'  ... Myong, H.K. and Kasagi, N., "A new approach to the improvement of
%           k-epsilon turbulence models for wall bounded shear flow", JSME 
%           Internationla Journal, 1990.
% 'SST' ... Menter, F.R., "Zonal Two equation k-omega turbulence models for 
%           aerodynamic flows", AIAA 93-2906, 1993.
% 'V2F' ... Medic, G. and Durbin, P.A., "Towards improved prediction of heat 
%           transfer on turbine blades", ASME, J. Turbomach. 2012.
% 'DNS' ... without turbulence model; k,e,u taken from DNS solution
% 'NO'  ... without turbulence model; laminar
turbMod = 'SST';


% -----  choose flux model  -----
% V2T - '1EQ'... Cess, R.D., "A survery of the literature on heat transfer in 
%           turbulent tube flow", Tech. Rep. 8-0529-R24, Westinghouse, 1958.
% DWX - '2EQ'  ... Spalart, A. and Allmaras, S., "One equation turbulence model for 
%           aerodynamic flows", Recherche Aerospatiale-French edition, 1994.
% NO  - 'PRT'  ... Myong, H.K. and Kasagi, N., "A new approach to the improvement of
%           k-epsilon turbulence models for wall bounded shear flow", JSME 
%           Internationla Journal, 1990.
turbPrT = 'NO';

% 0 ...  constant kP
% 1 ...  variable kP
% 2 ...  variable non-grey k
kPMod  = 0; 
% 0 ...  constant rho
% 1 ...  variable rho
% 2 ...  rho from DNS
varDens= 0;
underrelaxU=0.7;

% -----  compressible modification  -----
% 0 ... Conventional models without compressible modifications
% 1 ... Otero et al.
% 2 ... Catris, S. and Aupoix, B., "Density corrections for turbulence
%       models", Aerosp. Sci. Techn., 2000.  
compMod = 0;

% -----  solve energy equation  ----- %%
% 0 ... energy eq not solved, density and viscosity taken from DNS
% 1 ... energy eq solved with under relaxation underrelaxT 
solveEnergy = 1;
underrelaxT = 0.9;

% -----  solve radiation equation  ----- 
% 0 ... radiation eq not solved (non radiative channel)
% 1 ... radiation eq solved every stepRad energy equation iterations
% 2 ... radiative heat source taken from DNS calculations (radCase)
solveRad = 0;
radCase  = 'b';

% -----  choose Radiation model modification -----
% 0 ...  Conventional t2 - et equations
% 1 ...  Radiative source term in t2 and et equations
RadMod = 0;
stepRad  = 3;
% -----  channel height  -----
height = 2;

% -----  number of mesh points  -----
n = 200;
% -----  number of angular points  -----
nT     = 10;                    % number of polar angles
nP     = 20;                    % number of azimuthal angles
Tc     = 573;
Th     = 955;
T0     = 1.5;
Pr     = 1.0;
ReT    = 180;

% -----  discretization  -----
% discr = 'finitediff' ... finite difference discretization; 
%                          requires additional parameters: 
%                          fact ... stretching factor for hyperbolic tan 
%                          ns   ... number of stencil points to the left 
%                                   and right of central differencing
%                                   scheme. So, ns = 1 is second order.
% discr = 'chebyshev' ...  Chebyshev discretization
%                          Note, this discretization is very unstable.
%                          Therefore it is best to first start with second
%                          order finite difference scheme and then switch
discr = 'finitediff';

% -----  streching factor and stencil for finite difference discretization
fact = 5;
ns = 1;

% -----  Parameter definition
Pl  = 0.03;
Prt = ones(n,1)*1.0; 
b_old = -ones(n-2,1)*0.005;
b = b_old;
switch varDens
    case 0; casename = 'constant';
    case 1; casename = 'vardens';          
    case 2; casename = 'nodensity';
end

%% ------------------------------------------------------------------------
%
%      Generate mesh and angular mesh
%
[MESH] = mesh(height, n, fact, ns, discr);
[ANG]  = angmesh(nP,nT,MESH,n);                       % return angular mesh


%% ------------------------------------------------------------------------
%
%       Solve RANS 
%

u      = zeros(n,1);
uT     = zeros(n,1);
T      = 1 - MESH.y/height; 
T(1)   = 1;
T(end) = 0;

% radiative quantities
pathm    = strcat('solution/DNS/',radCase,'m');
pathf    = strcat('solution/DNS/',radCase,'f');
pathc    = strcat('solution/DNS/',radCase,'c');
pathk    = strcat('solution/DNS/',radCase,'k');
pathr    = strcat('solution/DNS/',radCase,'r');
Dm = importdata(pathm);
Df = importdata(pathf);
Dc = importdata(pathc);
Dk = importdata(pathk);
Dr = importdata(pathr);
%DNSt=importdata('profProp');
if solveRad == 1 
    I     = zeros(n+1,nT,nP);
    QR    = zeros(n,1);
    Em    = zeros(n,1);
    G    = zeros(n,1);
    qy    = zeros(n,1);
    QRint = zeros(n+1,1);
    Tint  = zeros(n+1,1);
    qyint = zeros(n+1,1);
    Sc    = zeros(n+1,5,5,nT,nP);
    kPint = interp1(Dm(:,1),Dm(:,9),ANG.y,'spline');
    kP    = interp1(Dm(:,1),Dm(:,9),MESH.y,'spline');
elseif solveRad == 2
     if (kPMod == 2) || (kPMod == 1)
        QR    = interp1(Dm(:,1),Dm(:,7),MESH.y,'spline');
        kP    = interp1(Dm(:,1),Dm(:,10),MESH.y,'spline');
        G     = interp1(Dm(:,1),Dm(:,11),MESH.y,'spline');
        Em    = interp1(Dm(:,1),Dm(:,9 ),MESH.y,'spline');
    else
        QR    = interp1(Dm(:,1),Dm(:,7),MESH.y,'spline');
        Em    = interp1(Dm(:,1),Dm(:,8),MESH.y,'spline');
        G     = interp1(Dm(:,1),Dm(:,10),MESH.y,'spline');
        kP    = interp1(Dm(:,1),Dm(:,9),MESH.y,'spline');
    end
    qy    = interp1(Df(:,1),Df(:,2),MESH.y,'spline')...
          - interp1(Df(:,1),Df(:,3),MESH.y,'spline');
else
    QR    = zeros(n,1); 
    kP    = interp1(Dm(:,1),Dm(:,9),MESH.y,'spline');
    Em    = zeros(n,1);
    G     = zeros(n,1);
    qy    = zeros(n,1);
end

Tdns = (Th-Tc)*interp1(Dm(:,1),Dm(:,5),MESH.y,'spline')+Tc;

cP = zeros(1,6);
cP2= zeros(1,6);
if kPMod == 2
    abs1 = importdata(strcat('solution/DNS/planckmean','H2O')); %radCase));
    kG = interp1(abs1(:,1),abs1(:,2),MESH.y,'pchip');
    cP1  = polyfit(1./Tdns,kP,5);
    for i = 1:6
        cP(6-i+1) = cP1(i);
    end    
    cP2t  = polyfit(1./Tdns,kG,5);
    for i = 1:6
        cP2(6-i+1) = cP2t(i);
    end
elseif kPMod == 1
    cP   = [-0.23093, -1.12390*1e3, 9.41530*1e6, -2.99880*1e9, 0.51382*1e12, -1.8684e-05*1e15];
    kdns = cP(1) + cP(2)./(Tdns)+cP(3)./(Tdns.^2) + cP(4)./(Tdns.^3) + cP(5)./(Tdns.^4) + cP(6)./(Tdns.^5) ;
    Ck   = mean(kP./kdns);
    cP   = Ck*[-0.23093, -1.12390*1e3, 9.41530*1e6, -2.99880*1e9, 0.51382*1e12, -1.8684e-05*1e15];
    kG   = kP; 
    cP2  = cP;
else
    wvl = 0;
    wvr = 0;
    wvc = 0;
    wvq = 0;
    kq  = 0;
    Tnb = 0;
    kG   = kP;
end

Tdns = (Tdns -Tc)/(Th-Tc);

if (solveEnergy==0)  % transport properties
    r=ones(n,1); mu=ones(n,1)/ReT; T=zeros(n,1);
else
    [r, mu, alpha] = calcProp(T, Tdns, ReT, Pr, casename, T0);
end

% turbulent scalars
t2   = 0.1*ones(n,1); t2(1)= 0.1; t2(n)= 0.1;
k    = 0.1*ones(n,1); k(1) = 0.0; k(n) = 0.0;
e    = 0.001*ones(n,1);
et   = 0.001*ones(n,1);
v2   = 2/3*k;
om   = ones(n,1);
mut  = zeros(n,1);
alphat  = zeros(n,1);
nuSA = mu./r; nuSA(1) = 0.0; nuSA(n) = 0.0;

%% SOLVE THE EQUATIONS
%--------------------------------------------------------------------------
%
%       Iterate RANS equations
%
nmax   = 1000000;   tol  = 1.e-8;  % iteration limits
nResid = 50;                       % interval to print residuals

residual = 1e20; residualT = 1e20; residualQ = 1e20; iter = 0;


figure('Position',[1000 1000 800 600])
figure('Position',[50 1000 800 600])

while (residual > tol || residualT > tol || residualQ > tol*1e3) && (iter<nmax)
 
    if(mod(iter,100)==0)
        figure(1)
        clf;
        plot(MESH.y,T,MESH.y,Tdns);
        figure(2)
        semilogy(iter/20,residualT,'bo','MarkerSize',6)
        ylim([1e-09 1])
        hold on
        pause(0.00001);
    end

    % Solve turbulence model to calculate eddy viscosity
    switch turbMod
        case 'V2F';   [k,e,v2,mut] = V2F(u,k,e,v2,r,mu,MESH,compMod);
        case 'MK';    [k,e,mut]    = MK(u,k,e,r,mu,ReT,MESH,compMod,iter);
        case 'SST';   [k,om,mut]   = KOmSST(u,k,om,r,mu,MESH,compMod);
        case 'SA';    [nuSA,mut]   = SA(u,nuSA,r,mu,MESH,compMod);
        case 'Cess';  mut          = Cess(r,mu,ReT,MESH,compMod);
        case 'DNS';   [k,e,u,mut,r]= DNS(Dk,Dm,mu,ReT,MESH,kPMod);
        otherwise;	  mut          = zeros(n,1);
    end
    
    % Solve energy equation
    if (solveEnergy == 1)

        % Solve turbulent flux model to calculate eddy diffusivity 
        switch turbPrT
            case 'V2T'; [uT,lam] = V2T(uT,k,e,v2,mu,ReT,Pr,Pl,T,kP,r,MESH,RadMod);
            case 'PRT'; [lam,alphat] = PRT( mu,mut,alpha,T,r,qy,ReT,Pr,Pl,MESH,RadMod);
            case 'DWX'; [lam,t2,et,alphat] = DWX_nongrey(T,Em,G,r,u,t2,et,k,e,alpha,mu,kP,kG,ReT,Pr,Pl,MESH,RadMod,kPMod,cP,cP2,2.34,1.5,0.1,'P',Th,Tc,T0);
            otherwise;  lam = mu./Pr + (mut./0.9);   
        end
        T_old = T;
        
        % diffusion matrix: lam*d2phi/dy2 + dlam/dy dphi/dy
        A =    bsxfun(@times, lam, MESH.d2dy2) ... 
             + bsxfun(@times, MESH.ddy*lam, MESH.ddy);
         
         turbQ = MESH.ddy*uT;
         % source term: -Qt/RePr + duT/dy
         switch turbPrT
             case 'V2T'; b = QR(2:n-1)./(ReT*Pr*Pl) + turbQ(2:n-1);
             otherwise;  b = QR(2:n-1)./(ReT*Pr*Pl);
         end
         
         % Solve
         T = solveEq(T,A,b,underrelaxT);
         
         residualT = norm(T - T_old);
                 
         if (solveRad == 1)
             Tint(2:n)                = interp1(MESH.y,T,ANG.y(2:n),'spline');
             Tint(1) = T(1);
             if (mod(iter,stepRad) == 0)
                 Q_old                = QR;
                 [I, Sc]              = radiation(Tint,kPint,Sc,I,ANG,n);
                 [QRint, qyint, Gint] = radint(I,ANG,kP,Tint,n);
                 QR                   = interp1(ANG.y(2:n),QRint(2:n),MESH.y,'spline');
                 qy                   = interp1(ANG.y(2:n),qyint(2:n),MESH.y,'spline');
                 G                    = interp1(ANG.y(2:n),Gint(2:n) ,MESH.y,'spline');
                 Em                   = QR./kP + G;
                 residualQ            = norm(QR-Q_old);
             end
         else
             residualQ = 0;
         end                  
    else
        residualT = 0;
    end

    if strcmp(turbMod,'DNS')==0
        
        % calculate density
        [r,mu,alpha] = calcProp(abs(T), Tdns, ReT, Pr, casename, T0);
         
        % Solve momentum equation:  0 = d/dy[(mu+mut)dudy] - rho fx
        mueff = mu + mut;
        
        % diffusion matrix: mueff*d2phi/dy2 + dmueff/dy dphi/dy
        A =   bsxfun(@times, mueff, MESH.d2dy2) ...
            + bsxfun(@times, MESH.ddy*mueff, MESH.ddy);
        
        % Right hand side
        %b = -ones(n-2,1);
        %bulk  = trapz(MESH.y,u)/2;
        b     = -ones(n-2,1);%(0.99*b_old + (bulk-1)*0.005);
        
        % Solve
        u_old = u;
        u = underrelaxU*u+(1-underrelaxU)*solveEq(u,A,b,1);
        residual = norm(u-u_old);
        
        b_old = b;
    else
        residual = 0;
    end
    
    % Printing residuals
    if (mod(iter,nResid) == 0)
        fprintf('%d\t%12.6e\t%12.6e\t%12.6e\n', iter, residual, residualT, residualQ);
    end

    iter = iter + 1;
end
fprintf('%d\t%12.6e\n\n', iter, residual);

fprintf('The residuals with this method is: %12.6e\n\n',norm(T-Tdns));

%% ------------------------------------------------------------------------
%
%       plot RANS results and compare with DNS
%
%  Plot function: plot_(...), plot_log() one side with log scale, and
%  plot_loglog(...) both side with log scale.
%  plotit_*(x,y,i,flagHold,style, xaxis, yaxis) 
%  x: x-axis variable, y: y-axis variable, i: figure numb, style: color-
% line type, xaxis: label x-axis, and yaxis: label y-axis

% For plots with latex style
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

y = MESH.y;

% %% ------------------------------------------------------------------------
% % plotting the velocity profiles
% 
% first calculate uplus (not really necessary, since utau = 1.0 already)
dudy   = MESH.ddy*u;
utau   = sqrt(mu(1)*dudy(1)/r(1));
upl    = u/utau;

ReTst  = ReT*sqrt(r/r(1))./(mu/mu(1));      % semi-local Reynolds number
ypl    = y*ReT;                             % yplus (based on wall units)
yst    = y.*ReTst;                           % ystar (based on semi-local scales)

% calculate van Driest velocity, uvd = int_0^upl (sqrt(r) dupl)
[uvd] = velTransVD(upl,r); 
    
% % calculate semi-locally scaled velocity, ustar (see Patel et al. JFM 2017)
% [ust] = velTransSLS(uvd, ReTst, MESH); 
% 
% figure(1); hold off 
% semilogx(yst(1:n/2),ust(1:n/2),'r-','LineWidth', 2); hold on
% 
% % analytic results for viscous sub-layer
% yp = linspace(0.1,13,100);
% semilogx(yp,yp,'k-.');
%     
% % semi-empirical result for log-layer
% yp = linspace(0.9,3,20);
% semilogx(10.^yp, 1/0.41*log(10.^yp)+5.0,'k-.');
% 
% 
% %% ------------------------------------------------------------------------
% % plotting the temperature profiles
% 
% if solveEnergy == 0; return; end  % only plot if energy has been solved for
% 
% thcon = ones(n,1);              % thermal conductivity k/Pr/Re = 1
% dTdy  = MESH.ddy*T;
% qw    = thcon(1)*dTdy(1);
% Ttau  = qw/(r(1)*1.0*utau);     % Note, Cp=1
% Tplus = (T-T(1))/Ttau;
% 
% % van Driest transformation (same as velocity)
% [Tvd]    = velTransVD(Tplus, r);
% 
% % Extended van Driest transformation (same as velocity)
% [Tst]  = velTransSLS(Tvd, ReTst, MESH);
% 
% figure(2); hold off 
% semilogx(yst(1:n/2),Tst(1:n/2),'r-','LineWidth', 2); hold on

%% ------------------------------------------------------------------------
% plotting the DNS profiles
% 
if strcmp(turbPrT,'NO')
    alphat = mut./0.9;
end
alphatd = Df(:,2)./(-Df(:,3))/ReT; 

THF     = alphat.*(-MESH.ddy*T);
if strcmp(turbPrT,'V2T')
    THF = uT;
end


figure(3); hold off
plot(y,T); hold on
plot(y,Tdns);

figure(4); hold off
plot(y,THF); hold on
plot(Df(:,1),Df(:,2)); 

figure(5); hold off
plot(y,alphat); hold on
plot(Df(:,1),alphatd);

THFdns = interp1(Df(:,1),Df(:,2),y,'pchip');
alphatdns = interp1(Df(:,1),alphatd,y,'pchip');

%% Calculation of conductive heat transfer

CHF = alpha.*(-MESH.ddy*T);
CHFD = alpha.*(-MESH.ddy*Tdns);
diff = (CHF - CHFD)./CHFD;

fprintf('The HF in this case is: %12.6e %12.6e\n\n',diff(1),diff(end));

%% Calculation of the Nusselt number

udns = interp1(Dm(:,1),Dm(:,4),MESH.y,'spline');
Tb = trapz(y,Tdns.*udns)/trapz(y,udns);

Nu = -1./(Tb - 1).*interp1(MESH.y,CHFD,0.5,'spline');
fprintf('The Nusselt number in this case is: %12.6e\n\n',Nu);

%% ------------------------------------------------------------------------
%plotting the DNS profiles

if strcmp(turbPrT,'DWX') || strcmp(turbPrT,'PRT') || strcmp(turbPrT,'V2T')
    switch RadMod
        case 1;   string = strcat('solution/',turbMod,'-',turbPrT,'/',radCase,'_','rad');
        case 0;   string = strcat('solution/',turbMod,'-',turbPrT,'/',radCase);
    end
else
    string = strcat('solution/',turbMod,'-',turbPrT,'/',radCase);
end
fid = fopen(string,'w');
for i=1:n
    fprintf(fid,'%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\t%20.10f\n',...
        y(i),u(i),T(i),QR(i),G(i),qy(i),mut(i),alphat(i),THF(i),k(i),e(i),v2(i),t2(i),et(i));
end
fclose(fid);



