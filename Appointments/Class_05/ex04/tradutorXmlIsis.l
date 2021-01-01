%{
#include <stdio.h>
#include <string.h>

int ini = 0;
int fim = 0;
int total = 0;
int coment = 0;
int vazio = 0;
char* id;
int aux = 0;
%}
%x atributo
%x inicio
qname			[a-zA-Z][a-zA-Z0-9_\-.:]*
wspace 			[ \t]*
%%
			 									BEGIN 0;

[ \t\n\r]    									;

\<\?xml[^?]+\?\>								{
												 printf("XML\n");
												 BEGIN inicio;
												}

<inicio>\<!\-\-[^\-]*\-\-\>						coment++;

<inicio>[^<]+									printf("- %s\n", yytext);

<inicio>\<\/[^>]+\> 							{
												 yytext[yyleng-1] = '\0';
												 fim++;
												 printf(")%s\n", yytext+2);
												}

<inicio>\<{qname}								{
												 id = strdup(yytext+1);
												 printf("(%s\n", id);
												 BEGIN atributo;
												}

<atributo>\>									{
												 ini++;
												 BEGIN inicio;
												}

<atributo>\/\>									{
												 printf(")%s\n", id);
												 vazio++;
												 BEGIN inicio;
												}

<atributo>{qname}{wspace}={wspace}\"[^"]+\"		{
												 printf("A %s\n", yytext);
												 total++;
												}

<<EOF>>											{
												 printf("\nAbrem: %d, Fecham %d, Atributos %d, Comentarios %d, Vazio %d\n", ini, fim, total, coment, vazio);
												 return 0;
												}
