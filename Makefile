# ----- Make Macros -----

CXX = CC
CXXFLAGS = -std=c++11 -fopenmp
OPTFLAGS = -O3

NVCC = nvcc
NVCCFLAGS = -O3 -std=c++11 -gencode arch=compute_35,code=sm_35 -ccbin=CC -Xcompiler -fopenmp

LD_FLAGS = -lgomp -InvToolsExt $(CRAY_CUDATOOLKIT_POST_LINK_OPTS)

TARGETS = ptycho
OBJECTS = main.o raytrace.o kernels.o

# ----- Make Rules -----

all:	$(TARGETS)

%.o: %.cpp
	${CXX} ${CXXFLAGS} ${OPTFLAGS} $^ -c -o $@

%.o : %.cu
	${NVCC} ${NVCCFLAGS} $^ -c -o $@

ptycho: $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LD_FLAGS)

clean:
	rm -f $(TARGETS) *.o *.o.* *.txt *.bin core
