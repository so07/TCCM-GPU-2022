#include <stdio.h>

void  initMatrix(float *A, int n, int m, float c) {
  int i,j;
  for (i=0; i<n; i++)
    for (j=0; j<m; j++)
      A[i*m+j] = c;
}

__global__ void gpuMatAdd(float *A, float *B, float *C, int N, int M) 
{
  //----- insert CUDA code -----
  // define index
  int i = 
  int j = 
  //----------------------------

  //----- insert CUDA code -----
  // check that the thread is not out of the vector boundary

  //----------------------------

  int index = j*M + i; 
  //----- insert CUDA code -----
  // write the operation for the sum of vectors 

  //----------------------------
}

int main(int argc, char *argv[]) {

   // size of matrix
  const int N = 1000, M = 1000;

  // allocate memory on host
  float * A = (float *) malloc(N*M * sizeof(float));
  float * B = (float *) malloc(N*M * sizeof(float));
  float * C = (float *) malloc(N*M * sizeof(float));

  initMatrix((float *) A, N, M, 1.0);
  initMatrix((float *) B, N, M, 2.0);
  initMatrix((float *) C, N, M, 0.0);


  //----- insert CUDA code -----
  // allocate memory on device
  float *A_dev, *B_dev, *C_dev;

  //----------------------------

  //----- insert CUDA code -----
  // copy data from host to device

  //----------------------------

  dim3 block(32,32);
  dim3 grid(M/block.x + 1, N/block.y + 1);

  //----- insert CUDA code -----
  // define the execution configuration

  //----------------------------

  //----- insert CUDA code -----
  // copy data from device to host

  //----------------------------

  printf("%f %f %f\n", C[0], C[1], C[3]);

  //----- insert CUDA code -----
  // free resources on device

  //----------------------------

  // free resources on host
  free(A);
  free(B);
  free(C);

  return 0;
}

