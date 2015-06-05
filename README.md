# Using mex files with Matlab and Fortran 
[![Build Status](https://travis-ci.org/jtilly/mex.svg?branch=master)](https://travis-ci.org/jtilly/mex)

Example on how to use [mex files](http://www.mathworks.com/help/matlab/matlab_external/introducing-mex-files.html) in Matlab on Linux and Mac OS X. This works with both the GCC compiler, [`gfortran`](https://gcc.gnu.org/wiki/GFortran), and Intel's Fortran compiler, [`ifort`](https://software.intel.com/en-us/fortran-compilers). This sample program computes Fibonacci numbers. 

## Installation

 * Edit [`makefile`](https://github.com/jtilly/mex/blob/master/makefile) and make sure that `MDIR` points to your Matlab installation
 * The default compiler is [`gfortran`](https://gcc.gnu.org/wiki/GFortran). If you want to use [`ifort`](https://software.intel.com/en-us/fortran-compilers) uncomment the appropriate lines in [`makefile`](https://github.com/jtilly/mex/blob/master/makefile)
 * Compile the mex file using `make`
 
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

The function [`fibonacci`](https://github.com/jtilly/mex/blob/master/fibonacci.m) calls a Matlab implementation of the Fibonacci function:
```{matlab}
function [ fnum ] = fibonacci( n )
    if (n<2)
        fnum = n;
    else
        fnum = fibonacci(n-1) + fibonacci(n-2);
    end
end
```

The function [`gateway`](https://github.com/jtilly/mex/blob/master/fortran/gateway.f90) calls the mex file that is implemented in Fortran. The underlying Fortran function is very simple:
```{FORTRAN}
recursive function fib (n)  result (fnum) 
  integer, intent(in)  :: n
  integer :: fnum
  if (n<2) then 
     fnum = n
  else
     fnum = fib(n-1) + fib(n-2)
  endif
end function fib
```

## Computational Performance

Average time in seconds to compute the 25th Fibonacci number (=75025) on different platforms using `ifort`:

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
 * `main.m` Matlab script that calls both the Matlab and Fortran implementation
 * `makefile` makefile for Linux and Mac OS X
