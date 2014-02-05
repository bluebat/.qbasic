REM typing.bas by Wei-Lun Chao (c) 2000/05/26

errors% = 40: REM 容許錯誤行數
inter% = 1000: REM 電腦等待時間
counts% = 5: REM 同時最多字數
bottom% = 22: REM 區域高度
letters% = 80: REM 區域寬度 

DO
  CLS
  RANDOMIZE TIMER
  DIM c$(1 TO letters%), y%(1 TO letters%)
  FOR i% = 1 TO letters%
    c$(i%) = "": REM 下落字元
    y%(i%) = 0: REM 字元高度
  NEXT i%
  erro% = 0: REM 已錯行數
  score% = 0: REM 已對次數
  count% = 0: REM 目前目標數

  DO
    REM 決定做那一行
    IF count% >= counts% THEN
      i% = INT(RND(1) * counts%) + 1
      j% = 0
      FOR k% = 1 TO letters%
        IF y%(k%) < bottom% AND y%(k%) > 0 THEN
          j% = j% + 1
          IF j% = i% THEN
            i% = k%
            EXIT FOR
          END IF
        END IF
      NEXT k%
    ELSE
      DO
        i% = INT(RND(1) * letters%) + 1
      LOOP WHILE y%(i%) = bottom%
    END IF

    REM 該行字元下降一列
    IF y%(i%) = 0 THEN
      DO
        key$ = CHR$(INT(RND(1) * 26) + 97)
        FOR k% = 1 TO letters%
          IF key$ = c$(k%) AND y%(k%) < bottom% AND y%(k%) > 0 THEN EXIT FOR
        NEXT k%
      LOOP UNTIL k% = letters% + 1
      c$(i%) = key$
      count% = count% + 1
    ELSE
      LOCATE y%(i%), i%
      PRINT " "
    END IF
    y%(i%) = y%(i%) + 1
    LOCATE y%(i%), i%
    PRINT c$(i%)
    IF y%(i%) = bottom% THEN
      erro% = erro% + 1
      count% = count% - 1
    END IF

    REM 等待輸入字元並比對
    FOR j% = 1 TO inter%
      key$ = INKEY$
      IF key$ <> "" THEN
        FOR k% = 1 TO letters%
          IF key$ = c$(k%) AND y%(k%) < bottom% AND y%(k%) > 0 THEN
            LOCATE y%(k%), k%
            PRINT " "
            y%(k%) = 0
            c$(k%) = " "
            score% = score% + 1
            count% = count% - 1
            EXIT FOR
          END IF
        NEXT k%
      END IF
    NEXT j%
    LOCATE 23, 1
    PRINT "您的分數 ="; score%
    LOCATE 23, 30
    PRINT "剩餘點數 ="; errors% - erro%
  LOOP UNTIL erro% = errors%

  REM 結果
  LOCATE 23, 60
  PRINT "要再玩一次嗎 (Y/N)?"
LOOP WHILE UCASE$(INPUT$(1)) = "Y"


