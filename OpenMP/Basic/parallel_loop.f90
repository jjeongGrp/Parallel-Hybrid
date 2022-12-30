program parallel_loop
    integer, parameter :: N=20

    integer :: tid, i, istart, iend, nthreads, omp_get_thread_num, omp_get_num_threads

    call omp_set_num_threads(4)
!$omp parallel private(tid,istart,iend)
    tid = omp_get_thread_num()
    nthreads = omp_get_num_threads()

    istart = tid * N / nthreads;
    iend = (tid+1) * N / nthreads - 1;
    do i=istart, iend
        print *, 'Hello World', tid, i
    end do
!$omp end parallel
end
