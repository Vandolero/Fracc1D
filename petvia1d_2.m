function out=petvia1d_2(losdatos)

kx2s=losdatos.kx2s;
kxs=losdatos.kxs;
orden=losdatos.orden;
x=losdatos.x;
lambda=losdatos.lambda;
dx=losdatos.dx;

% Código de solucion para caso general
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comienza el método de Petviashvilli
Uo=exp(-x.^2);

% Inicialización de diversas variables


term1=(lambda+abs(kxs).^orden/2);
%term1=(lambda+kx2s/2);
%term1=fftshift(term1);

% Factor de convergencia del Petviashvili
factor1 =1.5;

% Evitar una posible división por cero.
Uo=real(Uo)+1e-20;

% Inicializar la variable del error.
error=1;

reptotales=100;
for rep=1:1:reptotales;
    
    %%%%%%%% *********** NONLINEAR TERM ********* %%%%%%%%%%%%%%%%%
    
    %R = NL_term(Uo);
     R = abs(Uo).^2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Uo_F=fft(Uo);
    term2 = Uo_F.*conj(Uo_F).*term1;
    term3 = fft(R.*Uo);
    term4 = term3.*conj(Uo_F);
    intnum = sum(sum(term2));
    intden = sum(sum(term4));
    M=abs(intnum/intden)+eps;
    FUo=M.^factor1.*term3./term1+eps;
    
    Un=ifft(FUo);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Se checa el valor de error obtenido
    
    error=abs(M-1);
    
        
    if error<1e-9  % Parámetro de error, ajusta a coveniencia.
        
        % Guardar solución obtenida y calculo de energía
        potencia=sum(abs(Un).^2)*dx;
        
        fprintf('\n¡El valor de lambda es %d!\n', lambda);
        fprintf('¡Convergencia alcanzada en %d iteraciones!\n', rep);
        fprintf('La energía del solitón es de %f\n',potencia);
        
        Ufinal=Un;
        u=Un;
        
    end
    
    if rep==reptotales % Máximo número de iteraciones, ajustar si es necesario.
        fprintf('\nConvergencia aún no alcanzada con lambda = %d\n', lambda)
        fprintf('Analizar la posibilidad de la inexistencia de tal solitón.\n');
    end
    
    Uo = Un;
    
end

losdatos.campo=Un;
out=losdatos;
end

