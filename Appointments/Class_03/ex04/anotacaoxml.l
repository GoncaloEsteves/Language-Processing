%{
#include <stdio.h>
#include <string.h>

int ini = 0;
int fim = 0;
char* stack[100];
int p = 0;
%}

%%
\<\/[^>]+\>$ {
			  fim++;
			  if(p > 0){
			  	p--;
			  	char* aux = strdup(stack[p]);
			  	free(stack[p]);
			  	if(strcmp(aux, yytext+2) != 0)
			  		printf("INVALIDO");
			  }
			  else
			  	printf("INVALIDO");
			 };

^\<[^>]+\> {
			ini++;
			stack[p] = strdup(yytext+1);
			p++;
		   };

.* printf("%s", yytext);
