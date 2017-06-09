clc; clear;

%% Load and get files to train naive bayes
path = 'Data Base\trainNB';
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
for i=1:nFiles
    orIm = imread([or '\' orfiles(i,:)]);
    gtIm = imread([gt '\' gtfiles(i,:)]);
    
    im = rgb2gray(orIm);
    
    q1 = calcPeakedness(im, pSize);
    q2 = calcSpectrumSlope(im, pSize);
    q3 = LocalLearnedFilter(im, W_11(:,1:5));  
    
    [im_height, im_width] = size(orIm);
    
    for j=1+pSize:im_height-pSize
        for k=1+pSize:im_width-pSize
            data_train{i,1} = {[q1(j,k) q2(j,k) q3{1,1}(j,k) q3{2,1}(j,k)] gtIm(j,k)};
        end
    end
    
end

save data_to_train_rqa


    