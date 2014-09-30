.SUFFIXES:

all: 

-include main.d

all: main aaa

sources := main.cpp func.cpp

sources_ext := %.cpp %.c %.h
targets_ext := %.o

main: objects = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$^)) 
main: targets = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$?))
main: deps    = $(patsubst %.cpp,%.cpp.d,$^)
main: $(sources)
	$(MAKE) -f Makefile.executable $(targets)
	cat $(deps) > $@.d
	g++ $(objects) -o $@

aaa:
	touch aaa

.PHONY: clean
clean:
	rm -f main *.o *.d

