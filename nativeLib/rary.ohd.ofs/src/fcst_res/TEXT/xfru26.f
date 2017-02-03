C MODULE XFRU26
C
C DESC COMPUTE AND STORE THE RULE CURVE ELEVATIONS FOR THE ENTIRE
C DESC  RUN PERIOD.
C-------------------------------------------------------------------
      SUBROUTINE XFRU26(PO,LOCP,W,LOCOWS)
C------------------------------------------------------------------
C  SUBROUTINE TO STORE THE RULE CURVE 'TIME-SERIES' IN THE WORK
C  ARRAY, W, SET SOME COMMON BLOCK VARIABLES, AND SET THE REFERENCE
C  POINTER FOR LATER STORAGE OF RULE CURVE INFO.
C
C  THE LOCATION, LOCP, PASSED TO THIS ROUTINE IS WHERE THE RULE
C  CURVE SHOULD BE DEFINED. IF THE VALUE IN THE PO ARRAY AT THIS
C  LOCATION IS NEGATIVE, WE MUST GO TO THAT POSITION TO GET THE ORIGINAL
C  DEFINITION OF THE RULE CURVE.
C--------------------------------------------------------------------
C  WRITTEN BY - JOE OSTROWSKI - HRL - JULY 1983
C---------------------------------------------------------------------
C
      INCLUDE 'common/fdbug'
      INCLUDE 'common/resv26'
      INCLUDE 'common/rulc26'
      INCLUDE 'common/exg26'
C
      DIMENSION PO(*),W(*),LOCOWS(*)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_res/RCS/xfru26.f,v $
     . $',                                                             '
     .$Id: xfru26.f,v 1.3 1998/07/02 17:04:28 page Exp $
     . $' /
C    ===================================================================
C
C
C  WRITE TRACE INFO IF REQUESTED
C
      IF (IBUG.GE.1) WRITE(IODBUG,1600)
 1600 FORMAT('   *** ENTER XFRU26 ***')
C
C  MUST FIRST CHECK TO SEE IF THE DEFINITION OF THE RULE CURVE REQUESTED
C  IS ALREADY IN THE COMMON BLOCK.
C  (MUST REDEFINE THE LOCATION OF THE ORIGINAL DEFINITION IF THE VALUE
C   OF PO AT LOCP IS NEGATIVE)
C
      LOCPT = LOCP
      IF (PO(LOCP).LT.0) LOCPT = -PO(LOCP) + IOFPRM
C
C  NOW SEE IF THE LAST RULECURVE STORED IN LOCOWS WAS PULLED FROM THE
C  SAME LOCATION IN THE PO ARRAY.
C
C  (RULE CURVE IS MULTIPLE DEFINITION 1.)
C
      LOCW = LOCOWS(2)
      IF (LOCPT.EQ.MRLOC(1)) GO TO 5000
C
C  THIS IS A NEW RULE CURVE DEFINITION, SO WE NEED TO STORE THE PROPER
C  VALUES FOR ITS USE.
C
      MRLOC(1) = LOCPT
C
      NRUL = PO(LOCPT)
C
      LONEXT = LOCPT + 2*NRUL + 1
      KHRRUL = PO(LONEXT)
      IF(KHRRUL.LT.0) KHRRUL=KHRBGN
      NTIMES = PO(LONEXT+1)
      QLIMRL = PO(LONEXT+2)
C
C  SUBROUTINE CREATES THE RULE CURVE 'TIME-SERIES', AND SETS THE FIRST
C  RULE CURVE ELEVATION, BGNRCE.
C
C  (THIS 'TIME-SERIES' IS STORED IN THE WORK ARRAY, W. THE LOCATION FOR
C   STORAGE IS HELD IN THE OPTIONAL WORK LOCATION ARRAY, LOCOWS, IN THE
C   SECOND POSITION, AS RULE CURVE STORAGE IS THE SECOND OPTIONAL REQU-
C   IREMENT FOR WORK SPACE USAGE.)
C
      CALL ERUL26(W(LOCW),PO(LOCPT+1),PO(LOCPT+NRUL+1))
C
C  SET RULE CURVE ELEVATIONS AT BEGINNING AND END OF PERIOD
C
 5000 CONTINUE
      RULEL1 = W(LOCW+NS2-2)
      IF (NS2.EQ.1) RULEL1 = BGNRCE
      RULEL2 = W(LOCW+NS2-1)
C
C  THAT'S IT, WE'VE STORED ALL THERE IS FOR A RULE CURVE.
C
 9000 CONTINUE
      IF (IBUG.GE.1) WRITE(IODBUG,1699)
 1699 FORMAT('    *** EXIT XFRU26 ***')
      RETURN
      END