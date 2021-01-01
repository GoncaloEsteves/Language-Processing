%{
#include "y.tab.h"
%}

%%
[ \t\n\r] 									;

read										return READ;
print										return PRINT;
show										return SHOW;

[()+-*/=]									return yytext[0];

.   										return ERRO;
