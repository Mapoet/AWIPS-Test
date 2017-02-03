C MEMBER RPDDLY
C  (from old member PDRPDDLY)
C-----------------------------------------------------------------------
C
      SUBROUTINE RPDDLY (ITYPE,IDATE,IRETRN,LPNTRS,IPNTRS,LPFILL,
     *    LDATA,IDATA,LDFILL,NUMSTA,MSNG,LENDAT,IDATES,ISTAT)
C
C          SUBROUTINE:  RPDDLY
C
C 12/11/86 SRS ALLOW FOR NEW DATA TYPES PPST, PG24 AND APIG. FIRST
C WORD IN DATA RECORD IS NUMBER OF ACTUAL WORDS OF DATA (LIKE PPSR)
C 9/11/84 CORRECT RETURN OF LPFILL FOR STRANGER STATIONS
C 8-4-83 ALLOW FOR MISSPP DIFFERENT FOR PPSR AND PP24
C  VERSION 1.0.1 4-13-83 FIX PPSR TO PUT DATA IN FIRST WORD
C             VERSION:  1.0.1
C
C                DATE:  01-10-83
C
C              AUTHOR:  SONJA R SIEGEL
C                       DATA SCIENCES INC
C
C***********************************************************************
C
C          DESCRIPTION:
C
C    THIS ROUTINE WILL READ THE DATA AND IF DESIRED, THE POINTERS
C    FOR 1 DAY OF DAILY DATA OF A DATA TYPE
C
C***********************************************************************
C
C          ARGUMENT LIST:
C
C         NAME    TYPE  I/O   DIM   DESCRIPTION
C
C       ITYPE     A4    I     1     DAILY DATA TYPE
C       IDATE      I    I     1     DESIRED DATE
C       IRETRN     I    I     1     0=RETURN ONLY DATA
C                                   1=RETURN POINTERS AND DATA
C                                   2=RETURN ONLY POINTERS
C       LPNTRS     I    I     1     LENGTH OF ARRAY IPNTRS
C       IPNTRS    I*2   O   LPNTRS  POINTERS ARRAY
C       LPFILL     I    O     1     NUMBER OF I*2 WORDS FILLED IN IPNTRS
C       LDATA      I    I     1     LENGTH OF DATA ARRAY
C       IDATA     I*2   O   LDATA   DATA ARRAY
C       LDFILL     I    O     1     NUMBER OF I*2 WORDS FILLED IN IDATA
C       NUMSTA     I    O     1     NUMBER OF STATIONS DEFINED
C       MSNG        I     O    1    VALUE OF MISSING DATA (-999)
C      LENDAT       I     I    1    LENGTH OF DATES ARRAY FOR FUT ONLY
C      DATES        I     O  LENDAT DATES ARRAY FOR FUT DATES
C       ISTAT       I     O    1    STATUS CODE
C                                      0=OK
C                                      1=POINTER ARRAY TOO SMALL
C                                      2=DATA ARRAY TOO SMALL
C                                      3=STATUS CODES 1 AND 2
C                                      4=DATE NOT FOUND
C                                      5=INVALID DATA TYPE
C                                      6=VALID TYPE BUT NO DATA EXISTS
C                                      7=IDATES TOO SMALL - FUTURE DATA
C                                        NOT READ
C                                      8=SYSTEM ERROR ACCESSING FILE
C
C***********************************************************************
C
C          COMMON:
C
      INCLUDE 'uio'
      INCLUDE 'udebug'
      INCLUDE 'pdbcommon/pddtdr'
      INCLUDE 'pdbcommon/pdunts'
      INCLUDE 'pdbcommon/pdbdta'
      INCLUDE 'pdbcommon/pdsifc'
C
C***********************************************************************
C
C          DIMENSION AND TYPE DECLARATIONS:
C
      INTEGER*2 IPNTRS(LPNTRS)
      INTEGER*2 IDATA(1),IWORK(32),MSNG
C
      DIMENSION IDATES(1)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/db_pdbrw/RCS/rpddly.f,v $
     . $',                                                             '
     .$Id: rpddly.f,v 1.1 1995/09/17 18:44:36 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA LTF24/4hTF24/
      DATA LPPSR/4hPPSR/,LPPST/4hPPST/,LPG24/4hPG24/,LAPIG/4hAPIG/
      DATA LPP24/4hPP24/
C
C***********************************************************************
C
C
      IF (IPDTR.GT.0) WRITE (IOGDB,200)
C
      ISTAT=0
C
      ISTSAV=0
      LRCPD2=LRCPDD*2
      MSNG=MISSNG
      IF (ITYPE.EQ.LPPSR.OR.ITYPE.EQ.LPP24) MSNG=MISSPP
      IAMGRD=0
      IF (ITYPE.EQ.LPPST.OR.ITYPE.EQ.LAPIG.OR.ITYPE.EQ.LPG24)
     *   IAMGRD=1
      LPFILL=0
      LDFILL=0
      NUMSTA=0
C
C  FIND THE TYPE IN THE DIRECTORY
      ITX=IPDCDW(ITYPE)
      IF (ITX.EQ.0) GO TO 10
C
C  MAKE SURE THIS IS A READ TYPE (NOT A WRITE ONLY TYPE)
      IF (IDDTDR(4,ITX).GT.0) GO TO 20
C
C  NOT A VALID READ TYPE
10    ISTAT=5
      GO TO 190
C
C  CHECK IF ANY STATIONS OF THIS TYPE
20    IF (IDDTDR(16,ITX).GT.0) GO TO 30
      ISTAT=6
      GO TO 190
C
C  GET FILE NUMBER
30    IFILE=IDDTDR(4,ITX)
      IF (IPDDB.GT.0) WRITE (IOGDB,210) (IDDTDR(M,ITX),M=1,24)
C
C  GET NUMBER OF STATIONS DEFINED
      NUMSTA=IDDTDR(17,ITX)
C
C  GET RECORD NUMBER WHERE POINTERS BEGIN
      IREC=IDDTDR(14,ITX)
C
C  SEE IF POINTERS ARE REQUESTED OR IF THERE ARE NONE
      LPFILL=IDDTDR(18,ITX)
      IF (IRETRN.EQ.0.OR.IDDTDR(14,ITX).EQ.0.OR.IDDTDR(18,ITX).EQ.0)
     *   GO TO 60
C
C  GET THE POINTER RECORD FOR THIS TYPE
      IF (LPNTRS.GE.LPFILL) GO TO 40
C
C  NOT ENOUGH ROOM, SET STATUS AND RESET LPFILL
      ISTSAV=1
      LPFILL=LPNTRS
C
C  COMPUTE NUMBER OF RECORDS FOR POINTERS
40    NREC=IUNRCD(LPFILL,LRCPD2)
      IF (IPDDB.GT.0) WRITE (IOGDB,215) LPFILL,NREC
C
      IF (NREC.EQ.0) GO TO 60
C
      NREC=NREC-1
      IF (NREC.LE.0) GO TO 55
C
C  READ ALL BUT THE LAST RECORD SO EXTRA ARRAY SPACE ISNT NEEDED
      CALL RVLRCD (KPDDDF(IFILE),IREC,NREC,IPNTRS,LRCPDD,ISTAT)
      IF (ISTAT.NE.0) GO TO 170
C
C  READ THE LAST POINTER RECORD INTO A WORK BUFFER
55    IREC=IREC+NREC
      CALL UREADT (KPDDDF(IFILE),IREC,IWORK,ISTAT)
      IF (ISTAT.NE.0) GO TO 170
C
C  MOVE POINTERS FROM LAST RECORD
      M=NREC*LRCPD2+1
      I=1
      DO 50 J=M,LPFILL
         IPNTRS(J)=IWORK(I)
         I=I+1
50       CONTINUE
      IF (IPDDB.GT.0) WRITE (IOGDB,220) (IPNTRS(M),M=1,LPFILL)
C
C  CHECK IF ONLY POINTERS TO BE RETURNED
60    IF (IRETRN.EQ.2) GO TO 190
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  GET DATES
      CALL UMEMOV (IDDTDR(8,ITX),IEDATE,1)
      CALL UMEMOV (IDDTDR(11,ITX),LDATE,1)
C
C  CHECK DATE REQUESTED
      IF (IDATE.GE.IEDATE.AND.IDATE.LE.LDATE) GO TO 80
C
C  DATE NOT FOUND
70    ISTAT=4
      GO TO 190
C
C  CHECK IF FUTURE TEMP DATA
80    IF (ITYPE.NE.LTF24) GO TO 90
C
C  FUTURE DATA - GET DATES AND FIND THIS ONE
      CALL PDGFUD (IDATES,LENDAT,ITX,IREC,ISTAT)
      IF (ISTAT.NE.0) GO TO 180
      CALL PDFNDD (IDATE,IDATES,IDTXX)
      IF (IDTXX.EQ.0) GO TO 70
      IREC=IDATES(IDTXX+1)
      IF (IREC.LE.0) GO TO 70
      GO TO 100
C
C  GET RECORD
90    CALL PDCREC (IDATE,IEDATE,ITX,IREC)
C
100   IF (IPDDB.GT.0) WRITE (IOGDB,230) IREC
C
C  READ ALL BUT THE LAST - CHECK SIZE OF FIRST
      LDFILL=IDDTDR(19,ITX)
      IF (LDFILL.EQ.0) GO TO 160
      IF (LDATA.GE.LDFILL) GO TO 110
      ISTSAV=ISTSAV+2
      IF (LDATA.LT.0) GO TO 190
      LDFILL=LDATA
C
C  READ THE DATA
110   NREC=IUNRCD(LDFILL,LRCPD2)-1
      IF (NREC.LE.0) GO TO 120
      CALL RVLRCD (KPDDDF(IFILE),IREC,NREC,IDATA,LRCPDD,ISTAT)
      IF (ISTAT.NE.0) GO TO 170
C
C  READ LAST DATA RECORD
120   M=NREC*LRCPD2+1
      IREC=IREC+NREC
      CALL UREADT (KPDDDF(IFILE),IREC,IWORK,ISTAT)
      IF (ISTAT.NE.0) GO TO 170
      I=1
      DO 130 J=M,LDFILL
         IDATA(J)=IWORK(I)
         I=I+1
130      CONTINUE
C
C IF THIS IS PPSR, RESET LDFILL AND NUMSTA FROM RECORD
C ALSO FOR PPST, APIG AND PG24, LDFILL=NUMSTA=IDATA(1)
      IF (ITYPE.NE.LPPSR.AND.IAMGRD.NE.1) GO TO 150
      LPFILL=0
C
C  MOVE DATA DOWN ONE WORD
      IF (IDATA(1).LT.0) GO TO 160
      NUMSTA=IDATA(1)
      DO 140 I=2,LDFILL
         IDATA(I-1)=IDATA(I)
140      CONTINUE
      IF (ITYPE.EQ.LPPSR) LDFILL=NUMSTA*3
      IF (ITYPE.NE.LPPSR) LDFILL=NUMSTA
      IF (LDFILL.GT.LDATA) LDFILL=LDATA
150   IF (IPDDB.GT.0) WRITE (IOGDB,240) (IDATA(I),I=1,LDFILL)
      GO TO 190
C
C PPSR, PPST, PG24, APIG NO STATIONS
160   LDFILL=0
      NUMSTA=0
      GO TO 190
C
C READ ERROR
170   ISTAT=8
      GO TO 190
C
C  IDATES TO SMALL - FUTURE DATA NOT READ
180   ISTAT=7
C
190   IF (ISTAT.EQ.0) ISTAT=ISTSAV
C
      IF (IPDTR.GT.0) WRITE (IOGDB,250) ISTAT
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
200   FORMAT (' *** ENTER RPDDLY')
210   FORMAT (' DIRECTORY=',I3,2A2,21I5)
215   FORMAT (' LPFILL=',I4,3X,'NREC=',I3)
220   FORMAT (' POINTERS=',20I5)
230   FORMAT (' IREC=',I5)
240   FORMAT (' DATA=',10I8)
250   FORMAT (' *** EXIT RPDDLY : ISTAT=',I2)
C
      END