SPEAKER EQU	P0.0		;控制蜂鳴器
TONEL	EQU 18H		;timer low 4bits
TONEH   EQU 19H		;timer high 4bits
TEMPO   EQU R2		;frequency of sound
TEMPO1  EQU R3		;keep the tempo
TIME    EQU R4			;repeat the wave
INDEX	EQU R5			;index

ORG 0000H
JMP MAIN
ORG 000BH				;timer0 interrupt vector
JMP TIMER0_INTERRUPT	
ORG 0050H

MAIN:					;setup interrupt parameter
    SETB ET0			;enable INT0 interrupt
    CLR TF0				;clear interrupt flag
    SETB PT0			;set priority of INT0
    MOV TMOD, #01H	;mode 1
    MOV DPTR, #SCALE	;data of TL, TH, tempo/2 of each sound

ROW1:
	MOV 		P1,#07FH
	CALL 		DELAY
	MOV 		A,P1
	ANL		A,#0FH
	MOV 		R1,#0
	CJNE		A,#0FH,COL1
ROW2:
	MOV 		P1,#0BFH
	CALL 		DELAY
	MOV 		A,P1
	ANL		A,#0FH
	MOV 		R1,#12
	CJNE		A,#0FH,COL1
ROW3:
	MOV 		P1,#0DFH
	CALL 		DELAY
	MOV 		A,P1
	ANL		A,#0FH
	MOV 		R1,#24
	CJNE		A,#0FH,COL1
ROW4:
	MOV 		P1,#0EFH
	CALL 		DELAY
	MOV 		A,P1
	ANL		A,#0FH
	MOV 		R1,#36
	CJNE		A,#0FH,COL1

	JMP		ROW1
COL1:
	CJNE		A,#0EH,COL2
	MOV		R0,#0
	JMP		SHOW
COL2:
	CJNE		A,#0DH,COL3
	MOV		R0,#3
	JMP		SHOW

COL3:
	CJNE		A,#0BH,COL4
	MOV		R0,#6
	JMP		SHOW

COL4:
	CJNE		A,#07H,ROW1
	MOV		R0,#9


SHOW:					;讓七段顯示的按下第幾個開關
	MOV A, R1
	ADD A, R0			;把R1的值和R0的值加起來放到A顯示
    MOV INDEX, A
	MOVC A, @A+DPTR	;取TABLE裡的第A+1筆資料
	MOV TONEH, A		;算好的TH0資料
    INC INDEX

    MOV A, INDEX
    MOVC A, @A+DPTR		;取下一筆資料，TL
    MOV TONEL, A		;算好的TH0資料
	INC INDEX

	MOV A, INDEX
	MOVC A, @A+DPTR		;取下一筆資料
	MOV TEMPO1, A		;算好的TEMPO資料
	MOV TEMPO, A		;算好的TEMPO資料

	MOV TL0, TONEL		;設定
    MOV TH0, TONEH		;設定
    MOV TIME, #2		;因為TEMPO的值是真正頻率的一半，所以重複兩次
	
	SETB EA				;enable all interrupt
    SETB SPEAKER
    SETB TR0			;開始計數
LOOP:
    CJNE TEMPO1, #0, LOOP	;counting loop
	DJNZ TIME, SET_TIME	;repeat TIME times
	CLR EA					;close all interrupt
    JMP ROW1				;go back to scan keyboard

SET_TIME:					;reset tempo
    MOV A, TEMPO
    MOV TEMPO1, A
    JMP LOOP

TIMER0_INTERRUPT:			;interrupt function
    CLR TF0					;clear interrupt flag
    CPL SPEAKER			;complement the SPEAKER
    DEC TEMPO1			;count down TEMPO1
    MOV TL0, TONEL		;reset TL0
    MOV TH0, TONEH		;reset TH0
    SETB TR0				;start timer
    RETI
    
DELAY:			        ;用來製造延遲
	MOV R6, #100
DELAY1:
	MOV R7, #150
DELAY2:
	DJNZ R7, DELAY2
	DJNZ R6, DELAY1
	RET

SCALE:
    DB 241, 23, 131
    DB 241, 242, 139
    DB 242, 182, 147
    DB 243, 122, 156
    DB 244, 41, 165
    DB 244, 214, 175
    DB 245, 113, 185
	DB 246, 8, 196
    DB 246, 156, 208
    DB 247, 31, 220
    DB 247, 158, 233
    DB 248, 23, 247
    DB 248, 48, 250
    DB 248, 71, 253
