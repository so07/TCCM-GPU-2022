#include <stdio.h>

void  initMatrix(double *A, int n, int m, double c) {
  int i,j;
  for (i=0; i<n; i++)
    for (j=0; j<m; j++)
      A[i*m+j] = c;
}

int main(int argc, char *argv[]) {
  int i, j; 
  const int N = 1000, M = 1000;
  double A[N][M], B[N][M], C[N][M];

  initMatrix((double *) A, N, M, 1.0);
  initMatrix((double *) B, N, M, 2.0);
  initMatrix((double *) C, N, M, 0.0);

  // C = A + B
  for (i=0; i<N; i++)
    for (j=0; j<M; j++)
      C[i][j] = A[i][j] + B[i][j];

  printf("%f %f %f\n", C[0][0], C[1][1], C[N-1][M-1]);

  return 0;
}
