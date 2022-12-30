PROGRAM alltoallv
INCLUDE 'mpif.h'
INTEGER isend(6), irecv(9)
INTEGER iscnt(0:2), isdsp(0:2), ircnt(0:2), irdsp(0:2)
DATA isend/1,2,2,3,3,3/
DATA iscnt/1,2,3/ isdsp/0,1,3/
CALL MPI_INIT(ierr)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
irecv=0
DO i=1,6
  isend(i)=isend(i)+nprocs*myrank
END DO
if(myrank==0) then
   ircnt =(/1,1,1/)
   irdsp = (/0,1,2/)
else if(myrank==1) then
   ircnt =(/2,2,2/)
   irdsp = (/0,2,4/)
else if(myrank==2) then
   ircnt =(/3,3,3/)
   irdsp = (/0,3,6/)
endif

CALL MPI_ALLTOALLV(isend, iscnt, isdsp, MPI_INTEGER,&
                   irecv, ircnt, irdsp, MPI_INTEGER,&
                   MPI_COMM_WORLD,ierr)
PRINT*,'myrank:',myrank,':',irecv

CALL MPI_FINALIZE(ierr)
END PROGRAM alltoallv

