%{
#include <string.h>
#include <stdlib.h>
%}
%%
([0-9]{1,3}\.){3}[0-9]{1,3}$ {char* token;
							 char s[2] = ".";
							 token = strtok(yytext, s);
							 int aux, i = 0;

							 while(token != NULL){
							 	aux = atoi(token);
							 	if(aux >= 0 && aux <=255)
							 		i++;
							 	token = strtok(NULL, s);
							 }

							 if(i == 4)
							 	printf("VÁLIDO\n");
							 else
							 	printf("INVÁLIDO\n");
							};
.+$ printf("%s: INVÁLIDO\n", yytext);

\n;
%%