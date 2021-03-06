C MEMBER SWSTBN
C-----------------------------------------------------------------------
C
C                             LAST UPDATE: 03/09/94.07:54:32 BY $WC20SV
C
C @PROCESS LVL(77)
C
C DESC WRITE STBN STATE BOUNDARY (STBN) PARAMETER RECORD
C
      SUBROUTINE SWSTBN (IVSTBN,UNUSD,MDRBND,STBNPT,
     *   LARRAY,ARRAY,DISP,ISTAT)
C
      REAL NEW/4HNEW /,OLD/4HOLD /
C
      DIMENSION ARRAY(LARRAY)
      DIMENSION MDRBND(4),STBNPT(89,1)
C
      REAL BLNKID(2)/2*4H    /
C
      INCLUDE 'uio'
      INCLUDE 'scommon/sudbgx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_write/RCS/swstbn.f,v $
     . $',                                                             '
     .$Id: swstbn.f,v 1.1 1995/09/17 19:16:28 dws Exp $
     . $' /
C    ===================================================================
C
C
C
      IF (ISTRCE.GT.0) WRITE (IOSDBG,80)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
C  SET DEBUG LEVEL
      LDEBUG=ISBUG('STBN')
C
      IF (LDEBUG.GT.0) WRITE (IOSDBG,90) IVSTBN,UNUSD,LARRAY
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
C
      ISTAT=0
C
C  CHECK FOR SUFFICIENT SPACE IN PARAMETER ARRAY
      MINLEN=7+MDRBND(2)*MDRBND(4)
      IF (LDEBUG.GT.0) WRITE (IOSDBG,110) MINLEN
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
      IF (MINLEN.LE.LARRAY) GO TO 10
         WRITE (LP,140) LARRAY,MINLEN
         CALL SULINE (LP,2)
         ISTAT=1
         CALL SUEROR
         GO TO 70
C
C  STORE PARAMETER ARRAY VERSION NUMBER
10    ARRAY(1)=IVSTBN+.01
C
C  STORE WESTERN MOST MDR COLUMN FOR WHICH STBN PARAMETERS DEFINED
      ARRAY(2)=MDRBND(1)+.01
C
C  STORE NUMBER OF MDR COLUMNS
      ARRAY(3)=MDRBND(2)+.01
C
C  STORE SOUTHERN MOST MDR ROW
      ARRAY(4)=MDRBND(3)+.01
C
C  STORE NUMBER OF MDR ROWS
      ARRAY(5)=MDRBND(4)+.01
C
C  POSITIONS 6 AND 7 UNUSED
      ARRAY(6)=UNUSD
      ARRAY(7)=UNUSD
C
      NPOS=7
C
C  STORE STATE BOUNDARY POINTS FOR MDR SUBSET
      IF (LDEBUG.EQ.0) GO TO 30
         WRITE (IOSDBG,120) (MDRBND(I),I=1,4)
         CALL SULINE (IOSDBG,1)
         DO 20 I=1,89
            WRITE (IOSDBG,130) I,(STBNPT(I,J),J=1,42)
20          CALL SULINE (IOSDBG,1)
30    IC=MDRBND(1)
      NCOL=MDRBND(2)
      IR=MDRBND(3)
      NROW=MDRBND(4)
      DO 40 J=1,NROW
         DO 40 I=1,NCOL
            NPOS=NPOS+1
            ARRAY(NPOS)=STBNPT(IR+NROW-J,I)
40          CONTINUE
C
C  WRITE PARAMETER RECORD TO FILE
      IF (LDEBUG.GT.0) WRITE (IOSDBG,100) NPOS
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
      IPTR=0
      CALL WPPREC (BLNKID,'STBN',NPOS,ARRAY,IPTR,IRWREC)
      IF (IRWREC.EQ.0) GO TO 50
         CALL SWPPST (BLNKID,'STBN',NPOS,IPTR,IRWREC)
         WRITE (LP,150) IRWREC
         CALL SULINE (LP,2)
         ISTAT=3
         CALL SUEROR
C
50    IF (LDEBUG.GT.0) CALL SUPDMP ('STBN','BOTH',0,NPOS,ARRAY,ARRAY)
C
      IF (ISTAT.EQ.0.AND.DISP.EQ.NEW) WRITE (LP,160)
      IF (ISTAT.EQ.0.AND.DISP.EQ.NEW) CALL SULINE (LP,2)
      IF (ISTAT.EQ.0.AND.DISP.EQ.OLD) WRITE (LP,170)
      IF (ISTAT.EQ.0.AND.DISP.EQ.OLD) CALL SULINE (LP,2)
      IF (ISTAT.GT.0.AND.DISP.EQ.NEW) WRITE (LP,180)
      IF (ISTAT.EQ.0) CALL SUDWRT (1,'PPP ',IERR)
      IF (ISTAT.GT.0.AND.DISP.EQ.NEW) CALL SULINE (LP,2)
      IF (ISTAT.GT.0.AND.DISP.EQ.OLD) WRITE (LP,190)
      IF (ISTAT.GT.0.AND.DISP.EQ.OLD) CALL SULINE (LP,2)
C
70    IF (ISTRCE.GT.0) WRITE (IOSDBG,200)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
      RETURN
C
C - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
80    FORMAT (' *** ENTER SWSTBN')
90    FORMAT (' IVSTBN=',I2,3X,'UNUSD=',F7.2,3X,'LARRAY=',I5)
100   FORMAT (' NPOS=',I5)
110   FORMAT (' MINLEN=',I5)
120   FORMAT (' MDRBND=',4(I3,1X))
130   FORMAT (1H ,I3,2X,42A3)
140   FORMAT ('0*** ERROR - IN SWSTBN - NOT ENOUGH SPACE IN PARAMETER ',
     *   'ARRAY: NUMBER OF WORDS IN PARAMETER ARRAY=',I5,3X,
     *   'NUMBER OF WORDS NEEDED=',I5)
150   FORMAT ('0*** ERROR - IN SWSTBN - UNSUCCESSFUL CALL TO WPPREC : ',
     *   'STATUS CODE=',I3)
160   FORMAT ('0*** NOTE - STBN PARAMETERS SUCCESSFULLY WRITTEN.')
170   FORMAT ('0*** NOTE - STBN PARAMETERS SUCCESSFULLY UPDATED.')
180   FORMAT ('0*** NOTE - STBN PARAMETERS NOT SUCCESSFULLY ',
     *   'WRITTEN.')
190   FORMAT ('0*** NOTE - STBN PARAMETERS NOT SUCCESSFULLY ',
     *   'UPDATED.')
200   FORMAT (' *** EXIT SWSTBN')
C
      END
