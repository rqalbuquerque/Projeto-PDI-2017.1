function generatesPRPlotFromTwoImages(pathGT, pathF, color)

    imF = imread(pathF);
    imGT = imread(pathGT);

    labels = im2bw(imGT, 0.5);
    labels = reshape(labels,1,size(imGT,1)*size(imGT,2));
    scores = double(imF)/255;
    scores = reshape(scores,1,size(imGT,1)*size(imGT,2));

    [Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scores, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
    plot(Xpr,Ypr,color), xlabel('Recall'); ylabel('Precision');
    title(['Precision-recall curve (AUC: ' num2str(AUCpr) ')']);

end