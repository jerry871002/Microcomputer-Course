	ORG 00H
	AJMP MAIN
	ORG 50H
MAIN:
	MOV DPTR, #NUMTABLE
	;MOV R3, #0
ROW1:
	MOV P1, #7FH 		;掃描第一個row(s01~s04)
	CALL DELAY
	MOV A, P1
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R1, #0
	CJNE A, #0FH, COL1	;確認s01~s04是否有被按下
						;有則至掃描col的地方
ROW2:					;沒有則往下掃第二個row(s05~s08)
	MOV P1, #0BFH 		;掃描第二個row(s05~s08)
	CALL DELAY
	MOV A, P1
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R1, #4
	CJNE A, #0FH, COL1	;確認s05~s08是否有被按下
						;有則至掃描col的地方
ROW3:					;沒有則往下掃第三個row(s09~s12)
	MOV P1, #0DFH 		;掃描第三個row(s09~s12)
	CALL DELAY
	MOV A, P1
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R1, #8
	CJNE A, #0FH, COL1	;確認s09~s12是否有被按下
						;有則至掃描col的地方
ROW4:					;沒有則往下掃第四個row(s13~s16)
	MOV P1, #0EFH 		;掃描第四個row(s13~s16)
	CALL DELAY
	MOV A, P1
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R1, #12
	CJNE A, #0FH, COL1	;確認s13~s16是否有被按下
						;有則至掃描col的地方
	;JMP ROW1			;沒有則從頭掃描
COL1:
	CJNE A, #0EH, COL2	;0EH=00001110B
	MOV R0, #0
	JMP SHOW
COL2:
	CJNE A, #0DH, COL3	;0DH=00001101B
	MOV R0, #1
	JMP SHOW
COL3:
	CJNE A, #0BH, COL4	;0BH=00001011B
	MOV R0, #2
	JMP SHOW
COL4:
	CJNE A, #07H, NOCHANGE	;07H=00000111B
	MOV R0, #3
SHOW:
	MOV A, R1
	ADD A, R0
	MOV R3, A
NOCHANGE:
	MOV A, R3
	SETB C
	CJNE R3, #10, OVER1	;R3>10時，C被設為0	
OVER1:					;顯示0~9（一位數）
	JNC OVER2
	;MOV A, R3
	MOVC A, @A+DPTR
	MOV P2, #0DH
	MOV P3, A
	CALL DELAY
	;MOV P3, #0FFH		;避免殘影
	JMP ROW1
OVER2:					;顯示10~15（兩位數）
	;MOV A, R3
	ADD A, #6
	ANL A, #0FH 		;取出個位數
	MOVC A, @A+DPTR
	MOV P2, #0DH 		;個位
	MOV P3, A
	CALL DELAY
	MOV P3, #0FFH		;避免殘影
	MOV P2, #0BH 		;十位
	MOV P3, #0F9H		;顯示十位數1
	;CALL DELAY
	;MOV P3, #0FFH		;避免殘影
	JMP ROW1

DELAY:
	MOV R5, #100
DELAY1:
	MOV R6, #150
DELAY2:
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET

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

END