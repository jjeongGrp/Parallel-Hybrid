  program pi_integral_serial
  integer, parameter:: num_steps=1000000000
  real(8) sum, step, x, pi;

  sum=0.0
  step=1./dble(num_steps)

  do i=1, num_steps
     x = (i-0.5)*step
     sum = sum + 4.0/(1.0+x*x)
  enddo
    
  pi = step*sum
  print*, "numerical  pi = ", pi
  print*, "analytical pi = ", dacos(-1.d0)
  print*, " Error = ", dabs(dacos(-1.d0)-pi)

  end
