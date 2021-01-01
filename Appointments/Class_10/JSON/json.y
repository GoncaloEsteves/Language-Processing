%{
#include <stdio.h>
#include <string.h>
extern int yylex();
int yyerror(char *s);
%}

%union{
	float fvalue;
	char* svalue;
}

%token ERRO string number TRUE FALSE NULLVALUE
%type <fvalue> number
%type <svalue> string Obj PairList Pair Array ValueList Value

%%
Json : Value                      { printf("%s\n", $1); }
	 ;

Obj : '{' '}'                     { asprintf(&$$, "<objeto/>"); }
	| '{' PairList '}'            { asprintf(&$$, "<objeto>\n%s\n</objeto>", $2); }
	;

PairList : PairList ',' Pair      { asprintf(&$$, "%s\n%s", $1, $3); }
		 | Pair                   { $$ = strdup($1); }
		 ;

Pair : string ':' Value           { asprintf(&$$, "<%s>%s</%s>", $1, $3, $1); }
	 ;

Array : '[' ']'                   { asprintf(&$$, "<lista/>"); }
	  | '[' ValueList ']'         { asprintf(&$$, "<lista>\n%s\n</lista>", $2); }
	  ;

ValueList : ValueList ',' Value   { asprintf(&$$, "%s\n%s", $1, $3); }
		  | Value                 { asprintf(&$$, "<item>\n%s\n</item>", $1); }
		  ;

Value : string                    { $$ = strdup($1); }
	  | number                    { asprintf(&$$, "%f", $1); }
	  | Obj                       { asprintf(&$$, "%s", $1); }
	  | Array                     { asprintf(&$$, "%s", $1); }
	  | TRUE                      { asprintf(&$$, "true"); }
	  | FALSE                     { asprintf(&$$, "false"); }
	  | NULLVALUE                 { asprintf(&$$, "null"); }
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