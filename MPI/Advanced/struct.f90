PROGRAM type_struct
INCLUDE 'mpif.h'
INTEGER err, rank
TYPE DDT
  INTEGER::num
  REAL::x
  COMPLEX::data(4)
END TYPE DDT
INTEGER status(MPI_STATUS_SIZE)
INTEGER blocklengths(3)
DATA blocklengths/1,1,4/
INTEGER displacements(3)
INTEGER types(3), restype
DATA types/MPI_INTEGER,MPI_REAL,MPI_COMPLEX/
INTEGER intex, realex
TYPE(DDT)::a
CALL MPI_INIT(err)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, rank,err)
CALL MPI_TYPE_EXTENT(MPI_INTEGER,intex,err)
CALL MPI_TYPE_EXTENT(MPI_REAL,realex,err)
displacements(1)=0;  displacements(2)=intex;  displacements(3)=intex+realex
CALL MPI_TYPE_STRUCT(3, blocklengths, displacements, types, restype, err)
CALL MPI_TYPE_COMMIT(restype,err)
IF(rank .eq. 3)THEN
  a%num=6; a%x=3.14
  DO i=1,4
    a%data(i)=cmplx(i,i)
  END DO
  CALL MPI_SEND(a,1,restype,1,30,MPI_COMM_WORLD,err)
ELSEIF(rank .eq.1)THEN
  CALL MPI_RECV(a,1,restype,3,30,MPI_COMM_WORLD,status, err)
PRINT *, 'P:',rank, ' I got'
  PRINT *, a%num
  PRINT *, a%x
  PRINT *, a%data
ENDIF
CALL MPI_TYPE_FREE(restype,err)
CALL MPI_FINALIZE(err)
END PROGRAM type_struct

