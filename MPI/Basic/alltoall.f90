PROGRAM alltoall
INCLUDE 'mpif.h'
INTEGER isend(3), irecv(3)
CALL MPI_INIT(ierr)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
DO i=1,nprocs
  isend(i)=i+nprocs*myrank
END DO
PRINT*,'isend=',isend

CALL MPI_ALLTOALL(isend,1,MPI_INTEGER, &
                  irecv,1,MPI_INTEGER, &
                  MPI_COMM_WORLD, ierr)
print*,'irecv=',irecv

CALL MPI_FINALIZE(ierr)
END PROGRAM alltoall

