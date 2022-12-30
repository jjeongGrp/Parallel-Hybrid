PROGRAM reduce
IMPLICIT NONE
INCLUDE "mpif.h"
	
	INTEGER nrank, ierr, ista, iend, i
	REAL a(9), sum, tsum
	
	CALL MPI_INIT(ierr)
	CALL MPI_COMM_RANK(MPI_COMM_WORLD, nrank, ierr)
	
	ista = nrank * 3 + 1
	iend = ista + 2

	DO i=ista, iend
		a(i) = i
	ENDDO

	sum = 0.0
	DO i=ista, iend
		sum = sum + a(i)
	ENDDO

	CALL MPI_REDUCE(sum, tsum, 1, MPI_REAL, MPI_SUM, 0, MPI_COMM_WORLD, ierr)

	IF (nrank == 0) THEN
		PRINT *, 'sum =',tsum
	ENDIF
	CALL MPI_FINALIZE(ierr)
END


