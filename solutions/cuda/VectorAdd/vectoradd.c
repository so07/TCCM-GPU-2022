#include <stdio.h>
#include <stdlib.h>

void  initVector(double *u, int n, double c) {
  int i;
  for (i=0; i<n; i++)
      u[i] = c;
}

int main(int argc, char *argv[]) {
  int i; 
  const int N = 1000;

  double * u = (double *) malloc(N * sizeof(double));
  double * v = (double *) malloc(N * sizeof(double));
  double * z = (double *) malloc(N * sizeof(double));

  initVector((double *) u, N, 1.0);
  initVector((double *) v, N, 2.0);
  initVector((double *) z, N, 0.0);

  // z = u + v
  for (i=0; i<N; i++)
      z[i] = u[i] + v[i];

  printf("%f %f %f\n", z[0], z[1], z[N-1]);

  return 0;
}
