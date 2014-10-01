sources := main.cpp func.cpp

sources_ext := %.cpp %.c %.h
targets_ext := %.o




.SUFFIXES:

all: 


all: main


main: objects = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$^)) 
main: targets = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$?))
main: deps    = $(patsubst %.cpp,%.cpp.d,$^)
main: $(sources)
	echo first: $< all: $^ chanded $?
	$(MAKE) -f Makefile.executable $(targets)
	cat $(deps) > $@.d
	g++ $(objects) -o $@

-include main.d

.PHONY: clean
clean:
	rm -f main *.o *.d

