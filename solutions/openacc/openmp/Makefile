PGCC  = nvc -O3 -mp
PGF90 = nvfortran -O3 -mp

BIN = laplace2d_omp

help:
	@echo "Please specify the make target"
	@echo "make c or make f"

c: laplace2d.c
	$(PGCC) -o $(BIN) $<

f: laplace2d.F90
	$(PGF90) -o $(BIN) $<

clean:
	$(RM) $(BIN) 
