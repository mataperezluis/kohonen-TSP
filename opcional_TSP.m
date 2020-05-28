close all;
clear all;
clc;

a=0.7;
v=250;
kt=0.8;
n2=0.7;
NN=0.1;
fil=3;
col=3;

n = 500;

x1 = rand(1,n);
x2 = rand(1,n);

figure(1)
plot(x1,x2,'+');
hold on;


theta = linspace(0,2*pi,2*n);
r =0.05;
w1=r.*cos(theta)+0.5;
w2=r.*sin(theta)+0.5;



plot(w1,w2,'or');
plot([w1 w1(1)],[w2 w2(1)],'k','linewidth',2); 
hold off
drawnow

for veces=1:500

for k=1:n

  
  F=(x1(k)-w1).^2+(x2(k)-w2).^2;
  [filas columnas]=find(F==min(min(F)));
  
  if(length(filas)!=1)
  filas=columnas(1);
  columnas=columnas(2);
  endif
  
  indice =sub2ind(size(w1),1,columnas);
  
    
  t= min(mod(([1:2*n]-indice),size(w1,2)),mod((indice-[1:2*n]),size(w1,2)));
  
  
  res=exp(-(t).^2/(2*v^2));
  var=w1;
  w1=w1+NN*res.*(x1(k)-w1);
  var2=w2;
  w2=w2+NN*res.*(x2(k)-w2);
  
 
endfor

if(v>0.1)
v=v*exp(-veces/10000);
endif

if(NN>0.001)
NN=NN*exp(-veces/100000);
endif

plot(x1,x2,'+');
hold on;
plot(w1,w2,'or');
plot([w1 w1(1)],[w2 w2(1)],'k','linewidth',2); 
hold off
title(['veces=' num2str(veces)]);
drawnow

endfor