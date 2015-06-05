#include "mex.h"
#include "fibonacci.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

	// arg and val are pointers to the arguments and the value that is returned
	double *arg, *val;
	// get the pointer to the argument
	arg = mxGetPr(prhs[0]);
	// get the integer valued argument
	int n = (int) *arg;
	// create matrix that will be returned
	plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
	// get the pointer to this matrix
	val = mxGetPr(plhs[0]);
	// assign the value
	*val = (double) fib(n);

    return;
}