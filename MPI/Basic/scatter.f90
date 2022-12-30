PROGRAM scatter
INCLUDE 'mpif.h'
INTEGER isend(3)
CALL MPI_INIT(ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
IF(myrank==0)THEN
  DO i=1,nprocs
    isend(i)=i
  END DO
ENDIF
CALL MPI_SCATTER(isend, 1, MPI_INTEGER,irecv,1,MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
PRINT*,'irecv = ',irecv
CALL MPI_FINALIZE(ierr)
END PROGRAM scatter

