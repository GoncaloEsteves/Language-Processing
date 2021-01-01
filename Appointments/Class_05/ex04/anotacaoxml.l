%{
#include <stdio.h>
#include <string.h>

int ini = 0;
int fim = 0;
int total = 0;
int coment = 0;
int vazio = 0;
%}
%x atributo
%x inicio
qname			[a-zA-Z][a-zA-Z0-9_\-.:]*
wspace 			[ \t]*
%%
			 									BEGIN 0;

[ \t\n\r]    									;

\<\?xml[^?]+\?\>								BEGIN inicio;

<inicio>\<!\-\-[^\-]*\-\-\>						coment++;

<inicio>\<\/[^>]+\> 							fim++;

<inicio>\<{qname}								BEGIN atributo;

<atributo>\>									{
												 ini++;
												 BEGIN inicio;
												}

<atributo>\/\>									{
												 vazio++;
												 BEGIN inicio;
												}

<atributo>{qname}{wspace}={wspace}\"[^"]+\"		total++;

<<EOF>>											{
												 printf("\nAbrem: %d, Fecham %d, Atributos %d, Comentarios %d, Vazio %d\n", ini, fim, total, coment, vazio);
												 return 0;
												}
