/* -------------------------------------------------------

p1: Lst    --> '[' Els ']'           LA(p1) = {'['}

p2: Els    -->  Elem  Outros         LA(p2) = {num, '['}

p3: Outros -->                       LA(p3) = Follow(Outros) = Follow(Els) = {']'}

p4: 	     |  ,'  Elem Outros      LA(p4) = {','}

p5: Elem   --> num Range             LA(p5) = {num} 

p6:          |   Lst                 LA(p6) = {'['}

p7: Range  -->  '.''.' num           LA(p7) = {'.'}

p8:          |                       LA(p8) = Follow(Range) = Follow(Elem) = {',', '],}

--------------------------------------------------------- */

#include <stdio.h>
#include "tokens.h"
extern int yylex();
int prox_simb;

int rec_Lst();
int rec_Els();
int rec_Outros();
int rec_Elem();
int rec_Range();

int da_simb(){
    return yylex();
}

int rec_term(int simb){
    if(simb == prox_simb){
        prox_simb = da_simb();
        return 0;
    }
    else{
        printf("Erro: terminal inesperado - %d\n", simb);
        return 1;
    }
}

int main(){
    prox_simb = da_simb();
    rec_Lst();

    return 0;
}

// p1: Lst    --> '[' Els ']'           LA(p1) = {'['}
int rec_Lst(){
    switch(prox_simb){
        case ALISTA: rec_term(ALISTA);
                     rec_Els();
                     rec_term(FLISTA);
                     break;
        default: printf("Erro: Lst - %d\n", prox_simb);
    }
}

// p2: Els    -->  Elem  Outros         LA(p2) = {num, '['}
int rec_Els(){
    switch(prox_simb){
        case NUM: 
        case ALISTA: rec_Elem();
                     rec_Outros();
                     break;
        default: printf("Erro: Els - %d\n", prox_simb);
    }
}

/* p3: Outros -->                       LA(p3) = Follow(Outros) = Follow(Els) = {']'}

   p4:          |  ,'  Elem Outros      LA(p4) = {','} */
int rec_Outros(){
    switch(prox_simb){
        case FLISTA: break;
        case VIRG: rec_term(VIRG);
                   rec_Elem();
                   rec_Outros();
                   break;
        default: printf("Erro: Outros - %d\n", prox_simb);
    }
}

/* p5: Elem   --> num Range             LA(p5) = {num} 

   p6:          |   Lst                 LA(p6) = {'['} */
int rec_Elem(){
    switch(prox_simb){
        case ALISTA: rec_Lst();
                     break;
        case NUM: rec_term(NUM);
                  rec_Range();
                  break;
        default: printf("Erro: Elem - %d\n", prox_simb);
    }
}

/* p7: Range  -->  '.''.' num           LA(p7) = {'.'}

   p8:          |                       LA(p8) = Follow(Range) = Follow(Elem) = {',', '],} */
int rec_Range(){
    switch(prox_simb){
        case VIRG: 
        case FLISTA: break;
        case PONTO: rec_term(PONTO);
                    rec_term(PONTO);
                    rec_term(NUM);
                    break;
        default: printf("Erro: Range - %d\n", prox_simb);
    }
}