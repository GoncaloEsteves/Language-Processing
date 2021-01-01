%{
#include "y.tab.h"
%}

%%
[ \t\n\r] ;

!			 return NOT;
==			 return EQUAL;
\<			 return LT;
\<=			 return LE;
\>			 return GT;
\>=			 return GE;
[+\-*/()=;]  return yytext[0];

(?i:halt)   return HALT;
(?i:print)  return PRINT;
(?i:read)  	return READ;
(?i:show)  	return SHOW;
(?i:if)		return IF;
(?i:else)	return ELSE;

\/\/.+		{ yylval.svalue = strdup(yytext+2); return comentario; }
[0-9]+		{ yylval.ivalue = atoi(yytext); return num; }
[a-z]    	{ yylval.cvalue = yytext[0]; return id; }
\"[^"]*\"	{ 
				yytext[yyleng-1] ='\0';
				yylval.svalue = strdup(yytext+1); return string; }

.   return ERRO;
