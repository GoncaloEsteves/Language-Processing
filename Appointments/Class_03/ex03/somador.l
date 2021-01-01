%{
int soma = 0;
int semaforo = 0;
%}
%%
\+ if (semaforo) semaforo=0; else semaforo=1;
= printf("soma = %d\n", soma);
[0-9]+ if (semaforo) soma += atoi(yytext);
.|\n;
.;
%%
int yywrap(){
	printf("O resultado da soma é: %d\n.", soma);
}