#include <stdio.h>
#include <stdlib.h>

void  initVector(double *u, int n, double c) {
  int i;
  for (i=0; i<n; i++)
      u[i] = c;
}

__global__ void gpuVectAdd(double *u, double *v, double *z, int N) 
{
  //----- insert CUDA code -----
  // define index
  //int i = 
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  //----------------------------

  //----- insert CUDA code -----
  // check that the thread is not out of the vector boundary
  if (i >= N ) return;
  //----------------------------

  int index = i; 
  //----- insert CUDA code -----
  // write the operation for the sum of vectors 
  z[index] = u[index] + v[index];
  //----------------------------
}


int main(int argc, char *argv[]) {

  // size of vectors
  const int N = 1000;

  // allocate memory on host
  double * u = (double *) malloc(N * sizeof(double));
  double * v = (double *) malloc(N * sizeof(double));
  double * z = (double *) malloc(N * sizeof(double));

  initVector((double *) u, N, 1.0);
  initVector((double *) v, N, 2.0);
  initVector((double *) z, N, 0.0);

  //----- insert CUDA code -----
  // allocate memory on device
  double *u_dev, *v_dev, *z_dev;
  cudaMalloc((void **) &u_dev, N*sizeof(double));
  cudaMalloc((void **) &v_dev, N*sizeof(double));
  cudaMalloc((void **) &z_dev, N*sizeof(double));
  //----------------------------

  //----- insert CUDA code -----
  // copy data from host to device
  cudaMemcpy(u_dev, u, N*sizeof(double), cudaMemcpyHostToDevice);
  cudaMemcpy(v_dev, v, N*sizeof(double), cudaMemcpyHostToDevice);
  //----------------------------

  dim3 block(32);
  dim3 grid((N-1)/block.x + 1);

  //----- insert CUDA code -----
  // define the execution configuration
  //gpuVectAdd<<<...,...>>>(.....);
  gpuVectAdd<<<grid, block>>>(u_dev, v_dev, z_dev, N);
  //----------------------------

  //----- insert CUDA code -----
  // copy data from device to host
  cudaMemcpy(z, z_dev, N*sizeof(double), cudaMemcpyDeviceToHost);
  //----------------------------

  printf("%f %f %f\n", z[0], z[1], z[1]);

  //----- insert CUDA code -----
  // free resources on device
  cudaFree(u_dev);
  cudaFree(v_dev);
  cudaFree(z_dev);
  //----------------------------

  // free resources on host
  free(u);
  free(v);
  free(z);

  return 0;
}

