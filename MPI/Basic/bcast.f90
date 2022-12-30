PROGRAM bcast
INCLUDE "mpif.h"

   INTEGER buf(4), nprocs, nrank, ierr
   INTEGER :: ROOT = 0

   DATA buf/0, 0, 0, 0/
	
   CALL MPI_INIT(ierr)
   CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
   CALL MPI_COMM_RANK(MPI_COMM_WORLD, nrank, ierr)

   IF (nrank == ROOT) THEN
      buf(1) = 5; buf(2) = 6; buf(3) = 7; buf(4) = 8
   END IF

   print *, 'rank = ', nrank, ' Before :', buf

   CALL MPI_BCAST(buf, 4, MPI_INTEGER, ROOT, MPI_COMM_WORLD, ierr)

   print *, 'rank = ', nrank, ' After  :', buf

   CALL MPI_FINALIZE(ierr)
END

