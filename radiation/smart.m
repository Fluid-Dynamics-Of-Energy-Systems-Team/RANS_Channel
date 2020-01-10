function [ Sc ] = smart( I, ANG, n)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

Phalf   = ANG.Phalf;
Ppi     = ANG.Ppi;
Pthree  = ANG.Pthree;
nT      = ANG.nT;
nP      = ANG.nP;

Sc = zeros(n+1,5,5,nT,nP);

 % bottom south west
 for m=1:Phalf
    for l=1:nT
        Sc = smart_tot(I,Sc,ANG,-1,l,m,n);
    end
 end
 % bottom south east
 for m=Phalf+1:Ppi
    for l=1:nT
        Sc = smart_tot(I,Sc,ANG,+1,l,m,n);
    end
 end
 % bottom north east
 for m=Ppi+1:Pthree
    for l=1:nT
        Sc = smart_tot(I,Sc,ANG,+1,l,m,n);
    end
 end
 % bottom north west
 for m=Pthree+1:nP
    for l=1:nT
        Sc = smart_tot(I,Sc,ANG,-1,l,m,n);
    end
 end
 
end


function Sc = smart_tot(I,Sc_old,ANG,IX,l,m,n)

Sc = Sc_old;

for k = 3:3
    for j = 3:3
        for i = 3:n-1
            IP = I(i,j,k,l,m);
            IIX = 2*IX;
            
            OX = -IX;
            
            xO  = ANG.y(i+OX);
            xP  = ANG.y(i);
            xI  = ANG.y(i+IX);
            xII = ANG.y(i+IIX);
            
            if IX == -1
                xFI = ANG.yu(i+IX);
                xFP = ANG.yu(i);
            elseif IX ==1
                xFI= ANG.yu(i);
                xFP= ANG.yu(i-IX);
            end
            IXI  = I(i+IX ,j,k,l,m);
            IXII = I(i+IIX,j,k,l,m);
            IXO  = I(i+OX ,j,k,l,m);
            
            xiPI = (xI - xII)/(xP - xII);
            xiFI = (xFI- xII)/(xP - xII);
            xiPP = (xP  - xI)/(xO  - xI);
            xiFP = (xFP - xI)/(xO  - xI);
            
            aXI = (xiFI - xiPI^2)/(xiPI*(1-xiPI));
            aXP = (xiFP - xiPP^2)/(xiPP*(1-xiPP));
            bXI = (xiPI - xiFI)/(xiPI*(1-xiPI));
            bXP = (xiPP - xiFP)/(xiPP*(1-xiPP));
            
            phiXI = (IXI-IXII)/(IP-IXII);
            if IP==IXII
                phiXI = 0;
            end
            phiXP = (IP - IXI)/(IXO-IXI);
            if IXO==IXI
                phiXP = 0;
            end
                       
            phifXI = max(phiXI,phiXI*(aXI+bXI*phiXI));
            phifXP = max(phiXP,phiXP*(aXP+bXP*phiXP));
            
            if (phifXI > 1) && (phiXI < 1)
                phifXI=1;
            end
            if (phifXP > 1) && (phiXP < 1)
                phifXP=1;
            end
            
            Sc(i,j,k,l,m) = + ANG.Ax(l,m)  *(phifXP-phiXP)*(IXO- IXI) ...
                - ANG.Ax(l,m)  *(phifXI-phiXI)*(IP -IXII);

        end
    end
end
for j=1:5
    for k=1:5
        Sc(:,j,k,l,m) = Sc(:,3,3,l,m);
    end
end

end
