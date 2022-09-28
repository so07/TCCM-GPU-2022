module vectaddcuda
  use cudafor
  contains
  attributes(global) subroutine vectadd(u, v, z, N)
    implicit none
    integer, intent(in), value :: N
    real(kind(0.0d0)), intent(in) :: u(N), v(N)
    real(kind(0.0d0)), intent(inout) :: z(N)
    integer :: i
  

    !----- insert CUDA code -----
    ! define the global index  
    i = ( blockIdx%x - 1 ) * blockDim%x + threadIdx%x
    !----------------------------

    !----- insert CUDA code -----
    ! ensure that the thread is not out of the vector boundary 
    if  (i .gt. N)  return
    !----------------------------

    !----- insert CUDA code -----
    ! write the operation of sum of vector for the kernel
    z(i) = u(i) + v(i)
    !----------------------------

  end subroutine vectadd
end module


program vectoradd
use vectaddcuda
implicit none

integer :: i
integer, parameter :: N=1000

real (kind(0.0d0)), dimension(N) :: u, v, z

!----- insert CUDA code -----
! declare the device variables
real (kind(0.0d0)), dimension(N), device :: u_dev, v_dev, z_dev
!----------------------------

type(dim3) block, grid

u = 1.0d0; v = 2.0d0; z = 0.0d0

!----- insert CUDA code -----
! copy data from host to device
u_dev = u
v_dev = v
!----------------------------

block = dim3(32, 1, 1)
grid = dim3(int(N/block%x)+1, 1, 1)

!----- insert CUDA code -----
! define the execution configuration
!call vectadd<<<...,...>>>(......)
call vectadd<<<grid, block>>>(u_dev, v_dev, z_dev, N)
!----------------------------

!----- insert CUDA code -----
! copy the results from device to host
z = z_dev
!----------------------------

print *, z(N-2:N)

end program

