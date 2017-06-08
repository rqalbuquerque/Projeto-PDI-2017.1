function q = calcPeakedness(im, pSize)

    [im_height, im_width] = size(im);
    offset = (pSize - 1)/2;

    % gradiente
    [dx, dy] = gradient(im);

    % patches e normalização utilizada no projeto original
    dx_col = im2col(dx, [pSize, pSize]);
    dx_col = bsxfun(@rdivide, dx_col, sum(dx_col));
    dy_col = im2col(dy, [pSize, pSize]);
    dy_col = bsxfun(@rdivide, dy_col, sum(dy_col));

    % Kurtosis
    qx = moment(dx_col,4)./(moment(dx_col,2).^2);
    qy = moment(dy_col,4)./(moment(dy_col,2).^2);

    qx = reshape(qx, [im_height-pSize+1, im_width-pSize+1]);
    qy = reshape(qy, [im_height-pSize+1, im_width-pSize+1]);

    % preenche borda repetindo elementos
    qx = log(padarray(qx, [offset, offset], 'replicate'));
    qy = log(padarray(qy, [offset, offset], 'replicate'));

    qx(isnan(qx)) = min(min(qx(~isnan(qx))));
    qy(isnan(qy)) = min(min(qy(~isnan(qy))));

    q  = min(qx, qy);

end