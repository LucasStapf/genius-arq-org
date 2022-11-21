; **************************************************** ;
; PROJETO DE ORGANIZACAO E ARQUITETURA DE COMPUTADORES ;
; -----------------------2022------------------------- ;
; Carlos Henrique Hannas de Carvalho 	NUSP:11965988  ;
; Henrique Carobolante Parro 			NUSP:11917987  ;
; Leonardo Hannas de Carvalho Santos 	NUSP:11800480  ;
; Lucas Carvalho Freiberger Stapf 		NUSP:11800559  ;
; **************************************************** ;


; ----------- TABELA DE CORES ----------- ;
; Modo de uso: Adicione ao caracter para  ;
; selecionar a cor correspondente.   	  ;
; --------------------------------------- ;
; 0 		BRANCO				0000 0000 ;
; 256 		MARROM				0001 0000 ;
; 512 		VERDE				0010 0000 ;
; 768 		OLIVA				0011 0000 ;
; 1024 		AZUL-MARINHO		0100 0000 ;
; 1280 		ROXO				0101 0000 ;
; 1536 		TEAL				0110 0000 ;
; 1792 		PRATA				0111 0000 ;
; 2048 		CINZA				1000 0000 ;
; 2304 		VERMELHO			1001 0000 ;
; 2560 		LIMA				1010 0000 ;
; 2816 		AMARELO				1011 0000 ;
; 3072 		AZUL				1100 0000 ;
; 3328 		ROSA				1101 0000 ;
; 3584 		AQUA				1110 0000 ;
; 3840 		PRETO				1111 0000 ;
; --------------------------------------- ;

	JMP MAIN



; ************************************************ ;
;				IMAGENS DOS OBJETOS
; ************************************************ ;
BIRD_2:		VAR #4
STATIC 			BIRD_2 + #0, #128
STATIC			BIRD_2 + #1, #129
STATIC			BIRD_2 + #2, #130
STATIC			BIRD_2 + #3, #131

CANO_BASE:	VAR #2
STATIC			CANO_BASE + #0, #132
STATIC			CANO_BASE + #1, #133	
STATIC			CANO_BASE + #2, #134

CANO_TUBO: VAR #2
STATIC			CANO_TUBO + #0, #135
STATIC			CANO_TUBO + #1, #136


; ************************************************ ;
;					  TEXTOS
; ************************************************ ;
mensagem2 : string "Ola Mundo!"



; ************************************************ ;
;				  PROGRAMA PRINCIPAL
; ************************************************ ;

MAIN:

	LOADN r0, #0			; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #mensagem2	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #256			; Seleciona a COR da Mensagem
	
	call Imprimestr   	; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
						; r1 = endereco onde comeca a mensagem
						; r2 = cor da mensagem.   
						; Obs: a mensagem sera' impressa ate' encontrar "/0"
						
	
	LOADN R0, #40
	LOADN R1, #BIRD_2
	LOADN R2, #256
	CALL PRINT_2x2
	
	LOADN R0, #60
	LOADN R1, #132
	LOADN R2, #512
	ADD	R1, R1, R2	
	OUTCHAR	R1, R0
	
	LOADN R0, #61
	LOADN R1, #133
	LOADN R2, #512
	ADD	R1, R1, R2	
	OUTCHAR	R1, R0
	
	
	LOADN R0, #62
	LOADN R1, #134
	LOADN R2, #512
	ADD	R1, R1, R2	
	OUTCHAR	R1, R0

	LOADN R0, #63
	LOADN R1, #135
	LOADN R2, #512
	ADD	R1, R1, R2	
	OUTCHAR	R1, R0

	LOADN R0, #64
	LOADN R1, #136
	LOADN R2, #512
	ADD	R1, R1, R2	
	OUTCHAR	R1, R0
	

	
	HALT

; *************FIM PROGRAMA PRINCIPAL************* ;

PRINT_2x2:

	PUSH 	R0				; Posição.
	PUSH	R1				; Primeiro bloco da imagem.
	PUSH	R2				; Cor do objeto.
	PUSH	R3				; Numero de blocos.
	PUSH 	R4				; Caracter.
	PUSH	R5				; 0
	PUSH 	R6				; 2
	PUSH 	R7				; Quebra de linha
	
	LOADN	R3, #4
	LOADN	R7, #38
	LOADN	R5, #0
	LOADN	R6, #2

LOOP_PRINT_2:

	CMP		R3, R5
	JEQ		END_PRINT_2		; Verifica se 4 blocos ja foram printados.
	LOADI	R4, R1
	ADD		R4, R4, R2
	OUTCHAR R4, R0

	INC		R1
	INC 	R0
	DEC		R3
	
	CMP		R3, R6
	JNE		LOOP_PRINT_2
	ADD		R0, R0, R7
	JMP		LOOP_PRINT_2

END_PRINT_2:

	POP 	R7
	POP		R6
	POP		R5
	POP		R4
	POP		R3
	POP		R2
	POP		R1
	POP		R0
	RTS
	
;---- Inicio das Subrotinas -----
	
Imprimestr:		;  Rotina de Impresao de Mensagens:    
				; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
				; r1 = endereco onde comeca a mensagem
				; r2 = cor da mensagem
				; Obs: a mensagem sera' impressa ate' encontrar "/0"
				
;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor				
	push r0	; Posicao da tela que o primeiro caractere da mensagem sera' impresso
	push r1	; endereco onde comeca a mensagem
	push r2	; cor da mensagem
	push r3	; Criterio de parada
	push r4	; Recebe o codigo do caractere da Mensagem
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
	cmp r4, r3			; compara o codigo do caractere buscado com o criterio de parada
	jeq ImprimestrSai	; goto Final da rotina
	add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
	outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
	inc r0				; incrementa a posicao que o proximo caractere sera' escrito na tela
	inc r1				; incrementa o ponteiro para a mensagem na memoria
	jmp ImprimestrLoop	; goto Loop
	
ImprimestrSai:	
;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts		; retorno da subrotina
