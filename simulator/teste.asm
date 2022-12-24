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
;					  TEXTOS
; ************************************************ ;
msg_inicial : 	string 		"Ola Mundo!"
msg_timer:		string		"Timer funcionando!"
msg_timer_2:	string		"Timer2 funcionando!"
text:			var			#5
static			text + #0,	#'1'
static			text + #1,	#'2'
static			text + #2,	#'3'
static			text + #3,	#'4'
static			text + #4,	#'\0'

; ************************************************ ;
;	INTERRUPCAO DO TIMER 1
; ************************************************ ;
INT_TIMER:
	
		PUSH	R0
		PUSH	R1
		PUSH	R2
		
		LOADN	R0, #100
		LOADN	R1, #msg_timer
		LOADN	R2, #1792
		CALL	Imprimestr
		
		STOREN	32760, #INT_TIMER_2		; Endereço da interrupção do timer.
		STOREN	32748, #10				; Valor do timer. (segundos)
		
		POP		R2
		POP		R1
		POP		R0
		
		RTI
	
; ************************************************ ;
;	INTERRUPCAO DO TIMER 2
; ************************************************ ;
INT_TIMER_2:
	
		PUSH	R0
		PUSH	R1
		PUSH	R2
		
		LOADN	R0, #300
		LOADN	R1, #msg_timer_2
		LOADN	R2, #1792
		CALL	Imprimestr
		
		POP		R2
		POP		R1
		POP		R0
		
		RTI
		
; ************************************************ ;
;	INTERRUPCAO DO TECLADO
; ************************************************ ;
INT_KB:
		PUSH	R0
		PUSH	R1
		
		INCHAR	R0
		LOADN	R1, #300
		OUTCHAR	R0, R1
		
		POP		R1
		POP		R0
		
		RTI
		

; ************************************************ ;
;	PROGRAMA PRINCIPAL
; ************************************************ ;

MAIN:
		STOREN	30682, #192				; Habilita interrupções e a interrupção do timer. # 00000000 11000000
		STOREN	32760, #INT_TIMER			; Endereço da interrupção do timer.
		STOREN	32748, #10				; Valor do timer. (segundos)
		
		LOADN	R0, #50
		LOADN	R1, #msg_inicial
		LOADN	R2, #2304
		CALL	Imprimestr
		
LOOP:		JMP	LOOP	
		
		HALT

; *************FIM PROGRAMA PRINCIPAL************* ;


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
