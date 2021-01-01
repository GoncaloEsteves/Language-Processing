%%
(\.|_)[0-9]+[a-zA-Z]{3,}(_|[a-zA-z])$ printf("%s: VÁLIDO\n", yytext);
.+$ printf("%s: INVÁLIDO\n", yytext);

\n;