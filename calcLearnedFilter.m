function [q] = calcLearnedFilter(im, w)

    [im_height, im_width] = size(im);
    [num, nFilter] = size(w);
    pSize = sqrt(num);
    offset = (pSize - 1)/2;

    im_col = im2col(im, [pSize, pSize]);
    filtered = im_col' * w;
    
    q = cell(nFilter,1);
    for i = 1 : nFilter
        q{i} = padarray(reshape(filtered(:,i), [im_height-pSize+1, im_width-pSize+1]),[offset, offset], 'replicate');
    end

end