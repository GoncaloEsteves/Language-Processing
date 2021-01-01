%{
#define AP   1000
#define FP   1001
#define pal  1002
#define num  1003
#define ERRO -1
%}
%option noyywrap
%%
[ \n\t\r] 	;
\( 			return(AP);
\) 			return(FP);
[a-zA-Z]+ 	return(pal);
[0-9]+ 		return(num);

. 			return(ERRO);
%%
