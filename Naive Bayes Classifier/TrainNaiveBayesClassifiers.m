clc; clear;

disp('Loading data train...');
load('data_train_nb_s11');

disp('Training nb for patch size = 11');
nb_s11 = NaiveBayes.fit(cell2mat(data_train(:,1), data_train(:,2)));
clear data_train;

disp('Training nb for patch size = 15');
nb_s15 = NaiveBayes.fit(cell2mat(data_train(:,1), data_train(:,2)));
clear data_train;

disp('Training nb for patch size = 21');
nb_s21 = NaiveBayes.fit(cell2mat(data_train(:,1), data_train(:,2)));
clear data_train;

save nb_classifiers nb_s11 nb_s15 nb_s21