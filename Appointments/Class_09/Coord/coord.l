%{
#include "y.tab.h"
%}

%%
[ \n\t\r]										;

\( 												{ return yytext[0]; }
\) 												{ return yytext[0]; }
, 												{ return yytext[0]; }

(\+|\-)?([1-9]?[0-9]|1[0-9][0-9])(\.[0-9]+)?	{
													yylval.vreal = atof(yytext);
													return num;
												}

.												return ERRO;
