%{
int soma = 0;
%}
%x somar
%%
	BEGIN 0;

\+  			BEGIN somar;
<somar>[0-9]+	soma += atoi(yytext);
<somar>\+		BEGIN 0;
<*>=			printf("soma = %d\n", soma);
<*>.|\n			;
%%
int yywrap(){
	printf("O resultado da soma é: %d\n.", soma);
}
