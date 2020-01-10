function [ ANG ] = angmesh( nP , nT, MESH, n )

  diff=0.;
  thetaf(1) = 0.;
  thetaf(nT+1)= pi;
  
  theta(1)=thetaf(1);
  theta(nT+2)=thetaf(nT+1);

  dx = 1;
  dz = 1;
  
  
  % constructing the spatial grid
  for i = 1:n
      yu(i) = MESH.y(i);
  end
  y(1) = yu(1);
  for i=2:n
      y(i)= (yu(i) + yu(i-1))*0.5;
      dy(i) = yu(i) - yu(i-1);
  end
  y(n+1) = yu(end);
  
  % constructing the angular grid
  for l=2:nT
   diff = (l-1)./(nT);
   thetaf(l) = diff*pi;
  end
  for l=2:nT+1
   theta(l)= 0.5*(thetaf(l)+thetaf(l-1));
  end

  diff=0.;
  phif(1)=0.;
  phif(nP+1) = 2*pi;

  phi(1)=phif(1);
  phi(nP+2)=phif(nP+1);

  for m=2:nP
   diff=(m-1)./(nP);
   phif(m)=diff*2*pi;
  end
  for m=2:nP+1
     phi(m)=0.5*(phif(m)+phif(m-1));
  end

  % calculating areas and direction vectors
  for m=1:nP
      if phi(m+1)<pi/2
          Phalf=m;
      end
      if phi(m+1)<pi
          Ppi=m;
      end
      if phi(m+1)<pi*3/2
          Pthree=m;
      end
      term1 = cos(phif(m))-cos(phif(m+1));
      term2 = sin(phif(m+1))-sin(phif(m));
      term3 = phif(m+1)-phif(m);
      for l=1:nT
          if theta(l+1)<pi/2
              Thalf = l;
          end
          term4 = (thetaf(l+1)-thetaf(l))/2-(sin(2*thetaf(l+1))-sin(2*thetaf(l)))/4;
          term5=(cos(2*thetaf(l))-cos(2*thetaf(l+1)))/4;
          sx(l,m)= term2*term4;
          sz(l,m)= term1*term4;
          sy(l,m)= term3*term5;
          dom(l,m)=-(cos(thetaf(l+1))-cos(thetaf(l)))*term3;
      end
  end
  for m=1:nP
    for l=1:nT
      Ax(l,m)=abs(sx(l,m)*dx*dz);
      for i=2:n
         Ay(i,l,m)=abs(sy(l,m)*(dy(i))*dz);
         Az(i,l,m)=abs(sz(l,m)*(dy(i))*dx);
      end

    end
  end
  
  for i=2:n
      Vol(i) = dz*dx*dy(i);
  end
  ANG = struct('Ax',Ax,'Ay',Ay,'Az',Az,'dom',dom,'Vol',Vol,'Phalf',Phalf,...
      'Ppi',Ppi,'Pthree',Pthree,'Thalf',Thalf,'nP',nP,'nT',nT,'sx',sx,'y',y,'yu',yu,'dy',dy);

end

