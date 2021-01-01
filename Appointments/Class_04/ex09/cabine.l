%{
	int saldo = 0;
%}
%x onoff moeda
%%
	BEGIN 0;

LEVANTAR					BEGIN onoff;
<onoff>POUSAR				{
			   					BEGIN 0;
			   					printf("Troco devolvido: %d euros e %d centimos.\n", saldo/100, saldo%100);
			   					saldo = 0;
			  				}			  
<onoff>MOEDA 				BEGIN moeda;
<onoff>T=(601|641)[0-9]{6}	printf("Os números vermelhos estão proibidos.\n");
<onoff>T=00[0-9]+				{
								if(saldo >= 150)
									saldo -= 150;
								else
									printf("Saldo Insuficiente.\n");
							}
<onoff>T=2[0-9]{8}			{
								if(saldo >= 25)
									saldo -= 25;
								else
									printf("Saldo Insuficiente.\n");
							}
<onoff>T=800[0-9]{6}			;
<onoff>T=808[0-9]{6}			{
								if(saldo >= 10)
									saldo -= 10;
								else
									printf("Saldo Insuficiente.\n");
							}

<moeda>\. 					{
								printf("Saldo disponivel: %d euros e %d centimos.\n", saldo/100, saldo%100);
								BEGIN onoff;
							}
<moeda>,  					;	
<moeda>10c 					saldo+=10;
<moeda>20c 					saldo+=20;
<moeda>50c 					saldo+=50;
<moeda>1e 					saldo+=100;
<moeda>2e 					saldo+=200;
<moeda>[^,.\n\ \t]+   			printf("Moeda Invalida: %s\n", yytext);

<*>.|\n         			;
