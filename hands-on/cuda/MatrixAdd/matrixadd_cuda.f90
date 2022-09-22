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

    !----------------------------
  
    !----- insert CUDA code -----
    ! ensure that the thread is not out of the vector boundary 

    !----------------------------
  
    !----- insert CUDA code -----
    ! write the operation of sum of matrices for the kernel

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

!----------------------------

type(dim3) blockdim, griddim

A = 1.0; B = 2.0; C = 0.0

!----- insert CUDA code -----
! copy data from host to device

!----------------------------

blockdim = dim3(32, 32, 1)
griddim = dim3(int(N/blockdim%x)+1, int(M/blockdim%y)+1, 1)

!----- insert CUDA code -----
! define the execution configuration

!----------------------------

!----- insert CUDA code -----
! copy the results from device to host

!----------------------------

print *, C(N-2:N,N)

end program

