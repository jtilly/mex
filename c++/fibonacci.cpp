#include "fibonacci.h"

int fib(const int n) {
	int fnum;
	if (n<2) {
       fnum = n;
	}
    else {
       fnum = fib(n-1) + fib(n-2);
    }
	return fnum;
}