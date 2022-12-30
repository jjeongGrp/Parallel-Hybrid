PROGRAM sub_array
INCLUDE 'mpif.h'
INTEGER ndims
PARAMETER(ndims=2)
INTEGER ibuf1(2:7,0:6)
INTEGER array_of_sizes(ndims), array_of_subsizes(ndims)
INTEGER array_of_starts(ndims)
CALL MPI_INIT(ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
DO j = 0, 6
   DO i = 2, 7
        IF (myrank==0) THEN
            ibuf1(i,j) = i
        ELSE
            ibuf1(i,j) = 0
        ENDIF
   ENDDO
ENDDO
array_of_sizes(1)=6; array_of_sizes(2)=7
array_of_subsizes(1)=2; array_of_subsizes(2)=5
array_of_starts(1)=1; array_of_starts(2)=1

CALL MPI_TYPE_CREATE_SUBARRAY(ndims, array_of_sizes, &
   array_of_subsizes, array_of_starts, MPI_ORDER_FORTRAN,& 
   MPI_INTEGER, newtype, ierr)
CALL MPI_TYPE_COMMIT(newtype, ierr)
CALL MPI_BCAST(ibuf1, 1, newtype, 0, MPI_COMM_WORLD, ierr)
PRINT *, 'I am :', myrank
DO i=2,7
 PRINT *, (ibuf1(i,j), j=0,6)
ENDDO
CALL MPI_TYPE_FREE(newtype,ierr)
CALL MPI_FINALIZE(ierr)

END
