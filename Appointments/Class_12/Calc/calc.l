%{
#include "y.tab.h"
%}

%%
[ \t\n\r] 			;

[+\-*/()=;]			return yytext[0];

(?i:halt)			return HALT;
(?i:read)			return READ;
(?i:print)			return PRINT;
(?i:show)			return SHOW;

[0-9]+				{ yylval.ivalue = atoi(yytext); return num; }
[a-z]				{ yylval.cvalue = yytext[0]; return id; }

.   				return ERRO;
