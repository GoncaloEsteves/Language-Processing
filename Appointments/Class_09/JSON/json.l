%{
#include "y.tab.h"
%}

%%
[ \n\t\r]										;

\,|:|\{|\}|\[|\]								{ 
													return yytext[0];
												}

true											{
													return TRUE;
												}

false											{
													return FALSE;
												}

null											{
													return NULLVALUE;
												}

\"[^"]*\"										{
													yytext[yylen-1] = '\0';
													yylval.svalue = strdup(yytext+1);
													return string;
												}

(\+|\-)?[0-9]+(\.[0-9]+)?						{
													yylval.fvalue = atof(yytext);
													return number;
												}

.												return ERRO;
