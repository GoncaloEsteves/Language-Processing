%{
#include<stdio.h>
extern int yylex();
int yyerror();
%}

%union{
	int vint;
	char op;
}

%token ERRO inteiro
%type <vint> inteiro Termo Exp
%type <op> Op

%%
SeqExp : SeqExp '\n' Exp 	{ printf("Resultado = %d\n", $3); }
	   | Exp 				{ printf("Resultado = %d\n", $1); }
	   ;

Exp : Exp Op Termo	{
						switch($2){
							case '+':
								$$ = $1 + $3;
								break;
							case '-':
								$$ = $1 - $3;
								break;
							default:
								break;
						}
					}
	| Termo			{ $$ = $1; }
	;

Termo : inteiro		{ $$ = $1; }
	  ;

Op : '+'			{ $$ = '+'; }
   | '-'			{ $$ = '-'; }
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