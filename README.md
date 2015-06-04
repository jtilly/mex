# mex
Examples on how to use mex files in Matlab under Linux

## Fortran (ifort)
 * Edit `fortran/makefile`, in particular make sure that `MDIR` points to your Matlab installation.
 * Compile the mex file using `make`
 * Run `fortran/main.m` in Matlab to compute Fibonacci numbers using both the Fortran function and a Matlab implementation
