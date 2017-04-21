function [] = demo_lasso_cv()

    clc;
    clear;
    close all;
    
    
%% prepare dataset
n = 128; 
d = 10;         
A = randn(d,n);
b = randn(d,1);
lambda_max = norm(A'*b, 'inf');


%% set algorithms and solver
algorithm = {'FISTA'};


%% initialize
% define parameters for cross-validation
num_cv = 10;
lamda_unit = lambda_max/num_cv;
lambda_array = 0+lamda_unit:lamda_unit:lambda_max;

% set options
options.w_init = zeros(n,1); 

% prepare arrays for solutions
W = zeros(n, num_cv);
l1_norm = zeros(num_cv,1);    
aprox_err = zeros(num_cv,1);  


%% perform cross-validations
for i=1:length(lambda_array)
    lambda = lambda_array(i);
    problem = lasso(A, b, lambda);

    [W(:,i), infos] = fista(problem, options);
    l1_norm(i) = infos.reg(end);
    aprox_err(i) = infos.cost(end);
end


%% plot all
% display l1-norm vs. coefficient
display_graph('l1','coeff', algorithm, l1_norm, {W}, 'linear');
% display lambda vs. coefficient
display_graph('lambda','coeff', algorithm, lambda_array, {W}, 'linear');
% display l1-norm vs. approximation error
display_graph('l1','aprox_err', algorithm, l1_norm, {aprox_err}, 'linear');    
    
end




