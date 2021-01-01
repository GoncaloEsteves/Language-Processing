%{
#include <stdio.h>
extern int yylex();
%}

%token ERRO
%%
Par : '(' Par ')' Par
	|
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
