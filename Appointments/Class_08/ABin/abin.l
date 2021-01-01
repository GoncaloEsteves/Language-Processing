%{
#include "y.tab.h"
%}

%%
[ \n\t\r]	;

\( 					{ return yytext[0]; }

\) 					{ return yytext[0]; }

(\+|\-)?[0-9]+ 		{
						yylval.vint = atoi(yytext);
						return inteiro;
					}

.					return ERRO;

%%
