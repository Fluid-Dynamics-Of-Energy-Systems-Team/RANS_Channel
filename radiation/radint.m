function [ QRint, qyint, Gint ] = radint( I, ANG, kP, Tint, n )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

QRint= zeros(n+1,1);
Gint = zeros(n+1,1);
qyint= zeros(n+1,1);
for i=2:n
    int4=0.;
    int5=0.;
    for l=1:ANG.nT
        for m=1:ANG.nP
            int4=int4+I(i,l,m)*ANG.dom(l,m);
            int5=int5+I(i,l,m)*ANG.sx(l,m);
        end
    end
    Gint(i)=int4/(pi);
    QRint(i)=kP(i)*(4.0*(Tint(i)/1.5+1).^4 - Gint(i));
    qyint(i)=int5/pi;
end


end

