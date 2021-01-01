exp.exe : y.tab.o lex.yy.o
	gcc -o exp.exe y.tab.o lex.yy.o -ll

y.tab.o : y.tab.c
	gcc -c y.tab.c

lex.yy.o : lex.yy.c
	gcc -c lex.yy.c

y.tab.c y.tab.h : exp.y
	yacc -d exp.y

lex.yy.c : exp.l y.tab.h
	flex exp.l