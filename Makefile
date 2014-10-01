sources := main.cpp func.cpp

sources_ext := %.cpp %.c %.h
targets_ext := %.o

# $1 first string
# $2 second string
define is_equal
$(and $(findstring $1,$2),$(findstring $2,$1))
endef

define list_head
$(word 1,$1)
endef

define list_tail
$(wordlist 2,$(words $1),$1)
endef

# $1 input
# $2 output
define list_reverse
$(if $1,$(call list_reverse,$(call list_tail,$1),$(call list_head,$1) $2),$2)
endef

# $1 header
# $2 prereq list
#define find_list_starts_on_header
#$(foreach p,$(call list_reverse,$2),$(if ))
#endef

.SUFFIXES:

all: main




main: $(sources)

main: objects    = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$^)) 
main: targets    = $(patsubst %.cpp,%.o,$(filter $(sources_ext),$?))
main: deps       = $(patsubst %.cpp,%.cpp.d,$^)
main: rev_prereq = $(call list_reverse,$+)
main: bbb  = $(if $(and $(findstring aaa,aaba),$(findstring aaa,aaa)),equal,not equal)

main:
	echo $(bbb)
	echo first: $< all: $+ chanded $?
	echo rev_preq: $(rev_prereq)
	$(MAKE) -f Makefile.executable $(targets)
	cat $(deps) > $@.d
	g++ $(objects) -o $@

-include main.d

.PHONY: clean
clean:
	rm -f main *.o *.d

