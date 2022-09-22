program vectoradd
integer :: i
integer, parameter :: N=1000
real (kind(0.0d0)), dimension(N) :: u, v, z

u = 1.0d0; v = 2.0d0;

! z = u + v
do i = 1,N
    z(i) = u(i) + v(i)
end do

print *, z(1), z(2), z(N)

end program
