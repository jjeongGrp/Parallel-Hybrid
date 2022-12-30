program data_scope_firstprivate
    integer a(0:9), i, tid, omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel private(a) private(tid)
    tid = omp_get_thread_num()
    a(tid) = tid + 1
!$omp end parallel

    do i=0, 3
        print *, 'a(', i, ') = ', a(i)
    end do
end
