function allPixels = concatAllImages(path)

    files = dir( [path '\*.jpg'] );
    files = char( files.name );

    allPixels = [];
    nFiles = size(files,1);
    for i=1:30
        im = [];
        im = imread([path '\' files(i,:)]);
        allPixels = [allPixels reshape(im,1,size(im,1)*size(im,2))];
    end
end