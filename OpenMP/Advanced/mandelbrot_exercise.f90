program ex
    integer, parameter :: X_RESN=4000, Y_RESN=4000
    real, parameter  :: X_MIN=-2.0, X_MAX=2.0, Y_MIN=-2.0, Y_MAX=2.0

    complex :: z, c
    integer  :: i, j, k, maxIterations=1000
    real  :: lengthsq, temp
    integer, dimension(0:X_RESN-1, 0:Y_RESN-1)  :: res

    DO j=0, Y_RESN-1
        DO i=0, X_RESN-1
            z = (0.0, 0.0)
            c = cmplx( X_MIN+real(j)*(X_MAX-X_MIN)/real(X_RESN), Y_MAX - real(i) * (Y_MAX - Y_MIN)/real(Y_RESN) )
            k=0
loop:       DO
                temp = REAL(z)*REAL(z)-AIMAG(z)*AIMAG(z) + REAL(c)
                z=cmplx( temp, 2.0*REAL(z)*AIMAG(z)+AIMAG(c))
                lengthsq = REAL(z)*REAL(z)+AIMAG(z)*AIMAG(z)
                k=k+1
                if (lengthsq >= 4.0 .or.  k >= maxIterations) exit loop
            END DO loop

            if ( k >= maxIterations) then
                res(i, j) = 0
            else
                res(i, j) = 1
            end if
        END DO
    ENDDO
end 


