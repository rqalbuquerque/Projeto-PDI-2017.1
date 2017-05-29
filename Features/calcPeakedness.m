%% Função que calcula a medida de Peakedness
%Entrada:
% mat        - região de uma imagem (patch)
%Saída:
% peakedness - valor de Peakedness
%%
function peakedness = calcPeakedness(mat)
    
    num_elem = size(mat,1)*size(mat,2);
    [Bx,By] = gradient(mat);
    array_Bx = reshape(Bx,[1 num_elem]);
    array_By = reshape(By,[1 num_elem]);
    peakedness = min(log(kurtosis(array_Bx)), log(kurtosis(array_By)));
    
end