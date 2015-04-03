%Datos matriz de confusiones

addpath('lib')
addpath('datos_mat')

%Chi Cuadrado
load ConfMtx_csq_train.mat
ConfMtx_csq_train=ConfMtx_csq;
load ConfMtx_csq_test.mat
ConfMtx_csq_test=ConfMtx_csq;

%Random Forests
load ConfMtx_rf_train.mat
ConfMtx_rf_train=ConfMtx_rf;
load ConfMtx_rf_test.mat
ConfMtx_rf_test=ConfMtx_rf;

Sum_csq_train = trace(ConfMtx_csq_train)*100/750
Sum_csq_test = trace(ConfMtx_csq_test)*100/250
Sum_rf_train = trace(ConfMtx_rf_train)*100/750
Sum_rf_test = trace(ConfMtx_rf_test)*100/250

