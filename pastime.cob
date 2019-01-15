       IDENTIFICATION DIVISION.
       PROGRAM-ID. RNDSTR.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
           01 T1 PIC 9(9).
           01 RAND PIC V9(38).
           01 SRAND REDEFINES RAND PIC 9(38) .
           77 M PIC 9(9) VALUES 100000007.
           77 K PIC 9(10) VALUES 1.
           01 RANDL PIC 9(2).
           01 LIM PIC 9(2) VALUES 27.
           01 ARR PIC X(26) VALUES "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
           01 ARR1.
               02 ARRR OCCURS 100000000 TIMES DEPENDING ON SRAND.
                   05 CSB PIC X(1).
           77 I PIC 9(18).
       PROCEDURE DIVISION.
      *--  現時刻ベースに乱数を作成
           ACCEPT T1 FROM TIME
           MOVE FUNCTION REVERSE(T1) TO T1
           COMPUTE RAND = FUNCTION RANDOM(T1)*M
           COMPUTE SRAND = RAND*(10**38)
      *--  最大数値を設定
           ACCEPT K
           COMPUTE SRAND = FUNCTION MOD(SRAND, K) + 1
      *--  リスト化
           PERFORM SRAND TIMES
               COMPUTE I = I + 1
               COMPUTE RANDL = FUNCTION RANDOM()*26 + 1
               STRING ARR(RANDL:1) INTO CSB(I)
           END-PERFORM.
           DISPLAY ARR1
           STOP RUN.