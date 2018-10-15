	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN:
	MOV R0, #5H
	MOV R1, #0H
LOOP1:
	ACALL SHOW

	CJNE R0, #0H, DEC1
	MOV R0, #9H
	AJMP LOOP2
DEC1:
	DEC R0
	AJMP LOOP1
LOOP2:
	CJNE R1, #0, DEC2
	MOV R1, #6H
	MOV R0, #0H
	AJMP LOOP1
DEC2:
	DEC R1	
	AJMP LOOP1

SHOW:
	MOV R4, #0H
	MOV R5, #0H
SHOWLOOP:
;First digjt
	MOV DPTR, #POS
	MOV A, #0H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL DELAY
	MOV P1, #0FFH
;Second digit
	MOV DPTR, #POS
	MOV A, #1H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL DELAY
	MOV P1, #0FFH

	INC R4
	CJNE R4, #0B0H, SHOWLOOP
	MOV R4, #0
	INC R5
	CJNE R5, #03H, SHOWLOOP

	RET
;===========================	
DELAY:
	MOV R6, #0FAH
DELAY1:
	MOV R7, #0AH
DELAY2:
	DJNZ R7, DELAY2
	DJNZ R6, DELAY1
	RET
;===========================
NUMTABLE:
	DB 0C0H ;0
	DB 0F9H ;1
	DB 0A4H ;2
	DB 0B0H ;3
	DB 099H ;4
	DB 092H ;5
	DB 082H ;6
	DB 0F8H ;7
	DB 080H ;8
	DB 090H ;9
;===========================
POS:
	DB 0F7H, 0FBH, 0FDH, 0FEH