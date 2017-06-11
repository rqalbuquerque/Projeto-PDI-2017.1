clc; clear;

%% Load and get files to train naive bayes
addpath('..\Features');
path = '..\Data Base\trainNB';
or = [path '\images'];
gt = [path '\gt'];
load('learned_linear_filter.mat');

orfiles = dir( [or '\*.jpg'] );
orfiles = char( orfiles.name );

gtfiles = dir( [gt '\*.png'] );
gtfiles = char( gtfiles.name );

nFiles = size(orfiles,1);
data_train = {};
pSize = 11;
lines = 1;
offset = (pSize - 1)/2;
n = 1;
for i=1:10
    i
    orIm = imread([or '\' orfiles(i,:)]);
    gtIm = imread([gt '\' gtfiles(i,:)]);
    
    gtIm = gtIm/255;
    img = rgb2gray(orIm);
    
    q1 = calcPeakedness(img, pSize);
    q2 = calcHeavyTailedness(img, pSize);
    q3 = calcSpectrumSlope(img, pSize);
    q4 = calcLearnedFilter(img, W_11(:,1:2));  
    
    [img_height, img_width] = size(img);
    
    for j=1+offset:img_height-offset-1
        for k=1+offset:img_width-offset-1
            data_train(n,1:2) = {[q1(j,k) q2(j,k) q3(j,k) q4{1,1}(j,k) q4{2,1}(j,k)] gtIm(j,k)};
            n = n+1;
        end
    end
    
end

save data_train_nb data_train
