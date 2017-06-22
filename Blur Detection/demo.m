clc; clear;

addpath('feature');
addpath('UGM');

path = 'image';
out = 'result';
files = dir( [path '\*.jpg'] );
files = char( files.name );

nFiles = size(files,1);
for i=1:nFiles
    img = rgb2gray(im2double(imread([path '\' files(i,:)])));
    resImg = blurDetection(img);
    imwrite(resImg,[out '\' files(i,:)]);
end