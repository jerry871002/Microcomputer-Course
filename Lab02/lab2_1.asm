	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN :
	MOV A, P2
	CPL A
	MOV P1, A
	JMP MAIN