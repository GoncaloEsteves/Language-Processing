%{
#include <stdio.h>
#include <string.h>
extern int yylex();
int yyerror(char *s);
int nalunos = 0;
%}

%union{
    char* svalue;
}

%token ERRO string DECL AALUNOS FALUNOS AALUNO FALUNO
%token AID FID ANOME FNOME ANOTAS FNOTAS ANOTA FNOTA
%token AUC FUC AVALOR FVALOR

%type <svalue> string

%%

Turma : 
    DECL AALUNOS  Alunos FALUNOS 
    ;
    
Alunos : 
    Alunos Aluno
    |  
    ;

Aluno : 
    AALUNO IdAluno Nome ANOTAS Notas FNOTAS FALUNO { nalunos++; printf("\n"); }
    ;

IdAluno : 
    AID string FID { printf("%s,",$2); }
    ;

Nome : 
    ANOME string FNOME  { printf("%s,",$2); }
    ;

Notas : 
    Notas Nota
    |
    ;

Nota : 
    ANOTA Uc Valor FNOTA 
    ;

Uc : 
    AUC string FUC { printf("%s,",$2); }
    ;

Valor : 
    AVALOR string FVALOR { printf("%s,",$2); }
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