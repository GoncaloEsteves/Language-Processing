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
    char *svalue;
}
%token ERRO HALT PRINT READ SHOW IF ELSE 
%token NOT EQUAL LT LE GT GE
%token <ivalue> num 
%token <cvalue> id
%token <svalue> comentario string
%type <ivalue> Fator Termo Exp
%%

Calc
    : {printf("\tpushn 26\nstart\n");} ListaComandos {printf("stop\n");}
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
    | Comment
    | IfElse
    ;

IfElse
    : IF '(' Cond ')' Comando
    | IF '(' Cond ')' Comando ELSE {printf("else:\n");} Comando {printf("fimIf:\n");}
    ;


Comment
    : comentario { printf("//%s\n", $1); }
    ;

Print
    : PRINT Exp ';' { printf("\tpushs \" \"\n\twrites\n\twritei\n"); }
    | PRINT string ';' { printf("\tpushs \"%s\"\n\twrites\n", $2); }
    ;

Read
    : READ id ';' {
        printf("\tread\n");
        printf("\tstoreg %d\n", $2-'a');
    }
    ;

Show 
    : SHOW ';' {
        for(int i = 0;i<26;i++) 
            printf("\tpushg %d\n\twritei\n", i);
    }
    ;

Halt
    : HALT ';' { printf("stop\n"); }
    ;

Atrib 
    : id '=' Exp ';' {
        printf("\tstoreg %d\n", $1-'a');
    }
    ;

Cond
    : RelExp { printf("\tjz else\n"); }
    ;

RelExp
    : Exp
    | RelExp EQUAL RelExp
    | NOT RelExp
    | RelExp LT RelExp
    | RelExp LE RelExp
    | RelExp GT RelExp { printf("\tsup\n"); }
    | RelExp GE RelExp
    ;

Exp
    : Exp '+' Termo { printf("\tadd\n"); }
    | Exp '-' Termo { printf("\tsub\n"); }
    | Termo 
    ;

Termo 
    : Termo '/' Fator { if($3==0) erroSem("DIVISÃO POR 0");
                        else printf("\tdiv\n"); }
    | Termo '*' Fator { printf("\tmul\n"); }
    | Fator 
    ;

Fator 
    : id { printf("\tpushg %d\n", $1-'a'); }
    | num { printf("\tpushi %d\n", $1); }
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
