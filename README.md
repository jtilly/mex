# Using mex files with Matlab and Fortran
Example on how to use [mex files](http://www.mathworks.com/help/matlab/matlab_external/introducing-mex-files.html) in Matlab on Linux and Mac OS X. I'm using Intel's Fortran compiler. This sample program computes Fibonacci numbers. 

## Installation

 * Edit [`makefile.linux`](https://github.com/jtilly/mex/blob/master/makefile.linux) or [`makefile.osx`](https://github.com/jtilly/mex/blob/master/makefile.osx) and make sure that `MDIR` points to your Matlab installation
 * Compile the mex file using `make -f makefile.linux` on Linux or `make -f makefile.osx` on Mac OS X
 
## Example 

Run [`main.m`](https://github.com/jtilly/mex/blob/master/main.m) in Matlab:
 
```{matlab}
% use matlab (correct answer is 75025)
tic
fibonacci(25)
toc

% use Fortran
tic
gateway(25)
toc
```

## Computational Performance

Time (in seconds) to compute the 25th Fibonacci number (=75025).

|  | Matlab | Fortran |
|-----------------------------------|--------|--------|
|Desktop Computer running Ubuntu       | 1.8029 | 0.0014 |
|Linux Server running CentOS           | 2.5575 | 0.0013 | 
|Macbook Air running Mac OS X Yosemite | 2.0076 | 0.0058 |


## Files in this Repository

I'm keeping the Fortran code fairly self-contained. I'm also providing a standalone program `./standalone.out` that can be used to debug the Fortran code independently. 

 * `/fortran` 
       - `fibonacci.f90` module with Fibonacci function
       - `gateway.f90` gateway script that can be called from Matlab
       - `globaldef.f90` module with global definitions
       - `standalone.f90` a standalone program that calls the Fibonacci function independently from Matlab 
 * `fibonacci.m` Matlab implementation of the Fibonacci function
 * `main.m` Matlabs script that calls both the Matlab and Fortran implementations of the Fibonacci function
 * `makefile.linux` makefile for Linux
 * `makefile.osx` makefile for Mac OS X
