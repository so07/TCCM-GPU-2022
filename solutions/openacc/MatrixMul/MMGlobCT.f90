subroutine print_matrix_tile(M, width)
integer :: width
real, dimension(width,width) :: M
integer :: mintile = 5

mintile = min(mintile,width)
print '(a,i1,a,i1,a)','Elements of ',mintile,'x',mintile,' upper left block:'
print '(5F12.0)', ((M(i,j), i=1,5), j=1,5)
end subroutine print_matrix_tile

subroutine mmul_host( A, B, C, N )
!$acc routine gang
integer, value :: N
real, dimension(N,N) :: A, B, C
integer i,j,k
!$acc data present(A, B, C)
!$acc loop
do j=1,N
!$acc loop
  do k=1,N
!$acc loop seq
    do i=1,N
       C(i,j) = C(i,j) + A(i,k)*B(k,j)
    enddo
  enddo
enddo
!$acc end data
end subroutine mmul_host

program main_mmul

interface
subroutine mmul_host( A, B, C, N )
!$acc routine gang
integer, value :: N
real, dimension(N,N) :: A, B, C
integer i,j,k
end subroutine mmul_host
end interface


real, dimension(:,:),allocatable:: A,B,C
integer, parameter :: N = 1024
integer :: i,j
integer :: clock_start, clock_stop, clock_rate
real :: elapsed
call system_clock(count_rate=clock_rate)

allocate(A(N,N),B(N,N),C(N,N))
!$acc enter data create(A, B, C)

! initialize matrices
!$acc kernels present(A, B, C)
C = 0.
do i=1,N
  do j=1,N
     A(i,j) = (i*N+j)/N 
     B(i,j) = (i*N+j)/N 
  enddo
enddo
!$acc end kernels

call system_clock(count=clock_start)
!$acc parallel present(A, B, C)
call mmul_host( A, B, C, N)
!$acc end parallel
call system_clock(count=clock_stop)
! compute and report GFlops
elapsed = real(clock_stop-clock_start)/real(clock_rate)
flops = 2*float(N)*float(N)*float(N)
print*,'Kernel elapsed time ', elapsed,'s '
print*,'Gflops: ', 1.e-9*flops/elapsed

!$acc update host (C)
!call print_matrix_tile(C, N)
print '(5F12.0)', ((C(i,j), i=1,5), j=1,5)

!$acc exit data delete(A, B, C)

end program
