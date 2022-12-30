program hello_world

!$omp parallel
    print *, 'Hello World'
!$omp end parallel
end
