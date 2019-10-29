default:all

LIB := libgpio.a #该句要放在all之前否则all中的:$(LIB) 解析不出来

all:tips $(LIB)


tips:
	-@echo  "\033[32m Building libgpio ... \033[0m"

ifndef TOP_DIR
TOP_DIR = $(abspath $(shell pwd)/../)
endif

include $(TOP_DIR)/env.mk

INC+= -I$(TOP_DIR)/include

LD:= -lpthread

CFLAGS+=$(INC)
LDFLAGS+=$(LD)

$(LIB):gpio.o 
	-@mkdir -p ../lib
	$(Q)$(AR) cr ../lib/$@ $^ 
	@$(E) "  AR " $^
	$(Q)$(CC) -shared -fPIC -o ../lib/libgpio.so $^
	@$(E) "  Shared " $^

%.o:%.c
	$(Q)$(CC) -g -c $(CFLAGS) $< -o $@
	@$(E) "  CC " $<

clean:
	-@$(RM) *.o *.a ../lib/*.a ../lib/*.so

install:
	-@install -v ../lib/*.a $(DST_DIR)
	-@install -v ../lib/*.so $(DST_DIR)

.PHONY:clean
