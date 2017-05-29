%% Fun��o que calcula o espectro de pot�ncia m�dio
%Entrada:
% mat         - regi�o de uma imagem (patch)
%Sa�da:
% tailedness  - valor m�dio do espectro de pot�ncia
%%
function avgPowerSpec = calcAvgPowerSpectrum(mat)

    num_elem = size(mat,1)*size(mat,2);
    avgPowerSpec = sum(sum(log(abs(fft2(mat)).^2))) / num_elem;

end