function q = calcSpectrumSlope(im, pSize)

    % offset
    [im_height, im_width] = size(im);
    offset = (pSize - 1)/2;

    % coord. cartesianas -> coord. polares
    [x, y] = meshgrid(1:offset, 1:offset);
    [~,rho] = cart2pol(x,y);
    rho = round(rho,2);
    unicRho = unique(rho);
    
    % normaliza patch
    im_col = im2col(im, [pSize, pSize]);
    im_col = bsxfun(@rdivide, im_col, sum(im_col));
    
    % calcula spectrum slope
    N = size(im_col,2);
    q = zeros(1, N);
    for i=1:N
        % retangulo do patch 
        patch = reshape(im_col(:,i), [pSize, pSize]);
        
        % potencia espectral
        S = abs(fft2(patch));
        S = (S(1:offset,1:offset).^2)/(offset^2);
        
        % pot. espectral média para cada rho
        J_w = zeros(1,length(unicRho));
        for j=1:length(unicRho)
            idxs = rho == unicRho(j);
            J_w(j) = sum(S(idxs))/length(idxs); 
        end
        
        % calculo da feature
        log_J_w = log(J_w);
        idx = ~(isnan(log_J_w) + isinf(log_J_w)); 
        q(i) = sum(log_J_w(idx));
    end
    
    q = reshape(q, [im_height-pSize+1, im_width-pSize+1]);
    q = padarray(q, [offset, offset], 'replicate');
end