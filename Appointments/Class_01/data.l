%%
[0-9]{4}-(0[1-9]|1[0-2])-[0-9]{2} {int dia = atoi(yytext+8);
								   char aux[2];
								   aux[0] = yytext[5];
								   aux[1] = yytext[6];
								   int mes = atoi(aux);
								   if((mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10 || mes ==12) && (dia >= 1 && dia <= 31))
								   		printf("%s", yytext);
								   if((mes == 4 || mes == 6 || mes == 9 || mes == 11) && (dia >= 1 && dia <= 30))
								   		printf("%s", yytext);
								   if(mes == 2 && (dia >= 1 && dia <= 29))
								   		printf("%s", yytext);
								  };

. ;
