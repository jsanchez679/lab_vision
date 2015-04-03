%No. 3B
%Classify each train image 750
% clear all; 
% close all; 
% clc; 

addpath('lib')
addpath('datos_mat')

load Hist.mat
load Hist_test.mat

%Data to train
s_Hist_train=size(Hist);
l_Hist_train=s_Hist_train(2);

%%Data to test
%   -train data
TestData=Hist;
s_test=size(TestData);
l_test=s_test(2);
class_o=1:1:l_test;
class_num=ceil(class_o/30);

%   -test data
% TestData=Hist_test;
% s_test=size(TestData);
% l_test=s_test(2);
% class_o=1:1:l_test;
% class_num=ceil(class_o/10);

%Hist_test=solo un histograma que ingresa a ser comparado con los demás
%Hist_train=entran todos los histogramas de test (750 clasificadores)

%%
tic
%Chi Cuadrado
sum_distance_per_bar=zeros(l_Hist_train,l_test);
class750_csq=zeros(3,l_test);

%recorrido entre los 250 htgms de las imágenes de test
for k=1:l_test
    Hist_test_in=TestData(:,k);
    %recorrido entre los 750 htgms de train
    for i=1:l_Hist_train
        Hist_train_in=Hist(:,i);
        sum_distance_per_bar(i,k)=sum(sum((Hist_test_in-Hist_train_in).^2/Hist_train_in));
    end
    [min_sum,index]=min(sum_distance_per_bar(:,k));
    class750_csq(1,k)=min_sum;
    class750_csq(2,k)=index;
    class750_csq(3,k)=ceil(index/30);
end
toc
% save class750_csq.mat      % command form

%%
%Matriz de confusiones
ConfMtx_csq=confusionmat(class_num,class750_csq(3,:));
figure; 
imagesc(ConfMtx_csq)
title('Matriz de Confusiones Chi-Cuadrado - Test')
%title('Matriz de Confusiones Chi-Cuadrado - Train')

%%
%Random forest

% Since TreeBagger uses randomness we will get different results each 
% time we run this.
% This makes sure we get the same results every time we run the code.
rng default
 
% Here we create some training data.
% The rows&lt; represent the samples or individuals.
% The first two columns represent the individual's features.
% The last column represents the class label (what we want to predict)
tic
class_train_o=1:1:750;
class_num_train=ceil(class_o/30);
class_num_train_t=class_num_train';
Hist_t=Hist';
trainData = horzcat(Hist_t,class_num_train_t);
 
features = trainData(:,(1:50));
classLabels = trainData(:,51);
 
% How many trees do you want in the forest? 
nTrees = 100;

tic
% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification','OOBPred','On','MinLeaf',5);
 
oobErrorBaggedEnsemble = oobError(B);
plot(oobErrorBaggedEnsemble)
xlabel 'Número de árboles en el bosque';
ylabel 'Error de Clasificación Out-of-bag ';

toc
%%

% Given a new individual WITH the features and WITHOUT the class label,
% what should the class label be?

class750_rf=zeros(1,l_test);
for k=1:l_test
        newData = TestData(:,k);
        newData1 = newData';
        
        % Use the trained Decision Forest.
        predChar1 = B.predict(newData1);
        
        % Predictions is a char though. We want it to be a number.
        predictedClass = str2double(predChar1);
        % predictedClass =
        %      1
        
        % So we predict that for our new piece of data, we will have a class label of 1
        class750_rf(1,k)=predictedClass;
end 
toc
%save class750_rf.mat      % command form

%%
%Matriz de confusiones
ConfMtx_rf=confusionmat(class_num,class750_rf(1,:));
figure; 
imagesc(ConfMtx_rf)
title('Matriz de Confusiones Bosques de decisión - Test')
%title('Matriz de Confusiones Bosques de decisión - Train')

%%
figure()
subplot(2,1,1)
imagesc(ConfMtx_csq)
xlabel('Chi-Cuadrado')
title('Matriz de Confusiones - Test')
%title('Matriz de Confusiones - Train')
subplot(2,1,2)
imagesc(ConfMtx_rf)
xlabel('Bosques de decisión')

