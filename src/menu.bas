100 DEFINT A-Z:KEY OFF:DEFUSR0=&H156:DEFUSR1=&H41:DEFUSR2=&H44:COLOR 15,0,0:SCREEN 8,,1
105 OP=USR1(0):SET PAGE 0,0:CLS:COPY "CWLOGO.CP8" TO (0,0),1:COPY(128,0)-STEP(127,15),1 TO (64,176):BLOAD "INTERFA1.SC8",S,49152!
110 SET PAGE 1,1:CLS:BLOAD "OPENING.SC8",S:BLOAD "THUMBS.SC8",S,24576:BLOAD "INTERFA2.SC8",S,49152!
115 SET PAGE 0,0:VDP(10)=VDP(10)AND127
120 _TURBOON(OP)
125 '#C-
130 COPY(0,200)-STEP(255,47) TO (0,0)
135 COPY(0,0)-STEP(255,95),1 TO (0,48)
140 GOSUB 190
145 FOR I=0 TO 2:COPY(32*I,248)-STEP(31,7),0 TO (64+48*I,156):NEXT I
150 OP=0*USR2(0)*USR0(0)
155 GOSUB 185:GOSUB 305:GOSUB 185
160 OP=OP-(K$=CHR$(28))+(K$=CHR$(29))
165 IF OP<0 THEN OP=2 ELSE IF OP>2 THEN OP=0
170 IF K$<>CHR$(13) THEN 155
175 ON (OP+1) GOSUB 195,235,245
180 GOTO 135
185 LINE(56+48*OP,154)-STEP(47,11),255,BF,XOR:RETURN
190 LINE(0,152)-STEP(255,15),0,BF:RETURN
195 GOSUB 190:I=0:J=0
200 COPY(0,96)-STEP(255,95),1 TO (0,48)
205 OP=4*J+I
210 GOSUB 230:COPY(0,192+OP*8)-STEP(255,7),1 TO (0,156):GOSUB 305:GOSUB 230
215 J=(J-(K$=CHR$(31))+(K$=CHR$(30))) AND 1:I=(I-(K$=CHR$(28))+(K$=CHR$(29))) AND 3
220 IF K$=CHR$(13) THEN 310
225 IF K$=CHR$(27) THEN RETURN ELSE 205
230 LINE (64*I,48*J+48)-STEP(63,47),255,B,XOR:RETURN
235 COPY(0,192)-STEP(255,7) TO (0,0):GOSUB 305:LINE(0,0)-STEP(255,7),0,BF:RETURN
240 LINE(0,0)-STEP(255,7),0,BF
245 OP=1:LINE(0,48)-STEP(255,95),&H1C,BF,AND
250 COPY(128,248)-STEP(79,7) TO (88,88),,OR
255 COPY(208,248)-STEP(47,7) TO (104,96),,OR
260 I=USR0(0):GOSUB 300
265 GOSUB 305
270 GOSUB 300
275 OP=(OP-(K$=CHR$(28))+(K$=CHR$(29))) AND 1
280 IF K$=CHR$(27) THEN RETURN
285 IF K$<>CHR$(13) THEN 260
290 IF OP=1 THEN RETURN
295 I=USR0(0):OP=255:END
300 LINE(104+OP*24,96)-STEP(23,7),255,BF,XOR:RETURN
305 K$=INKEY$:IF K$="" THEN 305 ELSE RETURN
310 LINE(0,192)-STEP(255,19),255,BF
315 COPY(0,192+OP*8)-STEP(255,7),1 TO (0,198),0,XOR
320 COPY(0,192)-STEP(255,19),0 TO (0,192),1
325 _TURBO OFF
330 IF OP<>255 THEN I=USR1(0):SET PAGE ,1:BLOAD "PICTURE"+CHR$(48+OP)+".SC8",S:RUN "GAME.BAS"
