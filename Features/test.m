clc; clear;
debug = 0;

%pathClean = 'tortoise-clean.tif';
%pathBlured = 'tortoise-blured.tif';

%imgClean = rgb2gray(im2double(imread(pathClean)));
%imgBlured = rgb2gray(im2double(imread(pathBlured)));

addpath('..\Reference Code\blur_detection\feature');
addpath('..\image');
load('learned_linear_filter.mat');

path = 'out_of_focus0015_cortada.jpg';
img = rgb2gray(im2double(imread(path)));

s1 = 11;
[qRef]=GradientHistogramSpan(img,s1);
[qNew]=calcHeavyTailedness(img,s1);

%figure(1),imshow(calcPeakedness(imgClean,11));
%figure(2),imshow(calcPeakedness(imgBlured,11));

%htc = calcHeavyTailedness(imgClean,11);
%qRef = LocalPowerSpectrumSlope(img, s1);
%qNew = calcSpectrumSlope(img, s1);

%[qRef] = LocalLearnedFilter(img, W_11);
%[qNew] = calcLearnedFilter(img, W_11);

%{
qfc = calcLearnedFilter(imgClean,W_11);
qfb = calcLearnedFilter(imgBlured,W_11);
figure(1);
subplot(2,1,1),imshow(qfc{1,1},[min(min(qfc{1,1})) max(max(qfc{1,1}))]),title('Clean');
subplot(2,1,2),imshow(qfb{1,1},[min(min(qfb{1,1})) max(max(qfb{1,1}))]),title('Blured');
figure(2);
subplot(2,1,1),imshow(qfc{1,1},[min(min(qfc{1,1})) max(max(qfc{1,1}))]),title('Clean');
subplot(2,1,2),imshow(qfb{2,1},[min(min(qfb{2,1})) max(max(qfb{2,1}))]),title('Blured');
%}