function q = calcSpectrumSlope(img, pSize)

    % offset
    [img_height, img_width] = size(img);
    offset = (pSize - 1)/2;

    % coord. cartesianas -> coord. polares
    [x y] = meshgrid(1:offset, 1:offset);
    [~,rho] = cart2pol(x,y);
    rho = round(rho);
    unicRho = unique(rho);
    
    % arredondamento utilizado no projeto original
    lC_log = log(unicRho);
    lC_log_new = unique(round(lC_log / 0.2)*0.2);
    
    % normaliza patch
    patches_col = im2col(img, [pSize, pSize]);
    patches_col = bsxfun(@rdivide, patches_col, sum(patches_col));
    
    % calcula spectrum slope
    N = size(patches_col,2);
    q = zeros(1, N);
    for i=1:N
        % retangulo do patch 
        patch = reshape(patches_col(:,i), [pSize, pSize]);
        
        % potencia espectral
        [height width] = size(patch);
        S = abs(fft2(patch, height, width));
        S = (S(1:offset,1:offset).^2)/(offset^2);
        
		J_w = calculateSf(S,unicRho,rho);
		
        J_w_aux = zeros(size(lC_log_new));
        idx = 0;
        for j = 1:length(J_w)
            if(lC_log(j) >= lC_log_new(idx+1))
                idx = idx+1;
            end
            J_w_aux(idx) = J_w_aux(idx)+J_w(j);
        end

        % calculo da feature
        log_J_w = log(J_w_aux(1:end-1));
        idx = ~(isnan(log_J_w) + isinf(log_J_w)); 
        q(i) = sum(log_J_w(idx));
    end
    
    q = reshape(q, [img_height-pSize+1, img_width-pSize+1]);
    q = padarray(q, [offset, offset], 'replicate');
end