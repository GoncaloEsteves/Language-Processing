ips.exe: lex.yy.o
	gcc -o ips.exe lex.yy.o -ll

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: ex13.l
	flex ex13.l