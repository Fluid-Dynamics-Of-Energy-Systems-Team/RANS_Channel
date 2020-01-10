%% Test the velocity transformation
close all; 
clear all;

%--------------------------------------------------------------------------
%       Include folders
%--------------------------------------------------------------------------

addpath('mesh');                % functions for the mesh
addpath('function');            % functions for the solver
addpath('turbmodels');          % functions of the turbulence models
addpath('fluxmodels');          % functions of the turbulent flux models
addpath('radiation');           % functions for the radiative calculations

% -----  channel height  -----
height = 2;

% -----  number of mesh points  -----
n = 200;

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
fact = 6;
ns = 1;

%% ------------------------------------------------------------------------
%
%      Generate mesh and angular mesh
%
[MESH] = mesh(height, n, fact, ns, discr);

%% START IMPORTING

ctb = importdata('solution/DNS/bm');
cth = importdata('solution/DNS/H2Om');
ct01= importdata('solution/DNS/t01rm');
ct1 = importdata('solution/DNS/t1rm');
ct10= importdata('solution/DNS/t10rm');

%%

cb(:,1) = ctb(:,1);
ch(:,1) = cth(:,1);
c01(:,1) = ct01(:,1);
c1(:,1) = ct1(:,1);
c10(:,1) = ct10(:,1);


y = MESH.y;

ub = interp1(cb(:,1) ,cb(:,4) ,y,'pchip');
uh = interp1(ch(:,1) ,ch(:,4) ,y,'pchip');
u01= interp1(c01(:,1),c01(:,4),y,'pchip');
u1 = interp1(c1(:,1) ,c1(:,4) ,y,'pchip');
u10= interp1(c10(:,1),c10(:,4),y,'pchip');

tvb  = (MESH.ddy*ub) /2800;
tv01 = (MESH.ddy*u01)/3750;
tv1  = (MESH.ddy*u1) /3750;
tv10 = (MESH.ddy*u10)/3750;
tvh  = (MESH.ddy*uh) /3750;

rb = ones(n,1);
r01= interp1(c01(:,1),c01(:,20),y,'pchip');
r1 = interp1(c1(:,1) ,c1(:,20) ,y,'pchip');
r10= interp1(c10(:,1),c10(:,20),y,'pchip');
rh = interp1(ch(:,1) ,ch(:,14) ,y,'pchip');

utb  = sqrt(tvb(1)/rb(1));
uth  = sqrt(tvh(1)/rh(1));
ut01 = sqrt(tv01(1)/r01(1));
ut1  = sqrt(tv1(1)/r1(1));
ut10  = sqrt(tv10(1)/r10(1));

ubVD  = velTransVD(ub./utb,rb);
uhVD  = velTransVD(uh./uth,rh);
u01VD = velTransVD(u01./ut01,r01);
u1VD  = velTransVD(u1./ut1,r1);
u10VD = velTransVD(u10./ut10,r10);

Reb = 2900*utb;
Reh = 3750*uth;
Re01 = 3750*ut01;
Re1 = 3750*ut1;
Re10 = 3750*ut10;

utsb  = sqrt(tvb(1)./rb);
utsh  = sqrt(tvh(1)./rh);
uts01 = sqrt(tv01(1)./r01);
uts1  = sqrt(tv1(1)./r1);
uts10  = sqrt(tv10(1)./r10);

Resb = 2900*utb*sqrt(rb/rb(1));
Resh = 3750*uth*sqrt(rh/rh(1));
Res01 = 3750*ut01*sqrt(r01/r01(1));
Res1 = 3750*ut1*sqrt(r1/r1(1));
Res10 = 3750*ut10*sqrt(r10/r10(1));

usb  = velTransSLS(ubVD,Resb,MESH);
ush  = velTransSLS(uhVD,Resh,MESH);
us01 = velTransSLS(u01VD,Res01,MESH);
us1  = velTransSLS(u1VD,Res1,MESH);
us10 = velTransSLS(u10VD,Res10,MESH);

ysb = y.*Resb;
ysh = y.*Resh;
ys01= y.*Res01;
ys1 = y.*Res1;
ys10= y.*Res10;

ypb = y.*Reb;
yph = y.*Reh;
yp01= y.*Re01;
yp1 = y.*Re1;
yp10= y.*Re10;

figure(1)
plot(ysb(1:end/2),usb(1:end/2),'k-','LineWidth',1.1);
hold on
plot(ysh(1:end/2),ush(1:end/2),'ro','Markersize',4);
plot(ys01(1:end/2),us01(1:end/2),'bd','Markersize',4);
plot(ys1(1:end/2),us1(1:end/2),'gs','Markersize',4);
plot(ys10(1:end/2),us10(1:end/2),'k^','Markersize',4);
set(gca,'xscale','log')
axis([3e-1 5e2 0 20]);

figure(2)
hold on
plot(yph(1:end/2),uhVD(1:end/2),'ro','Markersize',4);
plot(yp01(1:end/2),u01VD(1:end/2),'bd','Markersize',4);
plot(yp1(1:end/2),u1VD(1:end/2),'gs','Markersize',4);
plot(yp10(1:end/2),u10VD(1:end/2),'k^','Markersize',4);
set(gca,'xscale','log')
axis([3e-1 5e2 0 20]);

figure(3)
hold on
plot(yph(1:end/2),uh(1:end/2)/uth);
plot(yp01(1:end/2),u01(1:end/2)/ut01);
plot(yp1(1:end/2),u1(1:end/2)/ut1);
plot(yp10(1:end/2),u10(1:end/2)/ut10);
set(gca,'xscale','log')
axis([3e-1 5e2 0 20]);


%% DIAGNOSTIC FUNCTION

Dh = (MESH.ddy*uhVD)./Resh;
D01 = (MESH.ddy*u01VD)./Res01;
D1 = (MESH.ddy*u1VD)./Res1;
D10 = (MESH.ddy*u10VD)./Res10;

figure(4)
hold on
plot(ysh(1:end/2),Dh(1:end/2),'ro','Markersize',4);
plot(ys01(1:end/2),D01(1:end/2),'bd','Markersize',4);
plot(ys1(1:end/2),D1(1:end/2),'gs','Markersize',4);
plot(ys10(1:end/2),D10(1:end/2),'k^','Markersize',4);
%set(gca,'xscale','log','yscale','log')
set(gca,'yscale','log')

figure(5)
hold on
plot(y,Resb,'k-','LineWidth',1.1);
plot(y,Resh,'ro','Markersize',4);
plot(y,Res01,'bd','Markersize',4);
plot(y,Res1,'gs','Markersize',4);
plot(y,Res10,'k^','Markersize',4);
