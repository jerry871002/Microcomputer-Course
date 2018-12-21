	ORG 0000H
	JMP MAIN
	ORG 0050H
MAIN:
	MOV DPTR, #NUMTABLE
	
	MOV TMOD, #00100000B	;Timer 1, Mode 2
	MOV TL1, #0E6H			;Baud rate = 2400
	MOV TH1, #0E6H			;初始值 E6H = 230
	ORL PCON, #80H			;SMOD = 1
	SETB TR1				;Timer Run
	CLR SM2
	CLR SM0					;Serial port Mode 1
	SETB SM1				;設為8位元UART

	SETB REN				;Receive Enable control bit

LOOP:
	CLR RI
	JNB RI, $
	MOV A, SBUF
	SUBB A, #30H			;因為傳進去的值是ASCII，要減48
	MOVC A, @A+DPTR
	MOV R0, A

SHOW: 						;顯示到七段顯示器上
   	MOV P0, #11111110B
	MOV P1, R0
	CALL DELAY

	JMP LOOP

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

DELAY:
	MOV R6, #50
DELAY1:
	MOV R7, #50
DELAY2:
	DJNZ R7, DELAY2
	DJNZ R6, DELAY1
	RET

END
