! Example Name : 2D_Msg.f90
! Compile      : $ mpif90 -g -o 2D_Msg.x -Wall 2D_Msg.f90		
! Run          : $ mpirun -np 12 -hostfile hosts_12 2D_Msg.x

PROGRAM 2D_Msg
IMPLICIT NONE
INCLUDE 'mpif.h'
	INTEGER nRank, nProcs, nProcs_Sqrt, iErr
	INTEGER status(16), req(16)
	INTEGER :: ROOT = 0, i, j, row, col
	INTEGER nLocalROW, nLocalCOL, nGlobalROW, nGlobalCOL
	PARAMETER (nLocalROW=5, nLocalCOL=5, nGlobalROW=10, nGlobalCOL=10)

	INTEGER nLocalGrid(0:nLocalROW-1, 0:nLocalCOL-1)
	INTEGER nGlobalGrid(0:nGlobalROW-1, 0:nGlobalCOL-1)

	CALL MPI_Init(iErr)
	CALL MPI_Comm_size(MPI_COMM_WORLD, nProcs, iErr)
	CALL MPI_Comm_rank(MPI_COMM_WORLD, nRank, iErr)

	DO i = 0, nLocalROW-1
		DO j = 0, nLocalCOL-1
			nLocalGrid(i, j) = ((nRank+1) * 100) + i*nLocalCOL + j + 1
		END DO
	END DO
	CALL MPI_Barrier(MPI_COMM_WORLD, iErr)
	WRITE(*, 100) 'nRank: ', nRank
	WRITE(*, *) '------------------'
	DO i = 0, nLocalROW-1
		DO j = 0, nLocalCOL-1
			WRITE (*, 200, advance='no') nLocalGrid(i, j)
		END DO
		WRITE(*, *)
	END DO
	WRITE(*, *) '------------------'
100 FORMAT(A, I2)
200 FORMAT(I3, X)

	IF (nRank /= ROOT) THEN
		CALL MPI_Isend(nLocalGrid(0, 0), nLocalROW, MPI_INTEGER, ROOT, 11,&
                         MPI_COMM_WORLD, req(1), ierr)
		CALL MPI_Isend(nLocalGrid(0, 1), nLocalROW, MPI_INTEGER, ROOT, 12,&
                         MPI_COMM_WORLD, req(2), ierr)
		CALL MPI_Isend(nLocalGrid(0, 2), nLocalROW, MPI_INTEGER, ROOT, 13,&
                         MPI_COMM_WORLD, req(3), ierr)
		CALL MPI_Isend(nLocalGrid(0, 3), nLocalROW, MPI_INTEGER, ROOT, 14,&
                         MPI_COMM_WORLD, req(4), ierr)
		CALL MPI_Isend(nLocalGrid(0, 4), nLocalROW, MPI_INTEGER, ROOT, 15,&
                         MPI_COMM_WORLD, req(5), ierr)
		DO i = 1, 5
			CALL MPI_WAIT(req(i), status(i), ierr)
		END DO
	ELSE
		DO i = 0, nLocalCOL-1
			DO j = 0, nLocalROW-1
				nGlobalGrid(j, i) = nLocalGrid(j, i)
			END DO
		END DO

		DO i = 1, nProcs-1
			nProcs_Sqrt = SQRT(REAL(nProcs))
			row = i / nProcs_Sqrt
			col = MOD(i, nProcs_Sqrt)

			CALL MPI_Recv(nGlobalGrid(row*nLocalROW, col*nLocalCOL), nLocalROW,&
                                 MPI_INTEGER, i, 11, MPI_COMM_WORLD, status(1), ierr)
			CALL MPI_Recv(nGlobalGrid(row*nLocalROW, col*nLocalCOL+1),nLocalROW,&
                                 MPI_INTEGER, i, 12, MPI_COMM_WORLD, status(2), ierr)
			CALL MPI_Recv(nGlobalGrid(row*nLocalROW, col*nLocalCOL+2),nLocalROW,&
                                 MPI_INTEGER, i, 13, MPI_COMM_WORLD, status(3), ierr)
			CALL MPI_Recv(nGlobalGrid(row*nLocalROW, col*nLocalCOL+3),nLocalROW,&
                                 MPI_INTEGER, i, 14, MPI_COMM_WORLD, status(4), ierr)
			CALL MPI_Recv(nGlobalGrid(row*nLocalROW, col*nLocalCOL+4),nLocalROW,&
                                 MPI_INTEGER, i, 15, MPI_COMM_WORLD, status(5), ierr)
		END DO


		WRITE(*, 100) 'nRank(Total): ', nRank
		WRITE(*, *) '--------------------------------------'

		DO i = 0, nGlobalROW-1
			DO j = 0, nGlobalCOL-1
				WRITE (*, 200, advance='no') nGlobalGrid(i, j)
			END DO
			WRITE(*, *)
		END DO

		WRITE(*, *) '--------------------------------------'
	END IF

	CALL MPI_FINALIZE(iErr)

END

