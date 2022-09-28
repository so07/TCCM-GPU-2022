PGCC  = nvc -O3 -ta=tesla -Minfo=all -acc=noautopar
PGF90 = nvfortran -O3 -ta=tesla -Minfo=all -acc=noautopar

BIN = laplace2d_kernels_data

help:
	@echo "Please specify the make target"
	@echo "make c or make f"

c: laplace2d.c
	$(PGCC) -o $(BIN) $<

f: laplace2d.F90
	$(PGF90) -o $(BIN) $<

clean:
	$(RM) $(BIN) 
