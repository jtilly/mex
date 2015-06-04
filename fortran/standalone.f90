! this is a standalone script that returns the fibonacci number
! for a particular argument ./standalone 25 would show 75025
! in the terminal
program standalone

use globaldef
use fibonacci

implicit none

	integer :: fnum, nargin
	character(LEN=100) :: arg

	! read the input
    nargin = IARGC() 
    IF (nargin > 0) then
        CALL GETARG(1,arg)
        read( arg, '(i10)' ) fnum
    else
        fnum = 25
    end if

    ! compute the fibonacci number and print it
    PRINT *, fib(fnum)

end program standalone