program Pi_cal
	implicit none
	integer(8), parameter :: num_step=100000000
	integer(8) :: i, cnt=0, seed
	double precision :: total_pi=0.0d0, pi, x, y
 
	do i=0, num_step-1
	 	seed = mod(125*seed+5, 2796203)
		x = dble(seed) / 2796203.0
	 	seed = mod(125*seed+5, 2796203)
		y = dble(seed) / 2796203.0
		if( sqrt(x*x + y*y) <= 1.0 ) cnt = cnt + 1
	enddo
	
	total_pi = 4.0d0 * dble(cnt) / dble(num_step)
	write(*, 100) total_pi, dabs(dacos(-1.0d0)-total_pi)

100 format("PI =", F17.15, "(Error =", E11.5,")")
end
