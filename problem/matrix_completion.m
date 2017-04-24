function [Problem] = matrix_completion(A, mask, lambda)
% This file defines a matrix completion problem. 
%
% Inputs:
%       A           Full observation matrix. A.*mask is to be completed. 
%       mask        Linear operator to extract existing elements, denoted as P_omega( ).
% Output:
%       Problem     problem instance. 
%
%
% The problem of interest is defined as
%
%           min f(w) =  1/2 * ||P_omega(W) - P_omega(A)||_2^2 + 1/2 * lambda * ||X||_2^2,
%
% "w" is the model parameter of size mxn vector, which is transformed to matrix W of size [m, n]. 
%
%
% This file is part of GDLibrary and SGDLibrary.
%
% Created by H.Kasai on Apr. 17, 2017


    m = size(A, 1);
    n = size(A, 2);
    
    Problem.name = @() 'matrix completion';  
    Problem.dim = @() m*n;
    Problem.samples = @() n;
    Problem.lambda = @() lambda;    
  

    Problem.cost = @cost;
    function f = cost(w)
        L = reshape(w, [m n]);
        diff = (L - A.*mask) .* (A.*mask ~= 0);

        f = 1/2 * norm(diff, 'fro') + 1/2 * lambda * norm(w)^2;
    end

    Problem.cost_batch = @cost_batch;
    function f = cost_batch(w, indices)
        error('Not implemted yet.');        
    end

    Problem.full_grad = @full_grad;
    function g = full_grad(w)
        L = reshape(w, [m n]);
        G = (L - A.*mask) .* (A.*mask ~= 0);
        g = G(:) + lambda * w;
    end

    Problem.grad = @grad;
    function g = grad(w, indices)
        error('Not implemted yet.');
    end

    Problem.hess = @hess; 
    function h = hess(w, indices)
        error('Not implemted yet.');        
    end

    Problem.full_hess = @full_hess; 
    function h = full_hess(w)
        error('Not implemted yet.');        
    end

    Problem.hess_vec = @hess_vec; 
    function hv = hess_vec(w, v, indices)
        error('Not implemted yet.');
    end


end

