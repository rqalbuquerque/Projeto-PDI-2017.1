%% Função que calcula o espectro de potência médio
%Entrada:
% mat         - região de uma imagem (patch)
%Saída:
% tailedness  - valor médio do espectro de potência
%%
function avgPowerSpec = calcAvgPowerSpectrum(mat)

    num_elem = size(mat,1)*size(mat,2);
    avgPowerSpec = sum(sum(log(abs(fft2(mat)).^2))) / num_elem;

end