.SUFFIXES:

all: main

main: main.o func.o
	g++ main.o func.o -o main

func.o: func.cpp
	g++ -MM func.cpp > func.cpp.d
	g++ -c func.cpp

main.o: main.cpp
	g++ -MM main.cpp > main.cpp.d
	g++ -c main.cpp

-include func.cpp.d
-include main.cpp.d


.PHONY: clean


clean:
	rm -f main main.o func.o func.cpp.d main.cpp.d

