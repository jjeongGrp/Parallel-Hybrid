PROGRAM hello
INCLUDE 'mpif.h'
   INTEGER iErr
   CALL MPI_Init(iErr)
   WRITE (*, *) 'Hello, World'
   CALL MPI_Finalize(iErr)
END

