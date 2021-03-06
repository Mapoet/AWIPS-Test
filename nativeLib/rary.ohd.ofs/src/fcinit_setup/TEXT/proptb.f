C MODULE PROPTB
C----------------------------------------------------------------------
C
      SUBROUTINE PROPTB (P,MP,C,MC,T,MT,TS,MTS,MD,MINDT,IOPT,ITOP)
C.......................................
C     THIS SUBROUTINE PRINTS THE OPERATIONS TABLE FOR A SEGMENT.
C     OPTIONS ARE AS FOLLOWS:
C                  IOPT.LT.1  PRINT CARRYOVER ONLY
C                  IOPT.EQ.1  PRINT BOTH PARAMETERS AND CARRYOVER
C                  IOPT.GT.1  PRINT PARAMETERS ONLY
C     OPERATIONS ARE PRINTED IN THE ORDER THAT THEY ARE EXECUTED.
C.......................................
C     SUBROUTINE INITIALLY WRITTEN BY...
C        ERIC ANDERSON - HRL   DEC. 1979
C.......................................
      DIMENSION P(MP),C(MC),TS(MTS)
      INTEGER T(MT)
      DIMENSION OLDNAM(2),SNAME(2),OPOLD(2),OPID(2),OPNAMP(2)
C
C     COMMON BLOCKS
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/IONUM/IN,IPR,IPU
      COMMON/WHERE/ISEG(2),IOPNUM,OPNAME(2)
      COMMON/FPROG/MAINUM,VERS,VDATE(2),PNAME(5),NDD
      COMMON/FCOPPT/LOCT,LPM,LCO
      COMMON/OPLIST/NOLIST,LISTOP(50)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_setup/RCS/proptb.f,v $
     . $',                                                             '
     .$Id: proptb.f,v 1.3 2001/06/13 09:41:03 mgm Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENTS
      DATA SNAME/4HPROP,4HTB  /
      DATA BLANK/4H    /
      DATA IBUG/4HSGPR/
      DATA ST,SP,SC,STS/2HT ,2HP ,2HC ,2HTS/
C.......................................
C     TRACE LEVEL FOR THIS SUBROUTINE=1
      IF(ITRACE.GE.1) WRITE(IODBUG,900)
  900 FORMAT(1H0,17H** PROPTB ENTERED)
      CALL UMEMOV (OPNAME,OLDNAM,2)
C.......................................
C     CHECK FOR DEBUG OUTPUT
      IF (IFBUG(IBUG).EQ.1) GO TO 110
      GO TO 111
C     DEBUG OUTPUT -- PRINT T,P,C, AND TS ARRAYS.
  110 CALL FDMPT(ST,T,MT)
      CALL FDMPA(SP,P,MP)
      CALL FDMPA(SC,C,MC)
      CALL FDMPA(STS,TS,MTS)
C.......................................
C     INITIAL VALUES
  111 LOCT=1
      IOPNP=IOPNUM
      OPNAMP(1)=OPNAME(1)
      OPNAMP(2)=OPNAME(2)
C.......................................
C     PRINT HEADING FOR THE OPERATIONS TABLE.
      IF(ITOP.EQ.1) WRITE(IPR,901)
  901 FORMAT(1H1)
      IF (MAINUM.LT.3) GO TO 100
      IF (IOPT.LT.1) GO TO 100
      WRITE(IPR,907)
  907 FORMAT (1H0,20X,52H***********************************************
     1*****)
      WRITE(IPR,902)
  902 FORMAT(1H0,20X,52HTHE OPERATIONS USED FOR THIS SEGMENT ARE AS FOLL
     1OWS.)
      WRITE(IPR,907)
C.......................................
C     PRINT THE OPERATIONS TABLE
C
C     FIND NUMBER OF NEXT OPERATION.
  100 NUMOP=T(LOCT)
C     CHECK FOR STOP OPERATION.
      IF(NUMOP.EQ.-1) GO TO 90
      IERR=0
C
C     CHECK IF OPERATION IS TO BE PRINTED.
      IF (NOLIST.EQ.0) GO TO 80
      DO 81 N=1,NOLIST
      IF (NUMOP.EQ.LISTOP(N)) GO TO 80
   81 CONTINUE
      GO TO 99
C
   80 IF(NUMOP.EQ.4) GO TO 85
C.......................................
C     DETERMINE WHERE OPERATION IS IN THE P AND C ARRAYS.
C     ALSO SET WHERE COMMON BLOCK VALUES AND GET OLD NAME.
      LPM=T(LOCT+2)
      LCO=P(LPM-1)
      IOPNUM=NUMOP
      OPNAME(1)=P(LPM-5)
      OPNAME(2)=P(LPM-4)
      OPOLD(1)=P(LPM-3)
      OPOLD(2)=P(LPM-2)
      GO TO 86
C
C     SPECIAL OPERATIONS - NO ENTRY IN P OR C ARRAYS
   85 LPM=0
      LCO=0
      IOPNUM=NUMOP
      OPNAME(1)=BLANK
      OPNAME(2)=BLANK
      OPOLD(1)=BLANK
      OPOLD(2)=BLANK
C.......................................
C     CHECK IF (IOPT.LT.1) THAT THE OPERATION HAS CARRYOVER.
   86 IF(IOPT.GE.1) GO TO 87
      IF(LCO.EQ.0) GO TO 99
C.......................................
C     GET OPERATION IDENTIFIER.
   87 CALL FOPCDX(OPID,NUMOP)
C.......................................
C     CHECK FOR DEBUG OUTPUT.
      IF (IFBUG(IBUG).EQ.1) WRITE(IODBUG,906) ISEG,NUMOP,OPNAME,LOCT,
     1LPM,LCO,IOPT
  906 FORMAT (1H0,19HPROPTB DEBUG--ISEG=,2A4,3X,6HNUMOP=,I3,3X,
     17HOPNAME=,2A4,3X,5HLOCT=,I5,3X,4HLPM=,I5,3X,4HLCO=,I5,3X,
     25HIOPT=,I1)
C.......................................
C     WRITE TITLE FOR OPERATION
      IF (IOPT.LT.1) GO TO 88
      WRITE(IPR,903)
  903 FORMAT(1H0)
      WRITE(IPR,904)
  904 FORMAT(1H0,20H********************)
      IF(MAINUM.GT.2) GO TO 88
      WRITE(IPR,905) OPID,OPNAME,OPOLD
  905 FORMAT(1H0,2A4,1X,9HOPERATION,5X,5HNAME=,2A4,5X,14HPREVIOUS NAME=,
     12A4)
      GO TO 89
   88 WRITE(IPR,910) OPID,OPNAME
  910 FORMAT(1H0,2A4,1X,9HOPERATION,5X,5HNAME=,2A4)
   89 IF (IOPT.GT.0) WRITE(IPR,904)
C.......................................
C     GO TO THE PROPER PROPT SUBROUTINE FOR THE OPERATION AND CALL
C        APPROPRIATE PRINT ROUTINES.
      IF (NUMOP.GT.19) GO TO 120
      CALL PROPT1(P,MP,C,MC,T,MT,TS,MTS,IOPT,NUMOP,IERR)
      GO TO 129
  120 IF (NUMOP.GT.40) GO TO 121
      CALL PROPT2(P,MP,C,MC,T,MT,TS,MTS,IOPT,NUMOP,IERR)
      GO TO 129
  121 CALL PROPT3(P,MP,C,MC,T,MT,TS,MTS,IOPT,NUMOP,IERR)
  129 IF (IERR.EQ.0) GO TO 99
C.......................................
C     PUT PROPER VALUES IN THE WHERE COMMON BLOCK.
      IOPNUM=0
      OPNAME(1)=SNAME(1)
      OPNAME(2)=SNAME(2)
C
C     CALL TO OPERATION DOES NOT EXIST IN THIS SUBROUTINE.
      WRITE(IPR,911)NUMOP
  911 FORMAT(1H0,10X,75H**ERROR** THE PROPTB SUBROUTINE DOES NOT CONTAIN
     1 A CALL TO OPERATION NUMBER,I4,1H.)
      CALL ERROR
      GO TO 99
C.......................................
C     STOP OPERATION HAS BEEN REACHED -- CALL PRSTOP.
   90 IF (IOPT.LT.1) GO TO 98
      CALL PRSTOP(MP,MC,MT,MTS,MD,MINDT)
      GO TO 98
C.......................................
C     INCREMENT TO THE NEXT OPERATION
   99 LOCT=T(LOCT+1)
      IF(LOCT.LE.MT) GO TO 100
      GO TO 90
C.......................................
   98 CONTINUE
      IOPNUM=IOPNP
      OPNAME(1)=OPNAMP(1)
      OPNAME(2)=OPNAMP(2)
      CALL UMEMOV (OLDNAM,OPNAME,2)
      RETURN
      END
