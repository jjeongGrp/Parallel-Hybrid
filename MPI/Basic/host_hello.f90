PROGRAM  hello
IMPLICIT  NONE
INCLUDE  'mpif.h'

	INTEGER  nRank, nProcs, nNameLen, iErr
	CHARACTER(10)  procName
	INTEGER  myar(5, 5)

	CALL  MPI_Init(iErr)
	CALL  MPI_Comm_size(MPI_COMM_WORLD, nProcs, iErr)
	CALL  MPI_Comm_rank(MPI_COMM_WORLD, nRank, iErr)

	CALL  MPI_Get_processor_name(procName, nNameLen, iErr)

	WRITE (*, *) 'Hello World. (Process name = ', procName, ', nRank = ', nRank, ', nProcs = ',nProcs, ')'
	
	CALL  MPI_FINALIZE(iErr)

END

