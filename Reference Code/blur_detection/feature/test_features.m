clc; clear;
debug = 0;

pathClean = 'tortoise-clean.tif';
pathBlured = 'tortoise-blured.tif';

imgClean = rgb2gray(im2double(imread(pathClean)));
imgBlured = rgb2gray(im2double(imread(pathBlured)));

%figure(1),imshow(LocalKurtosis(imgClean,11));
%figure(2),imshow(LocalKurtosis(imgBlured,11));

%figure(1),imshow(GradientHistogramSpan(imgClean,11));
%figure(2),imshow(GradientHistogramSpan(imgBlured,11));

%ghB = GradientHistogramSpan(imgBlured,11);
%ghC = GradientHistogramSpan(imgClean,11);

%load('../learned_linear_filter.mat');
%qf = LocalLearnedFilter(imgBlured, W_11(:,1:5));
%figure(2),imshow(qf{1,1}, [min(min(qf{1,1})) max(max(qf{1,1}))]);