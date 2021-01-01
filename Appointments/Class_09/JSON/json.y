%{
#include <stdio.h>
extern int yylex();
int yyerror();
%}

%union{
	float fvalue;
	char* svalue;
}

%token ERRO string number TRUE FALSE NULLVALUE
%type <fvalue> number
%type <svalue> string
%%

Json : Value
	 ;

PairList : PairList ',' Pair
		 | Pair
		 ;

Obj : '{' '}'
	| '{' PairList '}'
	;

Pair : string ':' Value
	 ;

ValueList : ValueList ',' Value
		  | Value
		  ;

Array : '[' ']'
	  | '[' ValueList ']'
	  ;

Value : string
	  | number
	  | Obj
	  | Array
	  | TRUE
	  | FALSE
	  | NULLVALUE
	  ;

%%
int main(){
	yyparse();
	return 0;
}

int yyerror(){
	printf("Erro sintático...\n");
	return 0;
}