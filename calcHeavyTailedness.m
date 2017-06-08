function q = calcHeavyTailedness(im, pSize)

    [im_height, im_width] = size(im);
    offset = (pSize - 1)/2;

    % gradiente
    [dx, dy] = gradient(im);    
    mag = sqrt(dx.^2 + dy.^2);
    
    % gradiente em colunas
    mag_col = im2col(mag, [pSize, pSize]);
    mag_col_dup = [mag_col; -mag_col];

    num = size(mag_col, 2);
    sigma = zeros(1, num);
    options = statset('MaxIter',100);
    for i = 1 : num
        i/num
        GMModel = fitgmdist(mag_col_dup(:,i),2,'Options',options,'RegularizationValue',0.01);
        sigma(i) = GMModel.Sigma(1);
        if GMModel.Sigma(2) > GMModel.Sigma(1)
           sigma(i) = GMModel.Sigma(2); 
        end
    end

    q = reshape(sigma, [im_height-pSize+1, im_width-pSize+1]);
    q = q(4:im_height-pSize+1-3, 4:im_width-pSize+1-3);
    q = padarray(q, [offset+3, offset+3], 'replicate');
end