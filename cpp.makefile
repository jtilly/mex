# define matlab dir
MDIR = /etc/matlab

# compiles mex files using g++
CC = g++

# compiler flags for g++
CCFLAGS = -O3 -shared -fpic

# to use the intel compiler instead, uncomment CC and CCFLAGS below:

# compiles mex file using the intel compiler
# CC = icpc

# compiler flags for intel compiler
# CCFLAGS = -O3 -shared -fPIC -D__amd64

# flags for stand alone program
CCFLAGS_STANDALONE = -O3

# Figure out which platform we're on
UNAME = $(shell uname -s)

# Linux
ifeq ($(findstring Linux,${UNAME}), Linux)
	# define which files to be included
	CINCLUDE = -I$(MDIR)/extern/include -Ic++
	# define extension
	EXT = mexa64
endif

# Mac OS X
ifeq ($(findstring Darwin,${UNAME}), Darwin)
	# define which files to be included
	CINCLUDE = -L$(MDIR)/bin/maci64 -I$(MDIR)/extern/include -Ic++ -lmx -lmex -lmat
	# define extension
	EXT = mexmaci64
	CCFLAGS += -std=c++11 
endif

# the output file will be called gatewayCpp.mexa64
all : gatewayCpp.$(EXT) standalone.cpp.out

# fibonacci function: this is where the action happens
fibonacci.o:./c++/fibonacci.cpp
	$(CC) $(CCFLAGS) -c -Ic++ $< -o ./c++/$@

# copying data between Matlab and Fortran and calling the fibonacci function
gatewayCpp.o:./c++/gatewayCpp.cpp fibonacci.o
	$(CC) $(CCFLAGS) $(CINCLUDE) -c  $< -o ./c++/$@

# creating the mexa64 file that Matlab can communicate with
gatewayCpp.$(EXT):gatewayCpp.o
	$(CC) $(CCFLAGS) $(CINCLUDE) ./c++/gatewayCpp.o ./c++/fibonacci.o -o $@

# standalone.o 
standalone.o:./c++/standalone.cpp fibonacci.o
	$(CC) $(CCFLAGS) -c -Ic++ $< -o ./c++/$@

# standalone.out
standalone.cpp.out:standalone.o
	$(CC) $(CCFLAGS_STANDALONE) ./c++/standalone.o ./c++/fibonacci.o -o $@

# clean up
clean:
	rm -f cpp/*.o gatewayCpp.$(EXT) standalone.cpp.out
