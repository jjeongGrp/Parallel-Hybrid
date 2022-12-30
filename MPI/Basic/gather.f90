PROGRAM gather
INCLUDE "mpif.h"
INTEGER	isend, irecv(4), nprocs, nrank, ierr
CALL MPI_INIT(ierr)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, nrank, ierr)

isend = nrank + 1
print *, 'rank :', nrank, 'isend :', isend

CALL MPI_GATHER(isend, 1, MPI_INTEGER, irecv, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

if (nrank == 0) then
	print *, 'rank :', nrank, 'irecv =', irecv
endif

CALL MPI_FINALIZE(ierr)
END

