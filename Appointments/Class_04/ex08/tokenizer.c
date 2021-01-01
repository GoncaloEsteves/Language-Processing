#include "tokens.h"
#include <stdio.h>

extern int yylex();

int main(){
	int prox_simb;
	while((prox_simb = yylex())){
		switch(prox_simb){
			case AP:
				printf("AP ");
				break;
			case INT:
				printf("INT ");
				break;
			case OP:
				printf("OP ");
				break;
			case FP:
				printf("FP ");
				break;
			case ERRO:
				printf("ERRO ");
				break;
			default:
				break;
		}
	}
}