# define matlab dir
MDIR = /etc/matlab

# compiles mex files using gfortran
F90 = gfortran

# compiler flags for gfortran
FFLAGS = -O3 -cpp -fPIC -Jfortran

# to use the intel compiler instead, uncomment F90 and FFLAGS below:

# compiles mex file using the intel compiler
# F90 = ifort

# compiler flags for intel compiler
# FFLAGS = -O3 -fpp -fPIC -D__amd64 -module fortran

# Figure out which platform we're on
UNAME = $(shell uname -s)

# Linux
ifeq ($(findstring Linux,${UNAME}), Linux)
	# define which files to be included
	FINCLUDE = -I$(MDIR)/extern/include -Ifortran -shared 
	# define extension
	EXT = mexa64
endif

# Mac OS X
ifeq ($(findstring Darwin,${UNAME}), Darwin)
	# define which files to be included
	FINCLUDE = -L$(MDIR)/bin/maci64 -I$(MDIR)/extern/include -Ifortran  -shared -lmx -lmex -lmat
	# define extension
	EXT = mexmaci64
endif

# the output file will be called gatewayFortran.mexa64
all : gatewayFortran.$(EXT) standalone.f90.out

# file with global definitions
globaldef.o:./fortran/globaldef.f90
	$(F90) $(FFLAGS) -c -Ifortran $< -o ./fortran/$@

# fibonacci module: this is where the action happens
fibonacci.o:./fortran/fibonacci.f90 globaldef.o
	$(F90) $(FFLAGS) -c -Ifortran $< -o ./fortran/$@

# copying data between Matlab and Fortran and calling the fibonacci function
gatewayFortran.o:./fortran/gatewayFortran.f90 fibonacci.o
	$(F90) $(FFLAGS) $(FINCLUDE) -c  $< -o ./fortran/$@

# creating the mexa64 file that Matlab can communicate with
gatewayFortran.$(EXT):gatewayFortran.o
	$(F90) $(FFLAGS) $(FINCLUDE) ./fortran/gatewayFortran.o ./fortran/globaldef.o ./fortran/fibonacci.o -o $@

# standalone.o 
standalone.o:./fortran/standalone.f90 fibonacci.o
	$(F90) $(FFLAGS) -c -Ifortran $< -o ./fortran/$@

# standalone.out
standalone.f90.out:standalone.o
	$(F90) $(FFLAGS) ./fortran/standalone.o ./fortran/fibonacci.o ./fortran/globaldef.o -o $@

# clean up
clean:
	rm -f fortran/*.o fortran/*.mod gatewayFortran.$(EXT) standalone.f90.out
