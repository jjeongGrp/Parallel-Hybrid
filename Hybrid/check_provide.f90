program check_provide
   implicit none
   include 'mpif.h'
   integer rank,  provide, ierr

   call  MPI_Init_thread(MPI_THREAD_MULTIPLE, provide, ierr)
   call  MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

    print *,  'rank = ',  rank,  ' provide = ',  provide
    call MPI_Finalize(ierr)
end
