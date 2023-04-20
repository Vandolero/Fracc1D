function out=riesz1d_4(losdatos);

orden=losdatos.orden;
kxs=losdatos.kxs;
campo=losdatos.campo;

kern=-abs(kxs).^orden;
kern=(1i*kxs).^orden;

out=real(ifft(kern.*fft(campo)));

end