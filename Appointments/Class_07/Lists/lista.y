%{
#include <stdio.h>
extern int yylex();
int yyerror();
%}

%token ERRO INT DOISPONTOS
%%
Listas : Lista Listas			//mais eficiente do que Listas Lista
	   |
	   ;

Lista : '[' ']'
	  | '[' Elems ']'
	  ;

Elems : Elem
	  | Elems ',' Elems 		//mais eficiente do que Elem ',' Elems
	  | Lista
	  ;

Elem  : INT
	  | Intervalo
	  ;

Intervalo : INT DOISPONTOS INT
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
