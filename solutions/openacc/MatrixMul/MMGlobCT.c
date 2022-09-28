#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#define DATA float


#pragma acc routine gang
void MatrixMul(DATA* M, DATA* N, DATA* hP, int Width) {
#pragma acc data present(M[Width*Width], N[Width*Width], hP[Width*Width])
{
#pragma acc loop
  for (int i = 0; i < Width; ++i) {
#pragma acc loop 
    for (int j = 0; j < Width; ++j) {
      DATA pvalue = hP[i * Width + j];
#pragma acc loop seq
      for (int k = 0; k < Width; ++k) {
        DATA a = M[i * Width + k];
        DATA b = N[k * Width + j];
        pvalue += a * b;
      }
      hP[i * Width + j] = pvalue;
    }
  }
} // pragma acc data
}


void print_matrix_tile(DATA *hP, int Width)
{
  int mintile = 5;
  int tile = (mintile < Width) ? mintile : Width;
  fprintf(stdout,"\nElements of %dx%d upper left block:\n", tile, tile);
  for(int y=0; y<tile; y++){
    for(int x=0; x<tile; x++) {
      fprintf(stdout,"%12.0f ", (float) hP[y*Width+x]);
    }
    fprintf(stdout,"\n");
  }
}


// main
int main(int argc, char** argv) {

  int Width = 1024;
  size_t totElements = (size_t) Width * Width;

  DATA *M, *N, *hP;

  struct timeval temp_1, temp_2;

// parsing arguments
  if(argc>2) {
    fprintf(stderr,"Usage: %s [Width]\n",argv[0]);
    exit(1);
  }
  if(argc == 2) {
    Width=atoi(argv[1]);
  }
  if(Width<1) {
    fprintf(stderr,"Error Width=%d, must be > 0\n",Width);
    exit(1);
  }

// buffer allocation
  M= (DATA *)malloc(sizeof(DATA)*totElements);
  N= (DATA *)malloc(sizeof(DATA)*totElements);
  hP=(DATA *)malloc(sizeof(DATA)*totElements);

  if(M==NULL || N==NULL || hP==NULL)
  {
    fprintf(stderr,"ERRORO: could not allocate enough memory for matrices\n");
    exit(1);
  }

  memset(hP,0,sizeof(DATA)*totElements);

#pragma acc enter data create( M[:totElements], N[:totElements]), copyin(hP[:totElements])

#pragma acc parallel loop collapse(2) present(M[:totElements], N[:totElements])
  for(int y=0; y<Width; y++){
    for(int x=0; x<Width; x++) {
      M[y*Width+x]=(DATA)(((y+1)*Width+x+1)/(Width));
      N[y*Width+x]=(DATA)(((y+1)*Width+x+1)/(Width));
    }
  }

#pragma acc update host (M[:totElements])
  print_matrix_tile(M, Width);

  gettimeofday(&temp_1, (struct timezone*)0);
#pragma acc parallel present(M[:totElements], N[:totElements])
{
  MatrixMul(M, N, hP, Width);
}
  gettimeofday(&temp_2, (struct timezone*)0);
  // compute and report GFlops
  double elapsed = 1.e-6*(temp_2.tv_usec-temp_1 .tv_usec) + (temp_2.tv_sec-temp_1.tv_sec);

  double flops = 2.*Width*Width*Width;
  printf("Kernel elapsed time %fs \n", elapsed);
  printf("Gflops: %lf\n", flops/elapsed*1.e-9);

#pragma acc update host (hP[:totElements])
  print_matrix_tile(hP, Width);

  free(M); free(N); free(hP);
#pragma acc exit data delete( M[:totElements], N[:totElements], hP[:totElements])

  return 0;
}
