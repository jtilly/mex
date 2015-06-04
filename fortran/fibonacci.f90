! this module computes the fibonacci number
module fibonacci

  implicit none

  ! make an interface so that we can use recursive functions
  interface fib
     module procedure fib
  end interface fib

  contains 
  
  ! define the function fib that takes the integer argument n
  ! and returns the corresponding fibonacci number
  recursive function fib (n)  result (fnum) 
    integer, intent(in)  :: n
    integer :: fnum
    if (n<2) then 
       fnum = n
    else
       fnum = fib(n-1) + fib(n-2)
    endif
  end function fib

end module fibonacci