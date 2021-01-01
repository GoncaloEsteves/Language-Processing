#include <stdio.h>
extern int yylex();

int main(){
	int prox_simb;
	
	while((prox_simb = yylex())){
		printf("%d ", prox_simb);
	}
	putchar('\n');

	return 0;
}