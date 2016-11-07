# GDLibrary : Gradient Descent Library in MATLAB
----------

Authors: [Hiroyuki Kasai](http://www.kasailab.com/)

Last page update: November 4, 2016

Latest library version: 1.0.0 (see Release notes for more info)

Introduction
----------
The GDLibrary is a **pure-Matlab** library of a collection of **unconstrained optimization algorithms**. This solves an unconstrained minimization problem of the form, min f(x).

Note that the [SGDLibrary](https://github.com/hiroyuki-kasai/SGDLibrary) internally contains this GDLibrary.

List of gradient algorithms available in GDLibrary
---------
- **GD** (gradient descent)
- **CG** (linear conjugate gradient)
- **NCG** (non-linear conjugate gradient)
- **Newton** (Netwon's algorithm)
- **BFGS**
- **LBFGS** (limited-memory BFGS)

List of line-search algorithms available in GDLibrary
---------
- **Backtracking line search** (a.k.a Armijo condition)
- **Strong wolfe line search**
- **Exact line search**
    - Only for quadratic problem.

Supported problems
---------
* [Rosenbrock problem](https://en.wikipedia.org/wiki/Rosenbrock_function)
* Quadratic problem
* Multidimensional linear regression
* Linear SVM
* Logistic regression
* Softmax classification (multinomial logistic regression)
* General problem

Folders and files
---------

- run_me_first.m
    - The script that you need to run first.

- demo.m
    - A demonstration script to check and understand this package easily. 
                      
- gd_solver/
    - Contains various stochastic optimization algorithms.

- problem/
    - Problem definition files to be solved.

- gd_test/
    - Some helpful test script to use this package.

- plotter/
    - Contains plotting tools to show convergence results and various plots.
                  
- tool/
    - Some utility tools for this project.
                  
                              

First to do
----------------------------
Run `run_me_first` for path configurations. 
```Matlab
%% First run the setup script
run_me_first; 
```

Usage example (Rosenbrock problem)
----------------------------
Now, just execute `demo` for demonstration of this package.
```Matlab
%% Execute the demonstration script
demo; 
```

The "**demo.m**" file contains below.
```Matlab
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
```

* Output results 

<img src="https://dl.dropboxusercontent.com/u/869853/github/GDLibrary/images/rosenbrock_cost_gnorm.png" width="900">
<br /><br />

<img src="https://dl.dropboxusercontent.com/u/869853/github/GDLibrary/images/rosenbrock_convergence.png" width="900">
<br /><br />



License
-------
The GDLibrary is free and open source for academic/research purposes (non-commercial).


Problems or questions
---------------------
If you have any problems or questions, please contact the author: [Hiroyuki Kasai](http://www.kasailab.com/) (email: kasai **at** is **dot** uec **dot** ac **dot** jp)

Release Notes
--------------

* Version 1.0.0 (Nov. 04, 2016)
    - Initial version.

