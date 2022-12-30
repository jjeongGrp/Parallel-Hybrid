PROGRAM type_contiguous
INCLUDE 'mpif.h'
INTEGER ibuf(20)
INTEGER inewtype
ibuf=0
CALL MPI_INIT(ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
IF (myrank==0) THEN
   DO i=1,20
      ibuf(i) = i
   ENDDO
ENDIF
CALL MPI_TYPE_CONTIGUOUS(3, MPI_INTEGER, inewtype, ierr)
CALL MPI_TYPE_COMMIT(inewtype, ierr)
CALL MPI_BCAST(ibuf, 3, inewtype, 0, MPI_COMM_WORLD, ierr)
PRINT *,'ibuf =',ibuf
CALL MPI_TYPE_FREE(inewtype,ierr);
CALL MPI_FINALIZE(ierr)
END
