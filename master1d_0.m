function master1d_0()
% Propagación de haces fraccionales en 1d
% orden=orden fraccional, lam= lambda de solitón
% distancia, distancia de propagación
% Control, variables que se manejan desde el código principal

z=10; lambda=1; orden=1.2;
losdatos=struct('z',z,'lambda',lambda,'orden',orden);

losdatos=generadatos1d_1(losdatos);
losdatos=petvia1d_2(losdatos);
ssfmex1d_3(losdatos);

end