clc 
clear all
close all

% imagenes de referencia para construir diccionario de textones
num_Cat = 25;
num = zeros(num_Cat,1);

for i = 1:num_Cat
    N = randi([30*(i-1) 30*i],1,1);
    num(i,1) = N;
end 