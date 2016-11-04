function  demo()
% demonstration file for GDLibrary.
%
% This file illustrates how to use this library in case of "Rosenbrock" 
% problem. This demonstrates GD, NCG and L-BFGS algorithms.
%
% This file is part of GDLibrary.
%
% Created by H.Kasai on Nov. 02, 2016


    clc;
    clear;
    close all;


    %% define problem definitions
    % set number of dimensions
    d = 2;    
    problem = rosenbrock(d);
    
    
    %% calculate solution 
    w_opt = problem.calc_solution(); 

   
    %% general options for optimization algorithms   
    options.w_init = zeros(d,1);
    % set verbose mode        
    options.verbose = true;  
    % set optimal solution    
    options.f_opt = problem.cost(w_opt);  
    % set store history of solutions
    options.store_w = true;
  
    
    %% perform GD with backtracking line search 
    options.step_alg = 'backtracking';
    [w_gd, info_list_gd] = gd(problem, options); 
    
    %% perform GD with backtracking line search 
    options.step_alg = 'backtracking';
    [w_ncg, info_list_ncd] = ncg(problem, options);     

    %% perform L-BFGS with strong wolfe line search
    options.step_alg = 'strong_wolfe';                  
    [w_lbfgs, info_list_lbfgs] = lbfgs(problem, options);                  
    
    
    %% plot all
    close all;
    
    % display epoch vs cost/gnorm
    display_graph('iter','cost', {'GD-BKT', 'NCG-BKT', 'LBFGS-WOLFE'}, {w_gd, w_ncg, w_lbfgs}, {info_list_gd, info_list_ncd, info_list_lbfgs});
    % display optimality gap vs grads
    display_graph('iter','gnorm', {'GD-BKT', 'NCG-BKT', 'LBFGS-WOLFE'}, {w_gd, w_ncg, w_lbfgs}, {info_list_gd, info_list_ncd, info_list_lbfgs});
    
    % draw convergence sequence
    w_history = cell(1);
    cost_history = cell(1);
    w_history{1} = info_list_gd.w;
    w_history{2} = info_list_ncd.w;  
    w_history{3} = info_list_lbfgs.w;      
    cost_history{1} = info_list_gd.cost;
    cost_history{2} = info_list_ncd.cost;  
    cost_history{3} = info_list_lbfgs.cost;      
    draw_convergence_sequence(problem, w_opt, {'GD-BKT', 'NCG-BKT', 'LBFGS-WOLFE'}, w_history, cost_history);        

end


