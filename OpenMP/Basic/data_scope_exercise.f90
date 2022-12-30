program data_scope_exercise
    integer :: a(0:11), i=10, tid, omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel shared(a) private(tid) firstprivate(i)
    tid = omp_get_thread_num()
    i = i + tid
    a(tid+0) = i + 0
    a(tid+4) = i + 4
    a(tid+8) = i + 8
!$omp end parallel

!! or

!$omp parallel shared(a) private(tid) firstprivate(i)
    tid = omp_get_thread_num() * 3
    i = i + tid
    a(tid+0) = i + 0
    a(tid+1) = i + 1
    a(tid+2) = i + 2
!$omp end parallel

    do i=0, 11
        print *, 'a(', i, ') = ', a(i)
    end do
end
