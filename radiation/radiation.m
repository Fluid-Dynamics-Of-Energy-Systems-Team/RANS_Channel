function [I, Sc] = radiation( T, kP, Sc, I_old, ANG, n )
%function [I] = radiation( T, kP, I_old, ANG, n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[Emiss] = setboundary(T,ANG,n);

Itemp  = boundary(Emiss,ANG,I_old,n);
Phalf   = ANG.Phalf;
Ppi     = ANG.Ppi;
Pthree  = ANG.Pthree;
Thalf   = ANG.Thalf;
nT      = ANG.nT;
nP      = ANG.nP;
small   = 1.e-11;
Sc    = zeros(n+1,5,5,ANG.nT,ANG.nP);
error   = -1000;
tolclam = 1e-3;

%while (error > tolclam || error < 0)
    
    error = -1000;
    %start from bottom south west corner
    for l = 1:Thalf
        for m=1:Phalf
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,-1,-1,-1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from bottom south east corner
    for l = 1:Thalf
        for m = Phalf+1:Ppi
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,+1,-1,-1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from bottom north east corner
    for l = 1:Thalf
        for m=Ppi+1:Pthree
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,+1,-1,+1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from bottom north west corner
    for l = 1:Thalf
        for m = Pthree:nP
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,-1,-1,+1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from top south west corner
    for l = Thalf+1:nT
        for m=1:Phalf
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,-1,+1,-1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from top south east corner
    for l = Thalf+1:nT
        for m = Phalf+1:Ppi
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,+1,+1,-1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from top north east corner
    for l = Thalf+1:nT
        for m = Ppi+1:Pthree
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,+1,+1,+1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    %start from top north west corner
    for l = Thalf+1:nT
        for m = Pthree+1:nP
            for i=2:n
                for j=3:3
                    for k=3:3
                        [num,deno] =  updateloop(Sc,-1,+1,+1,i,j,k,l,m,Itemp,kP,ANG,Emiss.media);
                        Itemp(i,j,k,l,m) = num/(deno+small);
                        error = max(error,abs((Itemp(i,j,k,l,m) - I_old(i,l,m))/(I_old(i,l,m)+small)));
                    end
                end
            end
        end
    end
    
    for k=1:5
        for j=1:5
            for i=2:n
                for l=1:nT
                    for m=1:nP
                        Itemp(i,j,k,l,m) = Itemp(i,3,3,l,m);
                    end
                end
            end
        end
    end
    
    Itemp = boundrad(Itemp,ANG,n);
    I_old(:,:,:) = Itemp(:,3,3,:,:);
    
%    Sc = smart(Itemp,ANG,n);
    
%    fprintf('inside radiation %e\n',error);

%end

I = I_old;

end


function [num,deno] = updateloop(Sc,IX,IY,IZ,i,j,k,l,m,Itemp,kP,ANG,Emedia)

IXI = Itemp(i+IX,j,k,l,m);
IYI = Itemp(i,j+IY,k,l,m);
IZI = Itemp(i,j,k+IZ,l,m);

Voldom = ANG.Vol(i)*ANG.dom(l,m);
deno1 = Voldom*kP(i);
num1 = deno1*Emedia(i,j,k);

num2  = ANG.Ay(i,l,m)*IYI + ANG.Az(i,l,m)*IZI + ANG.Ax(l,m)*IXI - Sc(i,j,k,l,m);
deno2 = ANG.Ay(i,l,m) + ANG.Az(i,l,m) + ANG.Ax(l,m);

num = num1+num2;
deno = deno1+deno2;
end

function [Emiss] = setboundary(T,ANG,n)

Phalf  = ANG.Phalf;
Pthree = ANG.Pthree;
nP = ANG.nP;
nT = ANG.nT;

for k=1:5
    for j=1:5
        for l=1:nT
            for m=Phalf+1:Pthree
                Eeast(j,k,l,m) = (1.0);
            end
            for m=1:Phalf
                Ewest(j,k,l,m) = (1./1.5+1)^4;
            end
            for m=Pthree+1:nP
                Ewest(j,k,l,m) = (1./1.5+1)^4;
            end
        end
    end
end
for k=1:5
    for j=1:5
        for i=2:n
            Emedia(i,j,k) = (T(i)/1.5+1)^4;
        end
    end
end

Emiss = struct('east',Eeast,'west',Ewest,'media',Emedia);

end

function [I_new] = boundary(Emiss,ANG,I_old,n)

nT     = ANG.nT;
nP     = ANG.nP;
Pthree = ANG.Pthree;
Phalf  = ANG.Phalf;

I_new = zeros(n+1,5,5,nT,nP);

for k=1:5
    for j=1:5
        for l=1:nT
            for m=1:Phalf
                I_new(1,j,k,l,m)=Emiss.west(j,k,l,m);
            end
            for m=Pthree+1:nP
                I_new(1,j,k,l,m)=Emiss.west(j,k,l,m);
            end
        end
    end
end

for k=1:5
    for j=1:5
        for l=1:nT
            for m=Phalf+1:Pthree
                I_new(n+1,j,k,l,m)=Emiss.east(j,k,l,m);
            end
        end
    end
end

for k=1:5
    for j=1:5
        for i=2:n
            for l=1:nT
                for m=1:nP
                    I_new(i,j,k,l,m) = I_old(i,l,m);
                end
            end
        end
    end
end


end

function I_new = boundrad(I_old, ANG, n)

I_new =I_old;

for k=1:5
    for j=1:5
        for l = 1:ANG.nT
            for m = ANG.Phalf+1:ANG.Pthree
                I_new(1,j,k,l,m) = I_old(2,j,k,l,m);
            end
            for m=1:ANG.Phalf
                I_new(n+1,j,k,l,m)=I_old(n,j,k,l,m);
            end
            for m=ANG.Pthree+1:ANG.nP
                I_new(n+1,j,k,l,m)=I_old(n,j,k,l,m);
            end
        end
    end
end
                
end
