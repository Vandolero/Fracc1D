function out=generadatos1d_1(losdatos);
% Definción de parámetros en 1d

% Puntos y longitud
Nx= 2^8;   
Lx=20;       

% delta en espacio y Fourier
dx = Lx/Nx; 
dkx = 2*pi/Lx;

%vectores en x y kx, además el kx en shift.
gral_space_x=linspace(-Nx/2,Nx/2-1,Nx); 
x =gral_space_x*dx;                     
kx= gral_space_x*dkx;                    
kx2 =kx.^2;
kxs= fftshift(kx);
kx2s= fftshift(kx2);

% se anexan a la estructura de datos.
losdatos.x=x;
losdatos.kx=kx;
losdatos.kx2=kx2;
losdatos.kxs=kxs;
losdatos.kx2s=kx2s;
losdatos.dx=dx;

out=losdatos;
end