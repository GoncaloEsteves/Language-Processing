%{
#include <stdio.h>
extern int yylex();
int yyerror();
%}
%union{
	int vint;
}

%token ERRO inteiro
%type <vint> inteiro ABin


%%
SeqABin : ABin 			{ printf("soma = %d\n", $1); }
		| SeqABin ABin  { printf("soma = %d\n", $2); }
		;//Recursividade à esquerda é mais eficiente!!

ABin : '(' ')' 						{ $$ = 0; }
	 | '(' inteiro ABin ABin ')'	{ $$ = $2 + $3 + $4; }
	 ;

%%
int main(){
	yyparse();
	return 0;
}

int yyerror(){
	printf("Erro sintatico...\n");
	return 0;
}
