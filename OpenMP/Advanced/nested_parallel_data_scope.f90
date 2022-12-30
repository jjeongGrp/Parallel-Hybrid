program nested_parallel_data_scope
    integer :: x=1, y=10, z=20, tid
    integer omp_get_thread_num

    call omp_set_nested(.true.)
    call omp_set_num_threads(4)

!$omp parallel private(y, tid)
    tid = omp_get_thread_num()
    x = x + 1
    y = 12
    z = 22
        !$omp parallel num_threads(2) private(x,tid)
        tid = omp_get_thread_num()
        x = 10
        y = y + 1
        z = z + 1
        print 30, 'tid =', tid, ' x =', x, ' y=', y, ' z=', z
        !$omp end parallel
    print 20, 'tid =', tid, ' x =', x, ' y=', y, ' z=', z
!$omp end parallel
print 10, ' x =', x, ' y=', y, ' z=', z

10 format(A,I4,A,I4,A,I4)
20 format(A,I4,A,I4,A,I4,A,I4)
30 format(T8,A,I4,A,I4,A,I4,A,I4)
end
