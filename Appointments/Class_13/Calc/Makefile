calc.exe : y.tab.o lex.yy.o
	gcc -o calc.exe y.tab.o lex.yy.o -ll

y.tab.o : y.tab.c
	gcc -c y.tab.c

lex.yy.o : lex.yy.c
	gcc -c lex.yy.c

y.tab.c y.tab.h : calc.y
	yacc -d calc.y

lex.yy.c : calc.l y.tab.h
	flex calc.l

clean:
	rm -f calc.exe lex.yy.c y.tab.c y.tab.h *.o