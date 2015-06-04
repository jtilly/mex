# mex
Examples on how to use mex files in Matlab on Linux and Mac OS X

## Fortran (ifort)
This is a simple example program that computes Fibonacci numbers in both Fortran and Matlab 

 * Edit `makefile.linux` or `makefile.osx` and make sure that `MDIR` points to your Matlab installation
 * Compile the mex file using `make -f makefile.linux` on Linux or `make -f makefile.osx` on Mac OS X
 * Run `main.m` in Matlab

#### Example 
```{matlab}
% use matlab (correct answer is 75025)
tic
fibonacci(25)
toc

% use fortran
tic
gateway(25)
toc
```

#### Performance on my Desktop Computer

|  | Matlab | Fortran |
|------|-------|--------|
|Time in seconds|1.802955 | 0.001470


#### Files in this repository
 * `/fortran` 
       - `fibonacci.f90` module with Fibonacci function
       - `gateway.f90` gateway script that can be called from Matlab
       - `globaldef.f90` module with global definitions
       - `standalone.f90` a standalone program that calls the Fibonacci function independently from Matlab (useful for debugging)
 * `fibonacci.m` Matlab implementation of the Fibonacci function
 * `main.m` Matlabs script that calls both the Matlab and Fortran implementations of the Fibonacci function
 * `makefile.linux` makefile for Linux
 * `makefile.osx` makefile for Mac OS X
