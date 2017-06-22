function q = calcHeavyTailedness(img, pSize)

    [img_height, img_width] = size(img);
    offset = (pSize - 1)/2;

    % gradiente
    [dx, dy] = gradient(img);    
    mag = sqrt(dx.^2 + dy.^2);
    
    % gradiente em colunas
    patches = im2col(mag, [pSize, pSize]) + eps;
    patches_dup = [patches; -patches];

    num = size(patches, 2);
    sigma = zeros(1, num);
    options = statset('TolFun',1e-3);
    for i = 1 : num
        S = struct('mu',[0; 0],'Sigma',cat(3,[0.5],[0.0001]),'PComponents',[0.5 0.5]);
        GMModel = gmdistribution.fit(patches_dup(:,i),2,'Options',options,'Start',S);
        var1 = sqrt(GMModel.Sigma(1));
        var2 = sqrt(GMModel.Sigma(2));
        sigma(i) = var1;
        if var2 > var1
           sigma(i) = var2;
        end
    end
    
    q = reshape(sigma, [img_height-pSize+1, img_width-pSize+1]);
    q = q(4:img_height-pSize+1-3, 4:img_width-pSize+1-3);
    q = padarray(q, [offset+3, offset+3], 'replicate');
end