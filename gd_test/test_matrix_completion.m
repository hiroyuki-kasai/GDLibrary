function [] = test_matrix_completion()

    clc;
    clear;
    close all;
    
    rng('default');
    
     
    %% Set algorithms
    if 0
        algorithms = gd_solver_list('ALL');  
    else
        algorithms = {'GD-BKT', 'L-BFGS-BKT'}; 
    end    
    
    
    %% prepare dataset
    n = 500; 
    m = 100; 
    r = 5; 
    lambda = 0.1;
    density = 0.3; 
    M = randn(m,r)*randn(r,n)  + 0.01 * randn(m, n); 
    mask = (rand(m,n)<density);

    
    
    %% define problem definitions
    problem = matrix_completion(M, mask, lambda);

    
    %% initialize
    w_init = randn(m*n, 1);
    w_list = cell(length(algorithms),1);
    info_list = cell(length(algorithms),1);
    

    %% perform algorithms
    for alg_idx=1:length(algorithms)
        fprintf('\n\n### [%02d] %s ###\n\n', alg_idx, algorithms{alg_idx});
        
        clear options;
        % general options for optimization algorithms   
        options.w_init = w_init;
        options.tol_gnorm = 1e-10;
        options.max_iter = 100;
        options.verbose = true;  

        switch algorithms{alg_idx}
            case {'GD-BKT'}
                
                options.step_alg = 'backtracking';
                [w_list{alg_idx}, info_list{alg_idx}] = gd(problem, options);
                
            case {'NCG-BKT'}
                
                options.sub_mode = 'STANDARD';                
                options.step_alg = 'backtracking';      
                options.beta_alg = 'PR';                
                [w_list{alg_idx}, info_list{alg_idx}] = ncg(problem, options);     
                
            case {'L-BFGS-BKT'}
                
                options.step_alg = 'backtracking';                  
                [w_list{alg_idx}, info_list{alg_idx}] = lbfgs(problem, options);
                
            case {'L-BFGS-WOLFE'}
                
                options.step_alg = 'strong_wolfe';                  
                [w_list{alg_idx}, info_list{alg_idx}] = lbfgs(problem, options);               
                
            otherwise
                warn_str = [algorithms{alg_idx}, ' is not supported.'];
                warning(warn_str);
                w_list{alg_idx} = '';
                info_list{alg_idx} = '';                
        end
        
    end
    
    
    fprintf('\n\n');
    
    
    %% plot all
    close all;
    
    % display iter vs. cost
    display_graph('iter','cost', algorithms, w_list, info_list);
end

