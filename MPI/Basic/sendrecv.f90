PROGRAM isend
INCLUDE 'mpif.h'
INTEGER err, rank, size, count
REAL data(100), value(200)
INTEGER status(MPI_STATUS_SIZE)

CALL MPI_INIT(err)
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,err)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD,size,err)

IF (rank.eq.0) THEN
    data=3.0
    CALL MPI_SEND(data,100,MPI_REAL,1,55,MPI_COMM_WORLD,err)
ELSEIF (rank .eq. 1) THEN
    CALL MPI_RECV(value,200,MPI_REAL,MPI_ANY_SOURCE,55, &
    MPI_COMM_WORLD,status,err)
    PRINT *, "P:",rank," got data from processor ", &
    status(MPI_SOURCE)
    CALL MPI_GET_COUNT(status,MPI_REAL,count,err)
    PRINT *, "P:",rank," got ",count," elements"
    PRINT *, "P:",rank," value(5)=",value(5)
ENDIF

CALL MPI_FINALIZE(err)

END

