#
#FC	= gfortran 
#FC	= g95
#FC      = ~/bin/g95
FC      = gfortran
CC	= gcc
LD	= $(FC)
F77	= $(FC)
SWP	= swplist
RM	= /bin/rm -f
MP	=
ABI	= 
ISA	= 
PROC	= 
ARCH	= $(MP) $(ABI) $(ISA)
OLEVEL  =  -O5
#OLEVEL  =  -O3 -scalar_rep  -vec -prefetch -tpp6
#OLEVEL  =  -O3 -scalar_rep  -vec -prefetch -tpp6  -axK -pad
#FOPTS   = -r8
FOPTS   = -fdefault-real-8

COPTS	= 
FFLAGS	= $(ARCH) $(OLEVEL) $(FOPTS)
CFLAGS	= $(ARCH) $(COPTS)
#LIBS	= -lPEPCF90
LIBS    =
LDFLAGS	= $(ARCH) $(OLEVEL)
PROF	=

FOBJS   = meshparams.o meshvars.o\
          meshinput.o meshallocs.o\
          meshx.o meshbcs.o \
          meshcluster.o meshorthyz.o\
          mesh2dout.o mesh3douti.o\
          meshorthxyxz.o\
          meshvtk.o  meshgen.o

COBJS	= 
OBJS	= $(FOBJS) $(COBJS)
EXEC	= meshgen

$(EXEC):	$(OBJS)
	$(LD) -o $@ $(PROF) $(LDFLAGS) $(QV_LOPT) $(OBJS) $(LIBS)

clean:
	$(RM) $(EXEC) $(OBJS)

.SUFFIXES:
.SUFFIXES: .o .F .c .f .swp

.F.o:
	$(FC)  -c $(FFLAGS) $(QV_OPT) $(DEFINES) $<

.f.o:
	$(FC)  -c $(FFLAGS) $(QV_OPT) $(DEFINES) $<

.c.o:
	$(CC)  -c $(CFLAGS) $(QV_OPT) $(DEFINES) $<

.F.swp:
	$(SWP) -c $(FFLAGS) $(QV_OPT) $(DEFINES) -WK,-cmp=$*.m $<

.f.swp:
	$(SWP) -c $(FFLAGS) $(QV_OPT) $(DEFINES) -WK,-cmp=$*.m $<

.c.swp:
	$(SWP) -c $(CFLAGS) $(QV_OPT) $(DEFINES) $<
