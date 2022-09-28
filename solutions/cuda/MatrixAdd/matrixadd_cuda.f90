module mataddcuda
  use cudafor
  contains
  attributes(global) subroutine matadd(A, B, C, N, M)
    implicit none
    integer, intent(in), value :: N, M
    real(kind(0.0)), intent(in) :: A(N,M), B(N,M)
    real(kind(0.0)), intent(inout) :: C(N,M)
    integer :: i,j
  
    !----- insert CUDA code -----
    ! define the index  
    i = ( blockIdx%x - 1 ) * blockDim%x + threadIdx%x
    j = ( blockIdx%y - 1 ) * blockDim%y + threadIdx%y
    !----------------------------
  
    !----- insert CUDA code -----
    ! ensure that the thread is not out of the vector boundary 
    if ( (i .gt. N) .or. (j .gt. M) ) return
    !----------------------------
  
    !----- insert CUDA code -----
    ! write the operation of sum of matrices for the kernel
    C(i,j) = A(i,j) + B(i,j)
    !----------------------------

  end subroutine matadd
end module


program matrixadd
use mataddcuda
implicit none

integer :: i, j
integer, parameter :: N=1000, M=1000

real (kind(0.0)), dimension(N,M) :: A, B, C

!----- insert CUDA code -----
! declare the device variables
real (kind(0.0)), dimension(N,M), device :: A_dev, B_dev, C_dev
!----------------------------

type(dim3) blockdim, griddim

A = 1.0; B = 2.0; C = 0.0

!----- insert CUDA code -----
! copy data from host to device
A_dev = A
B_dev = B
!----------------------------

blockdim = dim3(32, 32, 1)
griddim = dim3(int(N/blockdim%x)+1, int(M/blockdim%y)+1, 1)

!----- insert CUDA code -----
! define the execution configuration
call matadd<<<griddim, blockdim>>>(A_dev, B_dev, C_dev, N, M)
!----------------------------

!----- insert CUDA code -----
! copy the results from device to host
C = C_dev
!----------------------------

print *, C(N-2:N,N)

end program

