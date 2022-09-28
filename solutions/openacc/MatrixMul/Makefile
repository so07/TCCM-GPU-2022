CC = nvc
FC = nvfortran

CFLAG = -fast
FFLAG = -fast
ACCFLAGS = -acc -ta:tesla -Minfo=acc

dummy:
	@echo -e "make c\t\tcompile all OpenACC C sources"
	@echo -e "make f90\t\tcompile all OpenACC F90 sources"
	@echo -e "make clean\t\trm -f *.x *.mod"

c:    MMGlobCT_c.x
f90: MMGlobCT_f.x

MMGlobCT_c.x: MMGlobCT.c
	$(CC) $(CFLAG) $(ACCFLAGS) $< -o $@

MMGlobCT_f.x: MMGlobCT.f90
	$(FC) $(FFLAG) $(ACCFLAGS) $< -o $@

clean:
	rm -f *.x *.mod *.ptx
