CC = gcc
FC = nvfortran
NVCC = nvcc

CFLAG = -O3
FFLAG = -Mcuda=cc70 -fast
NVCCFLAG = -arch=sm_70 -Xcompiler=-O3

dummy:
	@echo -e "make cuda\t\tcompile all CUDA sources"
	@echo -e "make cudafor\t\tcompile all CUDAFORTRAN sources"
	@echo -e "make clean\t\trm -f *.x *.mod"

cuda:    matrixadd_c.x
cudafor: matrixadd_f.x

matrixadd_c.x: matrixadd_cuda.cu
	$(NVCC) $(NVCCFLAG) $< -o $@

matrixadd_f.x: matrixadd_cuda.f90
	$(FC) $(FFLAG) $< -o $@

clean:
	rm -f *.x *.mod *.ptx
