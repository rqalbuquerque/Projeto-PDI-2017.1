function [q] = calcLearnedFilter(img, w)

    [img_height, img_width] = size(img);
    [num, nFilters] = size(w);
    pSize = sqrt(num);
    offset = (pSize - 1)/2;

    patches = im2col(img, [pSize, pSize]);
    filtered = patches' * w;
    
    q = cell(nFilters,1);
    for i = 1 : nFilters
        low = prctile(filtered(:,i), 5);
        high = prctile(filtered(:,i), 97);
        q{i} = padarray(reshape(filtered(:,i), [img_height-pSize+1, img_width-pSize+1]),[offset, offset], 'replicate');
        q{i}(q{i}<low) = low;
        q{i}(q{i}>high) = high;
    end

end