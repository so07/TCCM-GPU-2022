program matrixadd
integer :: i, j
integer, parameter :: N=1000, M=1000
real (kind(0.0)), dimension(N,M) :: A, B, C

A = 1.0; B = 2.0;

! C = A + B
do j = 1,N
  do i = 1,M
    C(i,j) = A(i,j) + B(i,j)
  end do
end do

print *, C(1,1), C(2,2), C(N,M)

end program
