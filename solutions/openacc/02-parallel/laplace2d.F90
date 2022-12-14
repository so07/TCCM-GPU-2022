program laplace
  use openacc
  implicit none
  integer, parameter :: fp_kind=kind(1.0d0)
  integer, parameter :: n=4096, m=4096, iter_max=100
  integer :: i, j, iter
  real(fp_kind), dimension (:,:), allocatable :: A, Anew
  real(fp_kind) :: tol=1.0e-6_fp_kind, error=1.0_fp_kind
  real(fp_kind) :: start_time, stop_time

#include "./common/select_device_f90.h"

  allocate ( A(0:n-1,0:m-1), Anew(0:n-1,0:m-1) )

  A    = 0.0_fp_kind
  Anew = 0.0_fp_kind

  ! Set B.C.
  A(0,:)    = 1.0_fp_kind
  Anew(0,:) = 1.0_fp_kind
   
  write(*,'(a,i5,a,i5,a)') 'Jacobi relaxation Calculation:', n, ' x', m, ' mesh'
 
  call cpu_time(start_time) 

  iter=0

  do while ( error .gt. tol .and. iter .lt. iter_max )
    error=0.0_fp_kind

!$acc parallel loop reduction(max: error) 
    do j=1,m-2
      do i=1,n-2
        Anew(i,j) = 0.25_fp_kind * ( A(i+1,j  ) + A(i-1,j  ) + &
                                     A(i  ,j-1) + A(i  ,j+1) )
        error = max( error, abs(Anew(i,j)-A(i,j)) )
      end do
    end do
!$acc end parallel loop

    if(mod(iter,10).eq.0 ) write(*,'(i5,f10.6)'), iter, error
    iter = iter + 1

!$acc parallel loop
    do j=1,m-2
      do i=1,n-2
        A(i,j) = Anew(i,j)
      end do
    end do
!$acc end parallel loop

  end do

  call cpu_time(stop_time) 
  write(*,'(a,f10.3,a)')  ' completed in ', stop_time-start_time, ' seconds'

  deallocate (A,Anew)
end program laplace
