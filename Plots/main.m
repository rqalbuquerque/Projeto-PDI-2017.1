clc; clear;

DB = '..\Data Base';
resGt = 'result_gt';
resRqa = 'result_rqa';
resShi = 'result_shi';
resOthers = 'result_others';
testImg = 'motion0001';

hold all

generatesPRPlotFromTwoImages([DB '\' resGt '\' testImg '.jpg'], ...
                             [DB '\' resRqa '\' testImg '_rqa.jpg'], ...
                             'blue');
                         
generatesPRPlotFromTwoImages([DB '\' resGt '\' testImg '.jpg'], ...
                             [DB '\' resShi '\' testImg '_shi.jpg'], ...
                             'red');
legend('my version','shi version');
%{
generatesPRPlotFromTwoImages([DB '\' resGt '\' testImg '.jpg'], ...
                             [DB '\' resOthers '\' testImg '_fft.jpg'], ...
                             'yellow');
                         
generatesPRPlotFromTwoImages([DB '\' resGt '\' testImg '.jpg'], ...
                             [DB '\' resOthers '\' testImg '_liu.jpg'], ...
                             'green');
                         
generatesPRPlotFromTwoImages([DB '\' resGt '\' testImg '.jpg'], ...
                             [DB '\' resOthers '\' testImg '_su.jpg'], ...
                             'black');

                                                  

%}                            