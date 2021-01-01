%{
#include <stdio.h>
#include <string.h>

char* id;
%}
%s atributo inicio
qname			[a-zA-Z][a-zA-Z0-9_\-.:]*
wspace 			[ \t]*
%%
			 									BEGIN 0;

[ \t\n\r]    									;

\<\?xml[^?]+\?\>								{
												 printf("XML\n");
												 BEGIN inicio;
												}

<inicio>\<!\-\-[^\-]*\-\-\>						;

<inicio>[^<]+									printf("- %s\n", yytext);

<inicio>\<\/[^>]+\> 							{
												 yytext[yyleng-1] = '\0';
												 printf(")%s\n", yytext+2);
												}

<inicio>\<{qname}								{
												 id = strdup(yytext+1);
												 printf("(%s\n", id);
												 BEGIN atributo;
												}

<atributo>\>									{
												 BEGIN inicio;
												}

<atributo>\/\>									{
												 printf(")%s\n", id);
												 BEGIN inicio;
												}

<atributo>{qname}{wspace}={wspace}\"[^"]+\"		{
												 printf("A %s\n", yytext);
												}
