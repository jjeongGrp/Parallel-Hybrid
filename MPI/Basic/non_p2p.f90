PROGRAM non_p2p
INCLUDE 'mpif.h'
   INTEGER ierr, nrank, req
   INTEGER status(MPI_STATUS_SIZE)
   INTEGER :: send = -1, recv = -1, ROOT = 0

   CALL MPI_INIT(ierr)
   CALL MPI_COMM_RANK(MPI_COMM_WORLD, nrank, ierr)
   
   IF (nrank == ROOT) THEN
      PRINT *, 'Before : nrank = ', nrank, 'send = ', send, 'recv = ', recv
      send = 7
      CALL MPI_ISEND(send, 1, MPI_INTEGER, 1, 55, MPI_COMM_WORLD,req, ierr)
      PRINT *, 'Other job calculating'

      CALL MPI_WAIT(req, status, ierr)
   ELSE 
      CALL MPI_RECV(recv, 1, MPI_INTEGER, ROOT, 55, MPI_COMM_WORLD,status, ierr)
      PRINT *, 'After  : nrank = ', nrank, 'send = ', send, 'recv = ', recv
   ENDIF

   CALL MPI_FINALIZE(ierr)

END

