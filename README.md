# Using Fortran and C++ mex files with Matlab
[![Build Status](https://travis-ci.org/jtilly/mex.svg?branch=master)](https://travis-ci.org/jtilly/mex "Don't take this build status badge too seriously, please. I'm only building the standalone program on Travis CI, not the mex files. The badge still looks pretty though :)")

This repository contains example programs for the use of [mex files](http://www.mathworks.com/help/matlab/matlab_external/introducing-mex-files.html) in Matlab on Linux and Mac OS X. I'm computing Fibonacci numbers in Matlab, Fortran, and C++. All of this works with [GCC](https://gcc.gnu.org/) and Intel compilers.

## Installation
#### Fortran

 * Edit [`fortran.makefile`](https://github.com/jtilly/mex/blob/master/fortran.makefile) and make sure that `MDIR` points to your Matlab installation
 * The default compiler is [`gfortran`](https://gcc.gnu.org/wiki/GFortran). If you want to use Intel's `ifort`, uncomment the appropriate lines in [`fortran.makefile`](https://github.com/jtilly/mex/blob/master/fortran.makefile)
 * Compile the mex file using `make -f fortran.makefile`

#### C++

 * Edit [`cpp.makefile`](https://github.com/jtilly/mex/blob/master/cpp.makefile) and make sure that `MDIR` points to your Matlab installation
 * The default compiler is `g++` (gcc or clang depending on your system). If you want to use Intel's `icpc`, uncomment the appropriate lines in [`cpp.makefile`](https://github.com/jtilly/mex/blob/master/cpp.makefile)
 * Compile the mex file using `make -f cpp.makefile`

## Example

Run [`main.m`](https://github.com/jtilly/mex/blob/master/main.m) in Matlab:

```matlab
% use matlab (correct answer is 75025)
tic
fibonacci(25)
toc

% use Fortran
tic
gatewayFortran(25)
toc

% use C++
tic
gatewayCpp(25)
toc
```

Next, consider the different implementations of the Fibonacci function. Note that this is only meant as an illustration. There are [much better ways](https://bosker.wordpress.com/2011/04/29/the-worst-algorithm-in-the-world/) to compute the Fibonacci numbers than the algorithm I'm using here.

The function [`fibonacci`](https://github.com/jtilly/mex/blob/master/fibonacci.m) calls a Matlab implementation of the Fibonacci function:
```matlab
function [ fnum ] = fibonacci( n )
  if (n<2)
    fnum = n;
  else
    fnum = fibonacci(n-1) + fibonacci(n-2);
  end
end
```

The function [`gatewayFortran`](https://github.com/jtilly/mex/blob/master/fortran/gatewayFortran.f90) calls the mex file that is implemented in Fortran. The underlying Fortran function is very simple:
```fortran
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

The function [`gatewayCpp`](https://github.com/jtilly/mex/blob/master/c++/gatewayCpp.cpp) calls the mex file that is implemented in C++. The underlying C++ function is very simple:
```cpp
int fib(const int n) {
  int fnum;
  if (n<2) {
     fnum = n;
  } else {
     fnum = fib(n-1) + fib(n-2);
  }
  return fnum;
}
```

## Computational Performance

Average time in seconds to compute the 25th Fibonacci number (=75025) on different platforms using the GCC compilers:

|                                   | Matlab | Fortran | C++     |
|-----------------------------------|--------|--------|----------|
|Desktop Computer running Ubuntu       | 1.7893 | 0.0022 | 0.0019|
|Macbook Air running Mac OS X Yosemite | 2.0151 | 0.0024 | 0.0023|

## Files in this Repository

I'm keeping the Fortran and C++ code self-contained. I'm also providing standalone programs `./standalone.f90.out` and `./standalone.cpp.out` that can be used to debug the Fortran and C++ code independently from Matlab. Travis CI is only building these standalone programs.

 * `/c++`
       - `fibonacci.cpp` Fibonacci function
       - `fibonacci.h` header file for Fibonacci function
       - `gatewayCpp.cpp` gateway script that can be called from Matlab
       - `standalone.cpp` a standalone program that calls the Fibonacci function independently from Matlab
 * `/fortran`
       - `fibonacci.f90` module with Fibonacci function
       - `gatewayFortran.f90` gateway script that can be called from Matlab
       - `globaldef.f90` module with global definitions
       - `standalone.f90` a standalone program that calls the Fibonacci function independently from Matlab
 * `cpp.makefile` C++ makefile for Linux and Mac OS X
 * `fibonacci.m` Matlab implementation of the Fibonacci function
 * `fortran.makefile` Fortran makefile for Linux and Mac OS X
 * `main.m` Matlab script that calls both the Matlab and Fortran implementation
