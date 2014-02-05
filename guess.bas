REM guess.bas by Chao, Wei-Lun (c) 2000/05/26

DO
  CLS
  RANDOMIZE TIMER
  times% = 0: REM 已猜次數
  row% = 4: REM 游標列數
  col% = 1: REM 游標行數

  REM 準備數字
  DO
    LOCATE 1, 1
    INPUT "您要猜幾位的數字"; n$
    n% = VAL(n$)
  LOOP UNTIL n% > 0
  DIM answer%(n%), guess%(n%)
  FOR i% = 1 TO n%
    DO
      answer%(i%) = INT(RND(1) * 10)
      erro% = 0
      FOR j% = SGN(i% - 1) TO i% - 1
        IF answer%(i%) = answer%(j%) THEN erro% = 1
      NEXT j%
    LOOP UNTIL erro% = 0
  NEXT i%

  REM 循環猜至正確
  PRINT "輸入一個數("; n%; "個相異的阿拉伯數字)"
  PRINT
  DO
    REM 輸入合法數字
    DO
      erro% = 0
      LOCATE row%, col%
      INPUT g$
      IF LEN(g$) <> n% THEN
        erro% = 1
      ELSE
        FOR i% = 1 TO n%
          guess%(i%) = VAL(MID$(g$, i%, 1))
          FOR j% = SGN(i% - 1) TO i% - 1
            IF guess%(j%) = guess%(i%) THEN erro% = 1
          NEXT j%
        NEXT i%
      END IF
    LOOP UNTIL erro% = 0

    REM 計算結果並顯示
    a% = 0
    b% = 0
    times% = times% + 1
    FOR i% = 1 TO n%
      FOR j% = 1 TO n%
        IF answer%(i%) = guess%(j%) THEN
          IF i% = j% THEN a% = a% + 1 ELSE b% = b% + 1
        END IF
      NEXT j%
    NEXT i%
    LOCATE CSRLIN - 1, col% + 10
    PRINT a%; "A"; b%; "B"
    row% = ((row% - 2) MOD 20) + 4
    col% = INT(times% / 10) * 20 + 1
  LOOP UNTIL a% = n%

  REM 猜到結果
  LOCATE row%, col%
  PRINT times%; "次後猜到了!"
  PRINT
  LOCATE 23, 1
  PRINT "您要再玩一次嗎 (Y/N)?"
  ERASE answer%, guess%
LOOP WHILE UCASE$(INPUT$(1)) = "Y"

