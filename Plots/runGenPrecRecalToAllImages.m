clc; clear;

DB = '..\Data Base';
resGt = 'result_gt';
resRqa = 'result_rqa';
resShi = 'result_shi';
resSu = 'result_su';
resLiu = 'result_liu';
resFft = 'result_fft';

all_pixels_Gt = concatAllImages([DB '\' resGt]);
all_pixels_Shi = concatAllImages([DB '\' resShi]);
all_pixels_Rqa = concatAllImages([DB '\' resRqa]);
all_pixels_Su = concatAllImages([DB '\' resSu]);
all_pixels_Liu = concatAllImages([DB '\' resLiu]);
all_pixels_Fft = concatAllImages([DB '\' resFft]);

%save all_pixels_results all_pixels_Gt all_pixels_Shi all_pixels_Rqa all_pixels_Su all_pixels_Liu all_pixels_Fft

labels = im2bw(all_pixels_Gt, 0.5);
scoresShi = double(all_pixels_Shi)/255;
scoresRqa = double(all_pixels_Rqa)/255;
scoresSu = double(all_pixels_Su)/255;
scoresLiu = double(all_pixels_Liu)/255;
scoresFft = double(all_pixels_Fft)/255;

hold all;

[Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scoresShi, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr,'red');

[Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scoresRqa, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr,'blue'), xlabel('Recall'); ylabel('Precision');
axis([0 1 0 1]);
[Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scoresSu, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr,'yellow');

[Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scoresLiu, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr,'green');

[Xpr,Ypr,Tpr,AUCpr] = perfcurve(labels, scoresFft, logical(1), 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr,'black'), xlabel('Recall'); ylabel('Precision');

legend('shi version','my version');


