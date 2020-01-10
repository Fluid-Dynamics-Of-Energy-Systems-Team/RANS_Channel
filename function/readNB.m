function [ wvl,wvr,wvc,wq,kq,Tnb ] = readNB( nB,nQ,nT )
%READNB Summary of this function goes here
%   Detailed explanation goes here

Tnb = zeros(1,nT);
wvc = zeros(1,nB);
wvl = zeros(1,nB);
wvr = zeros(1,nB);
kq = zeros(nQ,nB,nT);

%% weights of the narrow-bands
wq = [0.09654009,0.09563872,0.09384440,0.09117387,0.08765209,0.08331193, ...
                0.07819389,0.07234580,0.06582222,0.05868409,0.05099806,0.04283589,0.03427387,0.02539207,0.01627439, ... 
                0.00701862];

%% importing the narrow-bands
for nb = 1:nB
    line = 1;
    file = sprintf("tables/NarrBand%d.txt",nb-1);
    temp = importdata(file);
    wvl(nb) = temp(line,1);
    wvr(nb) = temp(line,2);
    wvc(nb) = temp(line,3);
    line = line + 1;
    for t = 1:nT
        Tnb(t) = temp(line,1);
        line = line+1;
        g = 0;
        for k=1:6
            for j = 1:3
               g=g+1;
               kq(g,nb,t) = temp(line,j);
               if(g==nQ)
                   break;
               end
            end
            line = line+1;
            if(g==nQ)
                break;
            end
        end
    end

end

