# Manually generated by programmer 

# Visual C++
#CC = cl
DEBUG = -g
# GCC
#CC = gcc -efence -Wall -pedantic
CC = gcc -Wall -pedantic
YACC = bison -v -y
LEX = flex
LIBS =
#LIBS = -lefence
#LIBS = -ll -ly

HEADERS = cola.h parser.h

default :
	chmod 775 colac
	$(MAKE) x
	cp x colacc

nogen : gen.o semant.o sym.o type.o
	$(CC) $(DEBUG) -c parser.c
	$(CC) $(DEBUG) -c lexer.c
	$(CC) $(DEBUG) -o x parser.o lexer.o gen.o semant.o sym.o type.o $(LIBS)

clean :
	rm -f core
	rm -f *.o *.imc
	rm -f parser.h parser.output
	rm -f lexer.c parser.c
	rm -f x

publish :
	perl publish.pl < MANIFEST

dist :
	perl distribution.pl < MANIFEST

parser.c : cola.y
	$(YACC) -d -o parser.c cola.y

lexer.c : cola.l $(HEADERS) 
	$(LEX) cola.l

lexer.o : lexer.c $(HEADERS) 
	$(CC) $(DEBUG) -c lexer.c

parser.o : parser.c $(HEADERS)
	$(CC) $(DEBUG) -c parser.c

semant.o : semant.c $(HEADERS)
	$(CC) $(DEBUG) -c semant.c

sym.o : sym.c $(HEADERS)
	$(CC) $(DEBUG) -c sym.c

type.o : type.c $(HEADERS)
	$(CC) $(DEBUG) -c type.c

gen.o : gen.c $(HEADERS)
	$(CC) $(DEBUG) -c gen.c

x : parser.o lexer.o gen.o semant.o sym.o type.o
	$(CC) $(DEBUG) -o x parser.o lexer.o gen.o semant.o sym.o type.o $(LIBS)

