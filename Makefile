.SUFFIXES:

include user.mk

define list_head
$(word 1,$1)
endef

define list_tail
$(wordlist 2,$(words $1),$1)
endef


src_ext := %.c %.cpp

# $1 head
# $2 tail
# $3 file_name
define src_name
  $(if $1
     ,$(if $(filter $1,$3)
        ,$(patsubst $1,%,$3)
        ,$(call src_name,$(call list_head,$2),$(call list_tail,$2),$3)
      )
     ,$(error not found "$3") 
  )
endef

# $1 file_name
define get_src_name
$(strip $(call src_name,$(call list_head,$(src_ext)),$(call list_tail,$(src_ext)),$1))
endef

define process_dir
$(foreach t,$(TARGETS),$(call process_$($t.TYPE)_target,$t))
endef

# $1 target name
define process_executable_target
$1: $(addsuffix .o,$(foreach s,$($1.SRCS),$(call get_src_name,$(s))))
	g++ -o $$@ $$^
$(foreach s,$($1.SRCS),$(call process_obj_$(suffix $(s))_target,$(call get_src_name,$(s))))
ALL_TARGETS += $1	
endef

# $1 base name
#
define process_obj_.cpp_target

$1.o: $1.cpp
	g++ -MM $$^ > $1.d
	g++ -c $$^
ALL_DEPS_FILES += $1.d
endef



aa := $(call process_dir)
#$(warning $(aa))
$(eval $(aa))


all: $(ALL_TARGETS)

.PHONY: clean
clean:
	rm -f *.o *.d *.gch

-include $(ALL_DEPS_FILES)

