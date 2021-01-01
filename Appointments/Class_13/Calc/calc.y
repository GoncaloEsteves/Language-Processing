%{
#include <stdio.h>
#include <string.h>
extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();
int erroSem(char*);
%}

%union{
    int ivalue;
    char cvalue;
}
%token ERRO HALT PRINT READ SHOW num id
%type <ivalue> num Fator Termo Exp
%type <cvalue> id
%%

Calc
    : { printf("\tpushn 26\nstart\n"); } ListaComandos { printf("stop\n"); }
    ;

ListaComandos
    : ListaComandos Comando
    | Comando
    ;  

Comando
    : Print 
	| Read 
	| Show 
	| Halt 
    | Atrib
	;

Print
    : PRINT Exp ';' 	{ printf("\twritei\n"); }
    ;

Read
    : READ id ';'		{ printf("\tpushs \"Introduza um valor: \"\n\twrites\n\tread\n");
                          printf("\tstoreg %d\n", $2-'a');
    					}
    ;

Show 
    : SHOW ';' 			{ for(int i = 0; i < 26; i++) 
            				printf("\tpushg %d\n\twritei\n", i);
    					}
    ;

Halt
    : HALT ';' 			{ printf("stop\n");}
    ;

Atrib 
    : id '=' Exp ';'	{ printf("\tstoreg %d\n", $1-'a'); }
    ;

Exp
    : Exp '+' Termo 	{ printf("\tadd\n"); }
    | Exp '-' Termo 	{ printf("\tsub\n"); }
    | Termo
    ;

Termo 
    : Termo '/' Fator 	{ if($3 == 0) erroSem("DIVISÃO POR 0");
                          else printf("\tdiv\n"); }
    | Termo '*' Fator 	{ printf("\tmul\n"); }
    | Fator
    ;

Fator 
    : id 				{ printf("\tpushg %d\n", $1-'a'); }
    | num 				{ printf("\tpushi %d\n", $1); }
    | '(' Exp ')'
    ;

%%
int main(){
    yyparse();
    return 0;
}

int erroSem(char *s){
    printf("Erro Semântico na linha: %d, %s...\n", yylineno, s);
    return 0;
}

int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: %s\n", yylineno, yytext);
    return 0;
}