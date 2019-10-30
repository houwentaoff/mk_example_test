NAME=libgpio
default:all

LIB := $(NAME).a #该句要放在all之前否则all中的:$(LIB) 解析不出来

all:tips $(LIB)

tips:
	-@echo  "\033[32m Building $(NAME) ... \033[0m"

ifndef TOP_DIR
TOP_DIR = $(abspath $(shell pwd)/../)
endif

include $(TOP_DIR)/env.mk

#CFLAGS+=$(INC)
LDFLAGS+=-lpthread
SRC-y+=gpio.c
OBJS:=$(patsubst %.c,%.o, $(SRC-y))

$(LIB):$(OBJS)
	-@mkdir -p ../lib
	$(Q)$(AR) cr ../lib/$@ $^ 
	@$(E) "  AR " $^
	$(Q)$(CC) -shared -fPIC -o ../lib/libgpio.so $^
	@$(E) "  Shared " $^

%.o:%.c
	$(Q)$(CC) -g -c $(CFLAGS) $< -o $@
	@$(E) "  CC " $<

clean:
	-@$(RM) $(OBJS) *.a ../lib/$(LIB) ../lib/*.so

install:
	-@install -v ../lib/$(LIB) $(DST_DIR)
	-@install -v ../lib/*.so $(DST_DIR)

.PHONY:clean
