function q = calcHeavyTailedness(img, pSize)

    [img_height, img_width] = size(img);
    offset = (pSize - 1)/2;

    % gradiente
    [dx, dy] = gradient(img);    
    mag = sqrt(dx.^2 + dy.^2);
    
    % gradiente em colunas
    patches = im2col(mag, [pSize, pSize]);
    patches_dup = [patches; -patches];

    num = size(patches, 2);
    sigma = zeros(1, num);
    options = statset('MaxIter',100);
    parfor i = 1 : num
        %GMModel = fitgmdist(patches_dup(:,i),2,'Options',options,'RegularizationValue',0.01);
        GMModel = gmdistribution.fit(patches_dup(:,i),2,'Options',options,'RegularizationValue',0.01);
        sigma(i) = GMModel.Sigma(1);
        if GMModel.Sigma(2) > GMModel.Sigma(1)
           sigma(i) = GMModel.Sigma(2); 
        end
    end

    % coloca em um range maior de valores
    if max(max(sigma)) < 0.099
       sigma = sigma*10; 
    end
    
    q = reshape(sigma, [img_height-pSize+1, img_width-pSize+1]);
    q = q(4:img_height-pSize+1-3, 4:img_width-pSize+1-3);
    q = padarray(q, [offset+3, offset+3], 'replicate');
end