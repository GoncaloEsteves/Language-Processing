%{
#include <stdio.h>
#include <string.h>
extern int yylex();
int yyerror(char *s);
%}

%union{
	int nvalue;
}

%token READ PRINT SHOW num id

%type <nvalue> num

%%

Calc
	: ListaComandos
    ;

ListaComandos
	: ListaComandos Comando
	| Comando
	;

Comando
	: Read
	| Print
	| Show
	| Atrib
	;

Read
	: READ id
	;

Print
	: PRINT Exp
	;

Show
	: SHOW
	;

Atrib
	: id '=' Exp
	;

Exp
	: Valor '+' Valor
	| Valor '-' Valor
	| Valor '*' Valor
	| Valor '/' Valor
	;

Valor
	: num
	| id
	| '(' Exp ')'
	;

%%
int main(){
    yyparse();
    return 0;
}

int yyerror(char *s){
    printf("Erro sintático: %s\n", s);
    return 0;
}