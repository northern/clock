DECLARE SUB drawClock ()
DECLARE SUB drawHour (t$, c%)
DECLARE SUB drawSecond (t$, c%)

CONST PI = 3.141592654#

CONST ORG.X = 640 / 2
CONST ORG.Y = 480 / 2

prevTime$ = TIME$

SCREEN 12
CLS

drawClock

ON TIMER(1) GOSUB displayTime

TIMER ON
DO
LOOP UNTIL INKEY$ = CHR$(27)
TIMER OFF
END

displayTime:
  LET currTime$ = TIME$

  drawHour prevTime$, 0
  drawSecond prevTime$, 0

  drawHour currTime$, 7
  drawSecond currTime$, 15

  prevTime$ = currTime$

  RETURN

SUB drawClock
  LET a = 200

  ' Draw seconds dots
  FOR i = 0 TO PI * 2 - (PI * 2 / 60) STEP (PI * 2 / 60)
    LET s = SIN(i)
    LET c = COS(i)
    LET x = ORG.X + (s * a)
    LET y = ORG.Y + (c * a)
 
    LET sd% = s * (180 / PI)
    LET cd% = c * (180 / PI)

    IF sd% <> 0 AND cd% <> 0 THEN
      PSET (x, y), 15
    END IF
  NEXT i

  ' Draw hourly dots
  FOR i = 0 TO PI * 2 - (PI * 2 / 12) STEP (PI * 2 / 12)
    LET s = SIN(i)
    LET c = COS(i)
    LET x = ORG.X + (s * a)
    LET y = ORG.Y + (c * a)

    LET r = 1.5
    LET k = 7

    LET sd% = s * (180 / PI)
    LET cd% = c * (180 / PI)

    IF sd% = 0 OR cd% = 0 THEN
      r = 3
      k = 15
    END IF

    CIRCLE (x, y), r, k
    PAINT (x, y), k
  NEXT i
END SUB

SUB drawHour (t$, c%)
  LET hh% = VAL(MID$(t$, 1, 2))

  LET a = 120
  LET f = PI * 2
  LET x = ORG.X + SIN(-(f / 12) * hh% + PI) * a
  LET y = ORG.Y + COS(-(f / 12) * hh% + PI) * a

  LINE (ORG.X, ORG.Y)-(x, y), c%
END SUB

SUB drawSecond (t$, c%)
  LET ss% = VAL(MID$(t$, 7, 2))

  LET a = 190
  LET f = PI * 2
  LET x = ORG.X + SIN(-(f / 60) * ss% + PI) * a
  LET y = ORG.Y + COS(-(f / 60) * ss% + PI) * a

  LINE (ORG.X, ORG.Y)-(x, y), c%
END SUB

