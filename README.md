# GDLibrary : Gradient Descent Library in MATLAB
----------

Authors: [Hiroyuki Kasai](http://www.kasailab.com/)

Last page update: April 19, 2017

Latest library version: 1.0.1 (see Release notes for more info)

Introduction
----------
The GDLibrary is a **pure-Matlab** library of a collection of **unconstrained optimization algorithms**. This solves an unconstrained minimization problem of the form, min f(x).

Note that the [SGDLibrary](https://github.com/hiroyuki-kasai/SGDLibrary) internally contains this GDLibrary.

List of gradient algorithms available in GDLibrary
---------
- **GD** (gradient descent)
    - Scaled GD
    - [Proximal GD](https://en.wikipedia.org/wiki/Proximal_gradient_method)
- **CG** (linear conjugate gradient)
    - Preconditioned CG
- **NCG** (non-linear conjugate gradient)
    - Fletcher-Reeves (FR), Polak-Ribiere (PR)
- **Newton** (Netwon's algorithm)
    - Damped Newton
    - Cholesky factorizaion based Newton
- **BFGS**
    - Damped BFGS
- **LBFGS** (limited-memory BFGS)
- **AGD** (Accelerated gradient descent, i.e., Nesterov AGD)
    - APG (Proximal AGD)
- **[FISTA](http://epubs.siam.org/doi/abs/10.1137/080716542)** (Fast iterative shrinkage-thresholding algorithm)
- **CD for Lasso and Elastic Net** (Coodinate descent) 
- **[ADMM](http://stanford.edu/~boyd/admm.html) for Lasso** (The alternating direction method of multipliers)

List of line-search algorithms available in GDLibrary
---------
- **Backtracking line search** (a.k.a Armijo condition)
- **Strong wolfe line search**
- **Exact line search**
    - Only for quadratic problem.
- **TFOCS-styole line search**

Supported problems
---------
* [Rosenbrock problem](https://en.wikipedia.org/wiki/Rosenbrock_function)
* [Quadratic problem](https://en.wikipedia.org/wiki/Quadratic_programming)
* [Multidimensional linear regression](https://en.wikipedia.org/wiki/Linear_regressionSV)
* Linear [SVM](https://en.wikipedia.org/wiki/Support_vector_machine) (Support vector machine)
* [Logistic regression](https://en.wikipedia.org/wiki/Logistic_regression)
* Softmax classification ([multinomial logistic regression](https://en.wikipedia.org/wiki/Multinomial_logistic_regression))
* General form problem
* Proximal type problems
    - [Lasso](https://en.wikipedia.org/wiki/Lasso_(statistics)) (Least absolute shrinkage and selection operator) problem
    - [Elastic Net](https://en.wikipedia.org/wiki/Elastic_net_regularization) problem
    - [Matrix completion](https://en.wikipedia.org/wiki/Matrix_completion) problem with trace norm minimization 
    - L1-norm logistic regression

Folders and files
---------
<pre>
./                      - Top directory.
./README.md             - This readme file.
./run_me_first.m        - The scipt that you need to run first.
./demo.m                - Demonstration script to check and understand this package easily. 
|plotter/               - Contains plotting tools to show convergence results and various plots.
|tool/                  - Some auxiliary tools for this project.
|gd_solver/             - Contains various stochastic optimization algorithms.
|problem/               - Problem definition files to be solved.
|gd_test/               - Some helpful test scripts to use this package.
</pre>
                                 

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

* Version 1.0.1 (Apr. 19, 2017)
    - New solvers (e.g., APG) and problems (e.g. Lasso) are added.
* Version 1.0.0 (Nov. 04, 2016)
    - Initial version.

