%% Load and get files to train naive bayes
path = 'Data Base\trainNB';
or = [path '\images'];
gt = [path '\gt'];
load('learned_linear_filter.mat');

orfiles = dir( [or '\*.png'] );
orfiles = strvcat( orfiles.name );

gtfiles = dir( [gt '\*.png'] );
gtfiles = strvcat( gtfiles.name );

data = {};
pSize = 11;
lines = 1;
for i=1:size(orfiles,2)
    orIm = imread(orfiles(i,:));
    gtIm = imread(gtfiles(i,:));
    
    q1 = calcPeakedness(im, patchsize);
    q2 = calcSpectrumSlope(im, patchsize);
    q3 = LocalLearnedFilter(im, W_11(:,1:5));  
    
    for j=1:size(gtIm_col,2)
        data{lines,1} = ;
        lines = lines+1;
    end
    
end