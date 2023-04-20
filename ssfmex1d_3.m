function out=ssfmex1d_3(losdatos);

uo=losdatos.campo;
z=losdatos.z;
x=losdatos.x;
kxs=losdatos.kxs;
orden=losdatos.orden;
kx2s=losdatos.kx2s;
dx=losdatos.dx;

dz=dx.^2/4; zfinal=z;
pasos=ceil(zfinal/dz);
N=length(uo);
%---------------


utotal=zeros(N,pasos+1);utotal(:,1)=uo;
un=uo;

for cuenta=1:1:pasos

  F_NL=fft(exp(1i*dz*abs(un).^2).*un);
  F_D= exp(1i*(-abs(kxs).^orden)*dz/2).*F_NL;
  un=ifft(F_D);
  utotal(:,cuenta)=un;
    
end

figure(2);
[zz,tt]=size(utotal);
tvec=(1:1:zz)*dx;
tvec=tvec-max(tvec)/2;
zvec=(1:1:tt)*dz;
imagesc(zvec,tvec,abs(utotal)); colorbar;
xlabel('z, distancia'); ylabel('t, tiempo');

figure(1);
plot(x,abs(uo),x,abs(un),'r');
legend('Campo inicial','Campo final');
ylabel('Amplitud'); xlabel('tiempo');

end