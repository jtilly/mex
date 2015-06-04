# mex
Examples on how to use mex files in Matlab under Linux

## Fortran (ifort)
This is a simple example program that computes Fibonacci numbers in both Fortran and Matlab 

 * Edit `fortran/makefile`, in particular make sure that `MDIR` points to your Matlab installation
 * Compile the mex file using `make`
 * Run `fortran/main.m` in Matlab

#### Example 
```{matlab}
% use matlab 
tic
fibonacci(25)
toc

% use fortran
tic
gateway(25)
toc
```

#### Performance on my desktop computer

|  | Matlab | Fortran |
|------|-------|--------|
|Time in seconds|1.802955 | 0.001470
