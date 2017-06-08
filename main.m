clc; clear;
debug = [2];

pathClean = 'tortoise-clean.tif';
pathBlured = 'tortoise-blured.tif';

imgClean = rgb2gray(imread(pathClean));
imgBlured = rgb2gray(imread(pathBlured));
maxHist = size(imgClean,1)*size(imgClean,2)/100;

if ~isempty(find(debug == 1))
    figure(1),imshow(imgClean);
    figure(2),imshow(imgBlured);
end

[GCx,GCy] = gradient(im2double(imgClean));
[GBx,GBy] = gradient(im2double(imgBlured));

dx_col = im2col(GCx, [11, patchsize]);

[N,edges] = histcounts(GCx, 'Normalization','probability');
%GMModelGCx = fitgmdist(,2);

if ~isempty(find(debug == 2))
    figure(3);
    subplot(2,1,1), histogram(GCx,'Normalization','pdf'), axis([-0.4 0.4 0 maxHist]), title('PDF of Grad. X of clean');
    subplot(2,1,2), histogram(GCy,'Normalization','pdf'), axis([-0.4 0.4 0 maxHist]), title('PDF of Grad. Y of clean');
    figure(4);
    subplot(2,1,1), histogram(GBx,'Normalization','pdf'), axis([-0.4 0.4 0 maxHist]), title('PDF of Grad. X of Blured');
    subplot(2,1,2), histogram(GBy,'Normalization','pdf'), axis([-0.4 0.4 0 maxHist]), title('PDF of Grad. Y of Blured');
end

s1 = 11;

[im_height, im_width] = size(imgClean);

