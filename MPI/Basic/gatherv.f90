PROGRAM gatherv
INCLUDE 'mpif.h'
INTEGER isend(3), irecv(6)
INTEGER ircnt(0:2), idisp(0:2)
DATA ircnt/1,2,3/ idisp/0,1,3/
CALL MPI_INIT(ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
DO i=1,myrank+1
   isend(i) = myrank + 1
ENDDO
iscnt = myrank + 1
CALL MPI_GATHERV(isend,iscnt,MPI_INTEGER,irecv,ircnt,idisp,&
   MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
IF (myrank==0) THEN
   PRINT *,'irecv =',irecv
ENDIF
CALL MPI_FINALIZE(ierr)
END

