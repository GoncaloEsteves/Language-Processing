%{
#include "y.tab.h"
%}

%%
[ \t\r]			;

\+				return yytext[0];

\-				return yytext[0];

\n 				return '\n';

[0-9]+			{
					yylval.vint = atoi(yytext);
					return inteiro;
				}

%%
