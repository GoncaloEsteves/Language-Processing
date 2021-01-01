%{
#include <string.h>
extern int yylex();
int yyerror(char *s);
%}

%union{
	char* svalue;
}

%token ERRO string DECL AALUNOS FALUNOS AALUNO FALUNO
%token AID FID ANOME FNOME ANOTAS FNOTAS ANOTA FNOTA
%token AUC FUC AVALOR FVALOR

%type <svalue>

%%

Turma : DECL AALUNOS Alunos FALUNOS
      ;

Alunos : Alunos Aluno
       |
       ;

Aluno : AALUNO IdAluno Nome ANOTAS Notas FNOTAS FALUNO
      ;

IdAluno : AID string FID
        ;

Nome : ANOME string FNOME
     ;

Notas : Notas Nota
      ;

Nota : ANOTA Uc Valor FNOTA
     ;

Uc : AUC string FUC
   ;

Valor : AVALOR string FVALOR
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