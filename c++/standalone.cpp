#include <iostream>
#include <cstdlib> 

#include "fibonacci.h"
 
int main(int argc, char* argv[])
{
  
  // default value is 25
  int n = 25;
  
  // check if there are some arguments
  if(argc > 1) {
  	 n = atoi(argv[1]);
  }
  
  // compute fibonacci number
  std::cout << fib(n) << "\n";

  return 0;
}