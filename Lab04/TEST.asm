	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN:
	MOV R2, #0
LOOP:
	MOV P2, #0FFH
	MOV A, R2
	INC A
	MOV DPTR, #NUMTABLE
	MOVC A, @A+DPTR
	MOV P1, A

	MOV A, R2
	MOV DPTR, #POS
	MOVC A, @A+DPTR
	MOV P2, A

	ACALL DELAY
	INC R2
	CJNE R2, #4, LOOP
	AJMP MAIN

DELAY:
	MOV R5, #0FFH
DELAY1:
	MOV R6, #01H
DELAY2:
	MOV R7, #01H
DELAY3:
	DJNZ R7, DELAY3
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
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

ORG 0000H
	AJMP MAIN
	ORG 0050H
;====================================================
MAIN:
	MOV R0, #70H			;個位數　初始為0
	MOV R1, #0B6H 			;十位數　初始為6
	MOV R2, #130			;每個數字重複顯示的次數　初始為130
;====================================================
Show:
	MOV P1, R1				;輸出十位數
	ACALL DELAY			;呼叫延遲副程式
	MOV P1, R0				;輸出個位數
	ACALL DELAY			;呼叫延遲副程式
	DJNZ R2, Show			;重複顯示十次
	MOV R2, #130			;重置次數
	DEC R0					;個位數 -1
	CJNE R0, #6FH, Show		;判斷個位數是否須要借位
	DEC R1					;十位數 -1
	MOV R0, #79H			;個位數借位　重置為9
	CJNE R1, #0AFH, Show	;判斷是否溢位
	AJMP MAIN
;====================================================
DELAY:
	MOV R5, #2DH
DELAY1:
	MOV R6, #0FFH
DELAY2:
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET						;延遲約0.0038475sec
;====================================================
END
