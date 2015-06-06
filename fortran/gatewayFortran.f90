#include "fintrf.h"

! standard header for mex functions
subroutine mexfunction(nlhs, plhs, nrhs, prhs)

    ! access globaldef
    use globaldef 
    ! access fibonacci module
    use fibonacci 

    ! number of input arguments, number of output arguments
    integer      :: nlhs, nrhs  
    ! pointer to inputs and outputs
    mwPointer    :: plhs(*), prhs(*) 
    ! get some of the matlab mex functions
    mwPointer    :: mxGetPr, mxCreateDoubleMatrix 
    ! define a size integer so that we can get its type
    mwSize       :: ms 
    integer,  parameter :: mwS = kind(ms)

    ! input as real
    real(dp) :: number_in 
    ! output as real
    real(dp) :: number_out 

    ! copy the right-hand side argument in matlab to number_in
    call mxCopyPtrToReal8(mxGetPr(prhs(1)), number_in, 1_mwS)

    ! compute the fibbonacci number 
    number_out = REAL(fib(INT(number_in)))

    ! initialize the left-hand side of the function as a 1-by-1 matrix
    plhs(1) = mxCreateDoubleMatrix(1_mwS, 1_mwS, 0)
    
    ! copy the output to the left-hand side
    call mxCopyReal8ToPtr(number_out, mxGetPr(plhs(1)), 1_mwS) 

end subroutine
