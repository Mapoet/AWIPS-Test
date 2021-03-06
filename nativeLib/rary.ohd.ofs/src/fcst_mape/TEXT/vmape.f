C MODULE VMAPE
C-----------------------------------------------------------------------
C
C  THIS ROUTINE COMPUTES THE MEAN POTEbNTIAL EVAPORATION FOR AN AREA
C  FROM THE STATION PE DATA.
C
C  INPUTS:
C    - COMPUTED STATION POINT PE VALUES
C    - BASIN LONG TERM MONTHLY MEANS OF PE
C    - BLEND FACTOR
C    - BASIN PARAMETERS FROM THE MAPE PARM FILE
C      THESE INCLUDE THE BASIN ID, THE STATIONS USED
C      TO ESTIMATE EACH BASIN, AND THE STATION WEIGHTS
C    - THE NUMBER OF OBSERVED DAYS IN THE RUN AND THE TOTAL NUMBER OF
C      DAYS IN THE RUN
C    - THE JULIAN DAY OF THE FIRST DAY OF THE RUN
C
C  OUTPUTS:
C    - TIME SERIES FOR THE DESIRED NUMBER OF DAYS ARE WRITTEN INTO
C      THE PROCESSED DATA FILE FOR EACH MAPE AREA
C
      SUBROUTINE VMAPE (PECOMP,PEPARM,PEPUSE,MXDDIM,MXPDIM,MXP2,
     *   NPECF,PECF)
C
      CHARACTER*8 OLDOPN
C
      DIMENSION PECOMP(MXDDIM),PEPARM(MXP2),PEPUSE(100)
      DIMENSION PECF(NPECF)
      DIMENSION ESTSYM(30),SID(2)
      PARAMETER (LTSDATA=31)
      DIMENSION TSDATA(LTSDATA)
      PARAMETER (LWKBUF=100)
      DIMENSION IWKBUF(LWKBUF)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/pudbug'
      INCLUDE 'prdcommon/pdatas'
      COMMON /FCTIME/ IDARUN,IHRRUN,LDARUN,HRRRUN,LDACPD,LHRCPD,
     *   NOW(5),LOCAL,NOUTZ,NOUTDS,NLSTZ,IDA,IHR,LDA,LHR,IDADAT
      COMMON /FCTIM2/ INPTZC,NHOPDB,NHOCAL,NHROFF(8)
      COMMON /VTIME/ JDAYO,IYRS,MOS,JDAMOS,IHRO,IHRS,JDAMO,JDAYYR
      COMMON /VSTUP/ PTYPE,DTYPE,METRIC,CPETIM(2),UTYPE,BTYPE,EST(3)
      COMMON /VFIXD/ LRY,MRY,NDAYS,NDAYOB,LARFIL,LPDFIL
      COMMON /VMODAS/ LSTDAM(13)
      COMMON /VUNTS/ ISTEP,IUNITS,ICALL
      COMMON /VOPT /JAPTN,JPTN,JMAPE,LSTDY
      COMMON /VSTCTL/ LOOKUP(200),JCMAX,LOOKDN(200)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_mape/RCS/vmape.f,v $
     . $',                                                             '
     .$Id: vmape.f,v 1.5 2000/07/21 19:20:36 page Exp $
     . $' /
C    ===================================================================
C
      DATA BLANK/4H    /
C
C
      IF (IPTRCE.GT.0) WRITE (IOPDBG,*) 'ENTER VMAPE'
C
      IOPNUM=-1
      CALL FSTWHR ('VMAPE   ',IOPNUM,OLDOPN,IOLDOP)
C
      IBUG=IPBUG('VMPE')
C
      IF (IBUG.GT.0) WRITE (IOPDBG,10) BTYPE
10    FORMAT (' IN VMAPE : BTYPE=',A4)
C
      NBSIDX=0
C
C  SET POINTER FOR PARM ARRAY EQUAL TO ZERO
      JPNTR=0
      JO=JPNTR
C
C  IREC IS THE POINTER TO THE NEXT WRITE POINTER IN THE
C  PROCESSED DATA BASE.  HERE IREC IS SET TO -1 SO THAT
C  FOR THE FIRST WRITE THE HASHING ALGORITHM IS USED AND
C  AND THEREAFTER THE POINTER WILL BE USED.
      IREC=-1
C
20    NBSIDX=NBSIDX+1
      SID(1)=BLANK
      SID(2)=BLANK
C
C  SET INDICATORS OF ESTIMATED DATA
      DO 30 J=1,NDAYS
         ESTSYM(J)=EST(1)
30       CONTINUE
C
C  LIMIT ARRAY SIZE TO REALISTIC VALUE
      JPPMX=MXP2
      IF (MXP2.GT.100)JPPMX=100
C
C  READ THE MAPE PARAMETRIC FILE TO GET BASIN PE PARAMETERS
      CALL RPPREC (SID,BTYPE,JPNTR,JPPMX,PEPARM,NFIL,MPTRNX,ISTAT)
      IF (ISTAT.LT.1) GO TO 40
         IF (ISTAT.EQ.6) GO TO 440
         CALL PSTRDC (ISTAT,BTYPE,SID,JPNTR,JPPMX,NFIL)
40    JO=JPNTR
      JPNTR=MPTRNX
      IF (IBUG.GT.0) THEN
CCC         CALL VPPREC (PEPARM,MPTRNX,MXPDIM,NFIL,ISTAT,SID,1)
         ENDIF
C
      IF (NBSIDX.GT.1)GO TO 60
C
C  GET BLEND PERIOD
      IF (IBUG.GT.0) WRITE (IOPDBG,50) UTYPE,JPPMX
50    FORMAT (' IN VMAPE JUST BEFORE READING USER FILE: UTYPE=',A4,
     *   ' JPPMX=',I6)
      SID(1)=BLANK
      SID(2)=BLANK
      JUMAX=100
      IPTR=0
      CALL RPPREC (SID,UTYPE,IPTR,JUMAX,PEPUSE,NFIL,NPTRNX,ISTAT)
      IF (ISTAT.NE.1) THEN
         CALL PSTRDC(ISTAT,UTYPE,SID,IPTR,JUMAX,NFIL)
         ENDIF
      IF (IBUG.GT.0) THEN
CCC         CALL VPPREC (PEPUSE,NPTRNX,JUMAX,NFIL,ISTAT,SID,1)
         ENDIF
C
C  SET BLEND FACTOR
      BF=1/PEPUSE(17)
C
C  SET POINTERS FOR WEIGHTS, PT PE VALUES AND DEFINE NUMBER OF
C  STATIONS INFLUENCING BASIN
60    NPE=PEPARM(39)
      IF (IBUG.GT.0) WRITE (IOPDBG,70) NPE
70    FORMAT (' IN VMAPE BEFORE DOING OBSERVED PERIOD: NPE=',I5)
      JDAGUD=0
C
C  COMPUTE MAPE FOR OBSERVED PERIOD
      KWT=40+3*NPE-1
      DO 240 JDA=1,NDAYOB
         SUMPE=0.0
         SUMWT=0.0
         NABSTA=JCMAX
         DO 100 J=1,NPE
C        SET POINTERS TO ACCOUNT FOR ALPHABETIC REARRANGEMENT
            JSTA=PEPARM(40+2*NPE-1+J)
            IF (IBUG.GT.0.AND.NABSTA.GT.0) WRITE (IOPDBG,80) NABSTA,
     *         JSTA,LOOKUP(JSTA),NDAYOB,LOOKDN(JSTA)
80    FORMAT (' IN VMAPE : NABSTA=',I5,' JSTA=',I5,
     *   ' LOOKUP(JSTA)=',I5,' NDAYOB=',I5,' LOOKDN(JSTA)=',I5)
            KSTA=JSTA
            IF (NABSTA.GT.0) KSTA=LOOKDN(JSTA)
            KPE=(KSTA-1)*NDAYOB+JDA
            KWG=KWT+J
            IF (IBUG.GT.0) WRITE (IOPDBG,90) KPE,KWG,PEPARM(KWG)
90    FORMAT (' IN VMAPE : KPE=',I4,' PEPARM(',I4,')=',F6.2)
            IF (PECOMP(KPE).GT.0.0) SUMWT=SUMWT+PEPARM(KWT+J)
100         CONTINUE
         IF (SUMWT.LT.0.001) GO TO 150
            JDAGUD=JDA
C        COMPUTE MAPE FOR THIS DATA ON THIS BASIN
            DO 130 J=1,NPE
               KSTA=PEPARM(40+2*NPE-1+J)
               IF (NABSTA.GT.0) KSTA=LOOKDN(KSTA)
               KPE=(KSTA-1)*NDAYOB+JDA
               PE=PECOMP(KPE)
               IF (PE.LT.0.001) GO TO 130
               PE=PE*PECF(KSTA)
               SUMPE=SUMPE+PE*PEPARM(KWT+J)
               IF (IBUG.GT.0) WRITE (IOPDBG,110) PE,SUMPE,PEPARM(KWT+J)
110   FORMAT (' IN VMAPE : PE=',F6.2,' SUMPE=',F6.2,
     *   ' PEPARM(KWT+J)=',F6.2)
               IF (IBUG.GT.0) WRITE (IOPDBG,120) KPE,SUMWT,JDA,PE
120   FORMAT (' IN VMAPE : KPE=',I4,' SUMWT=',F10.2,
     *   ' JDA=',I4,' PE=',F6.2)
130            CONTINUE
            SUMPE=SUMPE/SUMWT
            TSDATA(JDA)=SUMPE
            IF (IBUG.GT.0) WRITE (IOPDBG,140) JDA,SUMWT,TSDATA(JDA)
140   FORMAT (' IN VMAPE : JDA=',I5,' SUMWT=',F6.2,' TSDATA(JDA)=',F6.2)
            GO TO 240
C     MISSING DATA
150      LCURDA=JDAMOS+JDA-1
         ESTSYM(JDA)=EST(2)
         IF (JDAGUD.EQ.JDA) ESTSYM(JDA)=EST(3)
         IF (IBUG.GT.0) WRITE (IOPDBG,160) JDAGUD,JDAMOS,MOS
160   FORMAT (' IN VMAPE WHEN MISSING DATA: JDAGUD=',I5,
     *   ' JDAMOS=',I3,' MOS=',I3)
C     COMPUTE MAPE FOR NON OBSERVED DAYS
         IF (LCURDA.LT.16) GO TO 180
            KQMO=MOS
            TSDATA(JDA)=PEPARM(12+KQMO)+(LCURDA-16)*PEPARM(24+KQMO)
            KURDA=JDAMOS+JDAGUD-1
            AVE=PEPARM(12+KQMO)+(KURDA-16)*PEPARM(24+KQMO)
            IF (IBUG.GT.0) WRITE (IOPDBG,170) JDA,KURDA
170   FORMAT (' IN VMAPE WHEN MISSING DATA FOR DAY ',I3,' KURDA=',I5)
            GO TO 200
180      KQMO=MOS
         KQMQ=KQMO-1
         KURDA=JDAMOS+JDAGUD-1
         IF (KQMQ.LT.1)KQMQ=12
         TSDATA(JDA)=PEPARM(12+KQMO)-(16-LCURDA)*PEPARM(24+KQMQ)
         AVE=PEPARM(12+KQMO)-(16-KURDA)*PEPARM(24+KQMO)
         IF (IBUG.GT.1) WRITE (IOPDBG,190) JDA,JDAGUD,AVE,FX,
     *       PEPARM(12+KQMO),PEPARM(24+KQMQ)
190   FORMAT (' IN VMAPE : JDA=',I5,' JDAGUD=',I5,
     *   ' AVE=',F9.2,' FX=',F6.3,' MENPE=',F6.2,' DELPE=',F6.3)
C     BLEND TO MEAN PE
200      IF (JDA.LT.1.OR.JDAGUD.LT.1) GO TO 220
            JQ=JDAGUD
            FX=(JDA-JQ)*BF
            F=FX
            IF (F.GT.(1.-BF)) ESTSYM(JDA)=EST(3)
            IF (IBUG.GT.0) WRITE (IOPDBG,210) JQ,BF,F,ESTSYM(JDA)
210   FORMAT (' IN VMAPE :',
     *   ' JQ=',I5,' BF=',F6.2,' F=',F6.2,' ESTSYM(JDA)=',A1)
            IF (F.GT.1.0) F=1.
            TSDATA(JDA)=TSDATA(JDA)+(TSDATA(JDAGUD)-AVE)*(1.-F)
220      IF (IBUG.GT.0) WRITE (IOPDBG,230) JDA,TSDATA(JDA)
230   FORMAT (' IN VMAPE : JDA=',I5,' TSDATA(JDA)=',F10.4)
240      CONTINUE
C
      IF (IBUG.GT.0) WRITE (IOPDBG,250) NDAYS,NDAYOB
250   FORMAT (' IN VMAPE BEGINNING TO COMPUTE FUTURE MAPE: NDAYS=',I5,
     *   ' NDAYOB=',I5)
      IF (NDAYS.EQ.NDAYOB) GO TO 390
C
C  COMPUTE MAPE FOR FUTURE PERIOD
      IF (IBUG.GT.0) WRITE (IOPDBG,260) NDAYS,NDAYOB,MOS,LSTDAM(MOS)
260   FORMAT (' IN VMAPE BEFORE DOING FUTURE DATA: NDAYS=',I5,
     *   ' NDAYOB=',I5,' LSTDAY(',I3,')=',I3)
      KQMO=MOS
      IFDAY=NDAYOB+1
      DO 380 JDA=IFDAY,NDAYS
         LCURDA=JDAMOS+JDA-1
         IF (LCURDA.LE.LSTDAM(MOS)) GO TO 270
            KQMO=KQMO+1
            IF (KQMO.GT.12) KQMO=1
            LCURDA=LCURDA-LSTDAM(MOS)
270      IF (LCURDA.LT.16) GO TO 290
            TSDATA(JDA)=PEPARM(12+KQMO)+(LCURDA-16)*PEPARM(24+KQMO)
            KURDA=JDAMOS+NDAYOB-1
            AVE=PEPARM(12+KQMO)+(KURDA-16)*PEPARM(24+KQMO)
            IF (IBUG.GT.0) WRITE (IOPDBG,280) JDA,JDAMOS,KQMO,
     *         PEPARM(24+KQMO),KURDA,AVE,LCURDA
280   FORMAT (' IN VMAPE IN GT 16 PART OF THE FUTURE ESTIMATION:',
     *   ' JDA=',I2,' JDAMOS=',I2,' PEPARM(24+',I2,')=',F5.2,
     *   ' KURDA=',I2,' AVE=',F5.2,' LCURDA=',I2)
            GO TO 330
290      KURDA=JDAMOS+NDAYOB-1
         IF (LCURDA.GT.KURDA) GO TO 300
            KQMO=MOS
            IF (KURDA.GT.LSTDAM(MOS)) KURDA=KURDA-LSTDAM(MOS)
            GO TO 310
300      KQMO=MOS
310      KQMQ=KQMO-1
         IF (KQMO.EQ.1) KQMQ=12
         TSDATA(JDA)=PEPARM(12+KQMO)-(16-LCURDA)*PEPARM(24+KQMQ)
         AVE=PEPARM(12+KQMO)-(16-KURDA)*PEPARM(24+KQMQ)
         IF (IBUG.GT.0) WRITE (IOPDBG,320) JDA,JDAMOS,KQMQ,
     *      PEPARM(24+KQMQ),KURDA,AVE,LCURDA,TSDATA(JDA)
320   FORMAT (' IN VMAPE LT 16 PART OF THE FUTURE ESTIMATION:',
     *   ' JDA=',I4,' JDAMOS=',I4,' PEPARM(24+',I2,')=',F5.2,
     *   ' KURDA=',I3,' AVE=',F4.2 /
     *   ' LCURDA=',I4,' TSDATA(JDA)=',F4.2)
C     BLEND TO MEAN PE
330      IF (JDA.LT.1.OR.JDAGUD.LT.1) GO TO 350
            JQ=JDAGUD
            FX=(JDA-JQ)*BF
            IF (FX.GT.1.0) FX=1.0
            F=FX
            ESTSYM(JDA)=EST(2)
            IF (F.GT.(1.-BF)) ESTSYM(JDA)=EST(3)
            IF (IBUG.GT.0) WRITE (IOPDBG,340) JDA,TSDATA(JDA),JDAGUD,
     *         TSDATA(JDAGUD),ESTSYM(JDA)
340   FORMAT (' IN VMAPE : TSDATA(',I5,')=',F6.2,
     *   ' TSDATA(',I5,')=',F6.2,
     *   ' ESTSYM(JDA)=',A1)
            TSDATA(JDA)=TSDATA(JDA)+(TSDATA(JDAGUD)-AVE)*(1.-F)
            GO TO 360
350      ESTSYM(JDA)=EST(3)
360      IF (IBUG.GT.0) WRITE (IOPDBG,370) JDAGUD,FX,JDA,TSDATA(JDA)
370   FORMAT (' IN VMAPE BLEND: JDAGUD=',I5,' FX=',F8.2,
     *   ' JDA=',I5,' TSDATA=',F5.2)
380      CONTINUE
C
C  WRITE DATA TO PROCESSED DATA BASE
390   ISTEP=24
      JULHR=((JDAYO-1)*24)+NHOPDB
      IFPTR=JULHR+(NDAYOB)*24
      IF (NDAYS .LE. NDAYOB) IFPTR=0
      MAXDAY=IPRDMD(BTYPE)
      LWNEED=(((MAXDAY+21)/LRECLT)+1)*LRECLT
      IF (LWNEED.GT.LWKBUF) THEN
         WRITE (IPR,400) LWNEED,LWKBUF
400   FORMAT ('0**ERROR** SIZE OF WORK ARRAY NEEDED TO WRITE DATA TO ',
     *   'THE PROCESSED DATA BASE (',I4,
     *   ') IS GREATER THAN THE ARRAY SIZE (',I4,').')
         CALL ERROR
         GO TO 440
         ENDIF
      IF (IBUG.GT.0) WRITE (IOPDBG,410) BTYPE,JDAYO,JULHR,IFPTR
410   FORMAT (' IN VMAPE JUST BEFORE CALL TO WPRDD: BTYPE=',A4,
     *   ' JDAYO=',I6,' JULHR=',I7,' IFPTR=',I7)
      SID(1)=PEPARM(2)
      SID(2)=PEPARM(3)
      CALL WPRDD (SID,BTYPE,JULHR,ISTEP,NDAYS,IUNITS,NDAYS,
     *   LTSDATA,TSDATA,IFPTR,ICALL,LWKBUF,IWKBUF,IREC,ISTAT)
      IF (ISTAT.NE.0) THEN
         CALL WPRDDS (ISTAT,SID,BTYPE,JULHR,ISTEP,NDAYS,NDAYS,
     *      IUNITS,LWKBUF,LTSDATA)
         ENDIF
C
      IF (IBUG.GT.0) WRITE (IOPDBG,420) NDAYS
420   FORMAT (' IN VMAPE : NDAYS=',I5)
C
      IF (JMAPE.EQ.1) THEN
C     PRINT TIME SERIES DATA
         CALL VDSPL2 (PECOMP,NBSIDX,MXDDIM,PEPARM,MXPDIM,
     *      ESTSYM,LSTDY,LTSDATA,TSDATA)
         ENDIF
C
C  CHECK IF LAST AREA
      IF (IBUG.GT.0) WRITE (IOPDBG,430) MPTRNX
430   FORMAT (' IN VMAPE : MPTRNX=',I5)
      IF (MPTRNX.GT.0) GO TO 20
C
440   IF (IPTRCE.GT.0) WRITE (IOPDBG,*) 'EXIT VMAPE'
C
      CALL FSTWHR (OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      RETURN
C
      END
