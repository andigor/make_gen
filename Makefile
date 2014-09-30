.SUFFIXES:

all: 

-include main.d

all: main

sources := main.cpp func.cpp

sources_ext := %.cpp %.c
targets_ext := %.o

main: objects = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$^)) 
main: targets = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$^))
main: deps    = $(patsubst %.cpp,%.cpp.d,$^)
main: main.d
	$(MAKE) -f Makefile.executable $(targets)
	g++ $(objects) -o $@

main.d:
	g++ -MM -MT main $(sources) > main.d

.PHONY: clean
clean:
	rm -f main *.o *.d

