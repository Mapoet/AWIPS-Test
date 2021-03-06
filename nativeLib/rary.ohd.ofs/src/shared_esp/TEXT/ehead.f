C MEMBER EHEAD
C  (FROM OLD MEMBER EEDEX02)
C
C                             LAST UPDATE: 06/07/95.09:10:24 BY $WC30EW
C
      SUBROUTINE EHEAD(NVAR,HEAD,VARNAM,IWIND,TDSP,UNITS,KODE,VALUE,IPL)
C
      DIMENSION ITTS(12),TDSP(1),HEAD(5),VARNAM(2)
      INCLUDE 'common/etime'
      INCLUDE 'common/fctime'
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/where'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/shared_esp/RCS/ehead.f,v $
     . $',                                                             '
     .$Id: ehead.f,v 1.1 1995/09/17 19:18:45 dws Exp $
     . $' /
C    ===================================================================
C
C
C
      IF (IPL.EQ.1) GO TO 10
       WRITE(IPR,610)
 10   IF (ITRACE.GE.1) WRITE(IODBUG,170)
 170  FORMAT(1H0,13HEHEAD ENTERED)
C
      NUM=TDSP(1)
      IF (NUM.LE.2) GO TO 17
      LNUM=8*(NUM-1)+2
      GO TO 19
 17   LNUM=10
 19   CONTINUE
      CALL MDYH1(IWJD(IWIND),IWH(IWIND),IMN1,IDA1,IYR1,IH1,
     X  NOUTZ,NOUTDS,TZC)
      CALL MDYH1(LWJD(IWIND),LWH(IWIND),IMN2,IDA2,IYR2,IH2,
     X  NOUTZ,NOUTDS,TZC)
      WRITE(IPR,800) (HEAD(I),I=1,5)
C
      WRITE(IPR,880) ISEG(1),ISEG(2)
      WRITE(IPR,820) IMN1,IDA1,IYR1,IH1,TZC,IMN2,IDA2,IYR2,IH2,TZC
      IF (NVAR.GE.2) GO TO 21
      WRITE(IPR,901)
      GO TO 100
 21   IF (NVAR.GE.3) GO TO 23
      WRITE(IPR,903)
      GO TO 100
 23   IF (NVAR.GE.4) GO TO 25
      WRITE(IPR,905)
      GO TO 100
 25   IF (NVAR.GE.5) GO TO 27
      WRITE(IPR,907)
      GO TO 100
 27   IF (NVAR.GE.6) GO TO 29
      WRITE(IPR,909)
      GO TO 100
 29   IF (NVAR.GE.7) GO TO 31
      WRITE(IPR,911)
      GO TO 100
 31   IF (NVAR.GE.8) GO TO 35
      IF (KODE.EQ.2) GO TO 33
      WRITE(IPR,913) VALUE,UNITS
      GO TO 100
 33   WRITE(IPR,915) VALUE,UNITS
      GO TO 100
 35   IF (KODE.EQ.2) GO TO 37
      WRITE(IPR,917) VALUE,UNITS
      GO TO 100
 37   WRITE(IPR,919) VALUE,UNITS
 100  CONTINUE
C
C
C
      WRITE(IPR,810) VARNAM(1),VARNAM(2)
C
C
C
C
C
C
      IF (IPL.NE.1) GO TO 40
      RETURN
 40   NUM=TDSP(1)
      DO 50 I=1,NUM
      II=6+(I-1)*8
      ITTS(I)=TDSP(II)
 50   CONTINUE
C
      IF (ITTS(1).GE.4) GO TO 105
      IF (NUM.EQ.1) GO TO 70
      DO 60 I=2,NUM
      IF (ITTS(I).GE.4) GO TO 80
      IF (ITTS(I).LE.ITTS(I-1)) GO TO 90
 60   CONTINUE
C
 70   IDSPL=2
      GO TO 300
 80   IDSPL=1
      GO TO 200
 90   IDSPL=3
      GO TO 200
C
 105  IF (NUM.EQ.1) GO TO 120
      DO 110 I=2,NUM
      IF (ITTS(I).LE.3) GO TO 140
      IF (ITTS(I).LE.ITTS(I-1)) GO TO 130
 110  CONTINUE
C
 120  IDSPL=4
      GO TO 300
 130  IDSPL=5
      GO TO 200
 140  IDSPL=6
C
 200  WRITE(IPR,921)
      GO TO (205,210,215,210,220,225),IDSPL
 205  WRITE(IPR,805)
      GO TO 250
 210  WRITE(IPR,600)
      GO TO 250
 215  WRITE(IPR,815)
      GO TO 250
 220  WRITE(IPR,822)
      GO TO 250
 225  WRITE(IPR,825)
C
 250  WRITE(IPR,925) TDSP(2),TDSP(3),TDSP(LNUM),TDSP(LNUM+1)
      WRITE(IPR,927) TDSP(4),TDSP(8),TDSP(9),TDSP(LNUM+2),
     X  TDSP(LNUM+6),TDSP(LNUM+7)
      IHR1=TDSP(5)
      IHR2=TDSP(LNUM+3)
      WRITE(IPR,929) IHR1,IHR2
C
      GO TO 700
C
 300  WRITE(IPR,931)
      IF (IDSPL.EQ.4) GO TO 310
      WRITE(IPR,830)
      GO TO 320
 310  WRITE(IPR,835)
 320  WRITE(IPR,935) TDSP(2),TDSP(3)
      WRITE(IPR,937) TDSP(4),TDSP(8),TDSP(9)
      IHR=TDSP(5)
      WRITE(IPR,939) IHR
C
 700  CONTINUE
C
C
 610  FORMAT(1H1)
 600  FORMAT(1H0)
 805  FORMAT(18X,9HSIMULATED,22X,8HOBSERVED / 15X,13(1H-),19X,13(1H-))
 815  FORMAT(18X,9HSIMULATED,22X,9HSIMULATED / 15X,13(1H-),19X,13(1H-))
 822  FORMAT(18X,8HOBSERVED,23X,8HOBSERVED / 15X,13(1H-),19X,13(1H-))
 825  FORMAT(18X,8HOBSERVED,23X,9HSIMULATED / 15X,13(1H-),19X,13(1H-))
 830  FORMAT(11X,9HSIMULATED / 10X,13(1H-))
 835  FORMAT(11X,8HOBSERVED / 10X,13(1H-))
 800  FORMAT(20X,5A4/)
 810  FORMAT(1H+,63X,10HOUTPUT ID ,7X,2H: ,2A4)
 820  FORMAT(1H+,63X,17HFORECAST PERIOD: ,I2,1H/,I2,1H/,I4,3H HR,I3,
     X  1X,A4,4H TO ,I2,1H/,I2,1H/,I4,3H HR,I3,1X,A4)
 880  FORMAT(10X,7HSEGMENT,10X,2H: ,2A4)
 901  FORMAT(10X,43HOUTPUT VARIABLE  : MAXIMUM MEAN DAILY VALUE)
 903  FORMAT(10X,43HOUTPUT VARIABLE  : MINIMUM MEAN DAILY VALUE)
 905  FORMAT(10X,35HOUTPUT VARIABLE  : MEAN DAILY VALUE)
 907  FORMAT(10X,36HOUTPUT VARIABLE  : ACCUMULATED VALUE)
 909  FORMAT(10X,42HOUTPUT VARIABLE  : MAX INSTANTANEOUS VALUE)
 911  FORMAT(10X,42HOUTPUT VARIABLE  : MIN INSTANTANEOUS VALUE)
 913  FORMAT(10X,35HOUTPUT VARIABLE  : DAYS UNTIL ABOVE,
     X  F11.1,1X,A4)
 915  FORMAT(10X,35HOUTPUT VARIABLE  : DAYS UNTIL BELOW,
     X  F11.1,1X,A4)
 917  FORMAT(10X,29HOUTPUT VARIABLE  : DAYS ABOVE,
     X  F11.1,1X,A4)
 919  FORMAT(10X,29HOUTPUT VARIABLE  : DAYS BELOW,
     X  F11.1,1X,A4)
C
C
 921  FORMAT(1H0,14X,13HTIME SERIES 1,19X,13HTIME SERIES 2)
 925  FORMAT(18X,10HI.D.     :,1X,A4,A4,12X,10HI.D.     :,1X,A4,A4)
 927  FORMAT(18X,10HDATA TYPE:,1X,A4,2X,2A4,6X,10HDATA TYPE:,1X,A4,
     X  2X,2A4)
 929  FORMAT(18X,10HDELTA T  :,I3,4H HRS,14X,10HDELTA T  :,
     X  I3,4H HRS)
C
 931  FORMAT(1H0,9X,13HTIME SERIES 1)
 935  FORMAT(11X,10HI.D.     :,1X,A4,A4)
 937  FORMAT(11X,10HDATA TYPE:,1X,A4,2X,2A4)
 939  FORMAT(11X,10HDELTA T  :,I2,4H HRS)
 943  FORMAT(18X,9HSIMULATED,22X,9HSIMULATED)
C
      RETURN
      END
