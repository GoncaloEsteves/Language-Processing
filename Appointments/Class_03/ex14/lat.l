sinal (\+|\-)
iss [1-9][0-9]*
dec (\.[0-9]+)

%%
\({sinal}?({iss}|0){dec}?, {sinal}?({iss}|0){dec}?\)$ printf("VÁLIDO: %s\n", yytext);

\((\+|\-)?(([1-9][0-9]*)|0)(\.[0-9]+)?,\ (\+|\-)?(([1-9][0-9]*)|0)(\.[0-9]+)?\)$;

.* printf("INVÁLIDO: %s\n", yytext);
