#ifndef MNEUMONICOS_H
#define MNEUMONICOS_H

#define TAMANHO_PALAVRA 16

/*
[00000 - 16384] : Programa e variaveis (16kw 32kb)
[16385 - 24576] : Dados estaticos (8kw 16kb)
[24577 - 30680] : Dados dinamicos (6kw 12kb)
[30681]         : System call
[30682]         : Flags e chaves de Interrupções
[30683 - 30689] : Folga
[30690 - 32738] : Stack (2kw 4kb)
[32739 - 32745] : Folga
[32746]         : Rx
[32747]         : Tx
[32748]         : Timer           // Valor do timer
[32749 - 32758] : Argumentos
[32759]	        : Retorno
[32760 - 32767] : Interrupcoes    // [32760]: Timer
*/

#define TAMANHO_MEMORIA 32768

/* --- Endereços na Memoria --- */

#define END_SYSTEM_CALL 30681

/**
 * Endereço onde serão registradas as interrupões no sistema e se serão habilitadas ou não.
 * Os 8 bits menos significativos representam as chaves das interrupções, ou seja, o processador só ira aceitar
 * as interrupções habilitadas.
 * Os 8 bits mais significativos representam as flags de interrupção, ou seja,
 * quando ocorrer uma interrupção do tipo X, a flag X irá subir (ir para nível 1).
 * Bits:
 * 15: INT_TIMER (Interrupção do timer)
 * ...
 * 7: ENB_TIMER (Ativar timer)
 * ...
 */
#define END_INTERRUPTIONS   30682
#define INT_TIMER           15
#define ENB_TIMER           7

#define END_STACK_BEGIN     32738
#define END_TIMER           32748
#define END_INT_TIMER       32760

/* --- Flag Register --- */
#define F_INT_TIMER     15

#define LOAD 48
#define STORE 49
#define LOADIMED 56
#define LOADINDEX 60
#define STOREINDEX 61
#define MOV	51
#define OUTCHAR	50
#define INCHAR 53
#define ADD 32
#define SUB 33
#define MULT 34
#define DIV	35
#define INC	36
#define LMOD 37
#define LAND 18
#define LOR 19
#define LXOR 20
#define LNOT 21
#define SHIFT 16
#define CMP 22
#define JMP 2
#define CALL 3
#define RTS	4
#define PUSH 5
#define POP	6
#define NOP	0
#define HALT 15
#define SETC 8
#define BREAKP 14

#define TAM 5       // Numero de instrucoes de duas linhas


#define BLACK 15
#define BROWN 1
#define GREEN 2
#define OLIVE 3
#define NAVY 4
#define PURPLE 5
#define TEAL 6
#define SILVER 7
#define GRAY 8
#define RED 9
#define LIME 10
#define YELLOW 11
#define BLUE 12
#define FUCHSIA 13
#define AQUA 14
#define WHITE 0


#define N_LINHAS 35

#ifndef _linux_

#define MUITO_RAPIDA 1
#define RAPIDA 			 3
#define MEDIA 			 25
#define LENTA				 50
#define MUITO_LENTA  100

#else
#define MUITO_RAPIDA 1
#define RAPIDA 			 10000
#define MEDIA 			 25000
#define LENTA				 50000
#define MUITO_LENTA  100000

#endif

#endif

