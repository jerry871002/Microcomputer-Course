    ORG 0000H
    JMP INITIAL
    ORG 000BH
    JMP TIMER0INTERUPT
    ORG 0013H
    JMP INT1INTERUPT
    ORG 0050H
INITIAL:
    MOV R4, #255
    MOV DPTR, #NUMTABLE
    SETB IT1				;Falling edge trigger for interrupt 1 (TCON.2)
    SETB PX1				;Set INT1 interrupt priority (IP.2)
    SETB EA					;Enable all interrupt (IE.7)
    SETB EX1				;Enable INT1 interrupt (IE.2)
    SETB ET0				;Enable Timer/Counter 0 interrupt (IE.1)
    CLR P3.7                ;用來產生半週期為29us的方波
    CLR TF0					;TIMER 0 OVERFLOW FLAG (TCON.5)
    CLR TF1					;COUNTER 1 OVERFLOW FLAG (TCON.7)
    MOV TMOD, #11100010B	;Counter 1, Mode 2, enable when INT1 = 1; Timer 0, Mode 2

    MOV TH0, #227           ;Timer 0計時29us
    MOV TL0, #227
    SETB TR0                ;Timer 0開始運作

    MOV TH1, #0				;Counter 1歸0
    MOV TL1, #0
    SETB TR1                ;Counter 1開始運作

SHOW:
    MOV P0, #0FBH           ;百位

    MOV A, R2
    MOVC A, @A+DPTR
    MOV P2, A
    MOV R5, #1
    CALL DELAY
    MOV P2, #0FFH

    MOV P0, #0FDH           ;十位

    MOV A, R1
    MOVC A, @A+DPTR
    MOV P2, A
    MOV R5, #1
    CALL DELAY
    MOV P2, #0FFH

    MOV P0, #0FEH           ;個位

    MOV A, R0
    MOVC A, @A+DPTR
    MOV P2, A
    MOV R5, #1
    CALL DELAY
    MOV P2, #0FFH

    DJNZ R4, SHOW

    SETB P3.4
    MOV R5, #1
    CALL DELAY
    CLR P3.4

    MOV R4, #255

    JMP SHOW

TIMER0INTERUPT:
    CPL P3.7
    CLR TF0
    RETI

INT1INTERUPT:
    MOV A, TL1
    MOV B, #100
    DIV AB
    MOV R2, A               ;百位數
    MOV A, B
    MOV B, #10
    DIV AB
    MOV R1, A               ;十位數
    MOV R0, B               ;個位數

    CLR TF1                 ;Counter歸零
    MOV TH1, #0
    MOV TL1, #0

    RETI

DELAY:
    MOV R6, #20
DELAY1:
    MOV R7, #30
DELAY2:
    DJNZ R7, DELAY2
    DJNZ R6, DELAY1
    DJNZ R5, DELAY
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
