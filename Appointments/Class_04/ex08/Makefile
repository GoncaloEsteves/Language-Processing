t.exe : tokenizer.o lex.yy.o
	gcc -o t.exe tokenizer.o lex.yy.o -ll

tokenizer.o : tokenizer.c tokens.h
	gcc -c tokenizer.c

lex.yy.o : lex.yy.c tokens.h
	gcc -c lex.yy.c

lex.yy.c : calc.l
	flex calc.l 